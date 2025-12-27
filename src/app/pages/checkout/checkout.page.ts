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
            const descuentoPromoTotal = carritoActual.items.reduce((total, item) => {
                const precioOriginal = (item.producto as any)['precioVentaProd'] || 0;
                const descuento = (item.producto as any)['dctoPromoProd'] || 0;
                const descuentoItem = (precioOriginal * descuento / 100) * item.cantidad;
                return total + descuentoItem;
            }, 0);
            const total = carritoActual.total;
            const cantidadTotal = carritoActual.items.reduce((sum, item) => sum + item.cantidad, 0);

            // Preparar los detalles de la venta
            const detalles: any[] = carritoActual.items.map(item => {
                const precioUnitario = calcularPrecioFinal(item.producto);
                const dctoPromoPercent = (item.producto as any)['dctoPromoProd'] ?? 0;
                const subtotal = precioUnitario * item.cantidad;
                const descuentoPromoMonto = (precioUnitario * dctoPromoPercent / 100) * item.cantidad;
                const totalProd = subtotal - descuentoPromoMonto;

                return {
                    ideDetaVent: -1,
                    ideVent: -1,
                    ideProd: getProductoId(item.producto),
                    cantidadProd: item.cantidad,
                    precioUnitarioProd: precioUnitario,
                    subtotalProd: subtotal,
                    dctoProd: 0,
                    dctoPromo: descuentoPromoMonto,
                    ivaProd: (item.producto as any)['ivaProd'] ?? 0,
                    totalProd: totalProd
                };
            });

            // Calcular descuentos según tipo de cliente
            // TODO: Obtener información del cliente desde el backend para saber si es socio o tercera edad
            const dctoSocio = 0; // Se calcula en el backend según el cliente
            const dctoEdad = 0; // Se calcula en el backend según el cliente

            // Generar número de factura temporal
            const numFactura = `FACT-${Date.now()}`;

            // Crear la venta con la estructura completa
            const ventaData: CrearVentaDTO = {
                cabeceraVenta: {
                    ideVent: -1,
                    ideEmpl: usuario?.ide_empl || 1,
                    ideClie: usuario?.ide_clie || 0,
                    numFacturaVent: numFactura,
                    fechaVent: new Date().toISOString(),
                    cantidadVent: cantidadTotal,
                    subTotalVent: subTotal,
                    totalVent: total,
                    dctoVent: dctoSocio + dctoEdad,
                    estadoVent: 'completado',
                    usuaIngre: usuario?.username || 'web'
                },
                detalleVenta: detalles
            };

            // Datos preparados para el backend (omitidos logs en producción)

            this.ventaService.crearVenta(ventaData).subscribe({
                next: (venta) => {
                    // Limpiar carrito
                    this.carritoService.limpiarCarrito();

                    // Mostrar confirmación
                    this.mostrarConfirmacion();

                    // Redirigir al historial de compras
                    setTimeout(() => {
                        this.router.navigate(['/perfil/historial-compras']);
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
        // Compra realizada con éxito
    }

    async mostrarError() {
        // Implementar con ion-toast o ion-alert
        console.error('Error al procesar la compra');
    }

    volverAlCarrito() {
        this.router.navigate(['/carrito']);
    }
}
