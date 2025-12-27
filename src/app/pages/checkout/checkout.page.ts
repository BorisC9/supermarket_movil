import { Component, signal } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { IonicModule, ToastController, AlertController } from '@ionic/angular';
import { Router } from '@angular/router';
import { CarritoService, VentaService, AuthService } from '../../core/services';
import { CrearVentaDTO, CabeceraVentaDTO, DetalleVentaDTO, calcularPrecioFinal, getProductoId, getProductoNombre } from '../../core/models';

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
        private router: Router,
        private toastController: ToastController,
        private alertController: AlertController
    ) { }

    seleccionarMetodoPago(metodo: string) {
        this.metodoPago.set(metodo);
    }

    async confirmarCompra() {
        if (this.procesando()) return;

        const usuario = this.authService.usuarioActual();
        if (!usuario?.ide_clie) {
            await this.mostrarError('Debes iniciar sesión para realizar una compra');
            this.router.navigate(['/auth/login']);
            return;
        }

        this.procesando.set(true);

        try {
            const carritoActual = this.carritoService.carrito();
            const cantidadTotal = carritoActual.items.reduce((sum, item) => sum + item.cantidad, 0);

            // Preparar los detalles de la venta
            const detalles: DetalleVentaDTO[] = carritoActual.items.map(item => {
                const precioUnitario = calcularPrecioFinal(item.producto);
                const dctoPromoPercent = (item.producto as any)['dctoPromoProd'] ?? 0;
                const subtotal = precioUnitario * item.cantidad;
                const descuentoPromoMonto = (precioUnitario * dctoPromoPercent / 100) * item.cantidad;
                const totalProd = subtotal - descuentoPromoMonto;

                return {
                    ideProd: getProductoId(item.producto),
                    cantidadProd: item.cantidad,
                    precioUnitarioProd: precioUnitario,
                    subtotalProd: subtotal,
                    dctoPromoProd: descuentoPromoMonto,
                    ivaProd: (item.producto as any)['ivaProd'] ?? 0,
                    totalProd: totalProd
                };
            });

            // Generar número de factura temporal
            const numFactura = `MOV-${Date.now()}`;

            // Crear cabecera de venta
            const cabeceraVenta: CabeceraVentaDTO = {
                ideClie: usuario.ide_clie,
                numFacturaVent: numFactura,
                fechaVent: new Date().toISOString(),
                cantidadVent: cantidadTotal,
                subTotalVent: carritoActual.subtotal,
                totalVent: carritoActual.total,
                dctoSocioVent: 0,  // Se puede calcular en backend si el cliente es socio
                dctoEdadVent: 0,   // Se puede calcular en backend si el cliente es tercera edad
                usuaIngre: usuario.username || 'mobile'
            };

            // Crear la venta
            const ventaData: CrearVentaDTO = {
                cabeceraVenta,
                detalleVenta: detalles
            };

            this.ventaService.crearVenta(ventaData).subscribe({
                next: async (response) => {
                    // Limpiar carrito
                    this.carritoService.limpiarCarrito();

                    // Mostrar confirmación
                    await this.mostrarConfirmacion();

                    // Redirigir al historial de compras
                    this.router.navigate(['/usuario/historial-compras']);
                },
                error: async (error) => {
                    console.error('Error al realizar la venta:', error);
                    await this.mostrarError(error?.error?.message || 'Error al procesar la compra');
                    this.procesando.set(false);
                }
            });
        } catch (error) {
            console.error('Error en checkout:', error);
            await this.mostrarError('Error al procesar la compra');
            this.procesando.set(false);
        }
    }

    async mostrarConfirmacion() {
        const toast = await this.toastController.create({
            message: '¡Compra realizada con éxito!',
            duration: 3000,
            position: 'top',
            color: 'success',
            icon: 'checkmark-circle-outline'
        });
        await toast.present();
    }

    async mostrarError(mensaje: string) {
        const alert = await this.alertController.create({
            header: 'Error',
            message: mensaje,
            buttons: ['OK']
        });
        await alert.present();
    }

    volverAlCarrito() {
        this.router.navigate(['/carrito']);
    }
}
