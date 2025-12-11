import { Component, signal } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { IonicModule } from '@ionic/angular';
import { Router } from '@angular/router';
import { CarritoService, VentaService, AuthService } from '../../core/services';
import { CrearVentaDTO, DetalleVentaDTO, CabeceraVentaDTO, calcularPrecioFinal, getProductoId, getProductoNombre } from '../../core/models';

@Component({
    selector: 'app-checkout',
    templateUrl: './checkout.page.html',
    styleUrls: ['./checkout.page.scss'],
    standalone: true,
    imports: [CommonModule, FormsModule, IonicModule]
})
export class CheckoutPage {
    procesando = signal<boolean>(false);
    metodoPago = signal<string>('efectivo');
    calcularPrecioFinal = calcularPrecioFinal;
    getProductoId = getProductoId;
    getProductoNombre = getProductoNombre;

    constructor(
        public carritoService: CarritoService,
        private ventaService: VentaService,
        public authService: AuthService,
        private router: Router
    ) { }

    seleccionarMetodoPago(metodo: string) {
        this.metodoPago.set(metodo);
    }

    async confirmarCompra() {
        if (this.procesando()) return;

        this.procesando.set(true);

        try {
            const carritoActual = this.carritoService.carrito();
            const usuario = this.authService.usuarioActual();

            // Calcular totales
            const subTotal = carritoActual.subtotal;
            const descuentoTotal = carritoActual.items.reduce((total, item) => {
                const precioOriginal = (item.producto as any)['precioVentaProd'] || 0;
                const descuento = (item.producto as any)['dctoPromoProd'] || 0;
                const descuentoItem = (precioOriginal * descuento / 100) * item.cantidad;
                return total + descuentoItem;
            }, 0);
            const total = carritoActual.total;
            const cantidadTotal = carritoActual.items.reduce((sum, item) => sum + item.cantidad, 0);

            // Preparar los detalles de la venta
            const detalles: DetalleVentaDTO[] = carritoActual.items.map(item => {
                const precioUnitario = calcularPrecioFinal(item.producto);
                const subtotal = precioUnitario * item.cantidad;
                return {
                    ideDetaVent: -1,
                    ideVent: -1,
                    ideProd: getProductoId(item.producto),
                    cantidadProd: item.cantidad,
                    precioUnitarioProd: precioUnitario,
                    subtotalProd: subtotal,
                    dctoProd: 0,
                    dctoPromo: (item.producto as any)['dctoPromoProd'] ?? 0,
                    ivaProd: (item.producto as any)['ivaProd'] ?? 0
                };
            });

            // Generar número de factura temporal
            const numFactura = `FACT-${Date.now()}`;

            // Crear la venta con la estructura completa
            const ventaData: CrearVentaDTO = {
                cabeceraVenta: {
                    ideVent: -1,
                    ideEmpl: usuario?.ide_empl || 0,
                    ideClie: usuario?.id || usuario?.ide_cuen || 0,
                    numFacturaVent: numFactura,
                    fechaVent: new Date().toISOString(),
                    cantidadVent: cantidadTotal,
                    subTotalVent: subTotal,
                    totalVent: total,
                    dctoVent: descuentoTotal,
                    estadoVent: 'completado'
                },
                detalleVenta: detalles
            };

            console.log('=== Datos a enviar al backend ===');
            console.log('Usuario:', usuario);
            console.log('Venta Data:', JSON.stringify(ventaData, null, 2));
            console.log('================================');

            this.ventaService.crearVenta(ventaData).subscribe({
                next: (venta) => {
                    // Limpiar carrito
                    this.carritoService.limpiarCarrito();

                    // Mostrar confirmación
                    this.mostrarConfirmacion();

                    // Redirigir al historial
                    setTimeout(() => {
                        this.router.navigate(['/perfil/historial']);
                    }, 2000);
                },
                error: (error) => {
                    console.error('Error al crear la venta:', error);
                    console.error('Mensaje del backend:', error?.error?.message);
                    console.error('Detalles:', error?.error);
                    this.mostrarError();
                    this.procesando.set(false);
                }
            });
        } catch (error) {
            console.error('Error en checkout:', error);
            this.mostrarError();
            this.procesando.set(false);
        }
    }

    async mostrarConfirmacion() {
        // Implementar con ion-toast o ion-alert
        console.log('Compra realizada con éxito');
    }

    async mostrarError() {
        // Implementar con ion-toast o ion-alert
        console.error('Error al procesar la compra');
    }

    volverAlCarrito() {
        this.router.navigate(['/carrito']);
    }
}
