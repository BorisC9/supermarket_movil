import { Component, signal, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { IonicModule, ToastController, AlertController } from '@ionic/angular';
import { Router } from '@angular/router';
import { CarritoService, VentaService, AuthService, MetodoPagoService } from '../../core/services';
import { 
    CrearVentaDTO, CabeceraVentaDTO, DetalleVentaDTO, 
    MetodoPago, CreateMetodoPagoDTO, MarcaTarjeta,
    calcularPrecioFinal, getProductoId, getProductoNombre, 
    getNombreTipoPago, getNombreMarca, detectarMarcaTarjeta,
    enmascararTarjeta, formatearNumeroTarjeta, formatearFechaExpiracion, validarEmail
} from '../../core/models';

type TipoPagoDirecto = 'efectivo' | 'tarjeta' | 'paypal';

/**
 * Página de checkout para finalizar la compra.
 * Permite seleccionar método de pago guardado o ingresar datos nuevos.
 */
@Component({
    selector: 'app-checkout',
    templateUrl: './checkout.page.html',
    styleUrls: ['./checkout.page.scss'],
    standalone: true,
    imports: [CommonModule, FormsModule, IonicModule]
})
export class CheckoutPage implements OnInit {
    
    // Estado de la página
    procesando = signal(false);
    metodoPago = signal<TipoPagoDirecto>('efectivo');
    metodoGuardadoSeleccionado = signal<MetodoPago | null>(null);
    marcaDetectada = signal<MarcaTarjeta | null>(null);
    
    // Formulario de tarjeta
    numeroTarjeta = '';
    nombreTitular = '';
    fechaExpiracion = '';
    cvv = '';
    tipoTarjeta: 'tarjeta_credito' | 'tarjeta_debito' = 'tarjeta_credito';
    
    // Formulario de PayPal
    emailPaypal = '';
    nombrePaypal = '';
    
    // Opción para guardar
    guardarMetodo = false;
    
    // Funciones helper exportadas al template
    calcularPrecioFinal = calcularPrecioFinal;
    getProductoId = getProductoId;
    getProductoNombre = getProductoNombre;
    getNombreTipoPago = getNombreTipoPago;
    getNombreMarca = getNombreMarca;

    constructor(
        public carritoService: CarritoService,
        private ventaService: VentaService,
        public authService: AuthService,
        public metodoPagoService: MetodoPagoService,
        private router: Router,
        private toastController: ToastController,
        private alertController: AlertController
    ) { }

    ngOnInit() {
        this.cargarMetodosPago();
    }

    ionViewWillEnter() {
        this.cargarMetodosPago();
        this.limpiarFormularios();
    }

    // =====================================
    // MÉTODOS DE CARGA Y SELECCIÓN
    // =====================================

    cargarMetodosPago() {
        if (!this.authService.usuarioActual()) return;
        
        this.metodoPagoService.obtenerMetodosPago().subscribe(metodos => {
            const predeterminado = metodos.find(m => m.esPredeterminado === 'si');
            if (predeterminado) {
                this.seleccionarMetodoGuardado(predeterminado);
            }
        });
    }

    limpiarFormularios() {
        this.numeroTarjeta = '';
        this.nombreTitular = '';
        this.fechaExpiracion = '';
        this.cvv = '';
        this.emailPaypal = '';
        this.nombrePaypal = '';
        this.guardarMetodo = false;
        this.marcaDetectada.set(null);
    }

    seleccionarMetodoPago(metodo: TipoPagoDirecto) {
        this.metodoPago.set(metodo);
        this.metodoGuardadoSeleccionado.set(null);
    }

    seleccionarMetodoGuardado(metodo: MetodoPago) {
        this.metodoGuardadoSeleccionado.set(metodo);
        this.metodoPago.set(metodo.tipoPago as TipoPagoDirecto);
    }

    irAAgregarMetodoPago() {
        this.router.navigate(['/usuario/agregar-tarjeta']);
    }

    getIconoTipoPago(metodo: MetodoPago): string {
        return metodo.tipoPago === 'paypal' ? 'logo-paypal' : 'card';
    }

    // =====================================
    // FORMATEO DE INPUTS
    // =====================================

    onNumeroTarjetaChange(event: any) {
        const valor = event.detail.value || '';
        this.numeroTarjeta = formatearNumeroTarjeta(valor);
        this.marcaDetectada.set(detectarMarcaTarjeta(valor));
    }

    onFechaExpiracionChange(event: any) {
        const valor = event.detail.value || '';
        this.fechaExpiracion = formatearFechaExpiracion(valor);
    }

    // =====================================
    // VALIDACIONES
    // =====================================

    private get numeroTarjetaLimpio(): string {
        return this.numeroTarjeta.replace(/\s/g, '');
    }

    validarFormularioTarjeta(): boolean {
        return (
            this.numeroTarjetaLimpio.length >= 15 &&
            this.nombreTitular.trim().length >= 3 &&
            this.fechaExpiracion.length === 5 &&
            this.cvv.length >= 3
        );
    }

    validarFormularioPaypal(): boolean {
        return validarEmail(this.emailPaypal) && this.nombrePaypal.trim().length >= 3;
    }

    puedeConfirmarCompra(): boolean {
        if (this.metodoGuardadoSeleccionado()) return true;
        
        switch (this.metodoPago()) {
            case 'efectivo': return true;
            case 'tarjeta': return this.validarFormularioTarjeta();
            case 'paypal': return this.validarFormularioPaypal();
            default: return false;
        }
    }

    // =====================================
    // PROCESO DE COMPRA
    // =====================================

    async confirmarCompra() {
        if (this.procesando()) return;

        const usuario = this.authService.usuarioActual();
        if (!usuario?.ide_clie) {
            await this.mostrarError('Debes iniciar sesión para realizar una compra');
            this.router.navigate(['/auth/login']);
            return;
        }

        if (!this.validarFormularioPagoDirecto()) return;

        this.procesando.set(true);

        try {
            if (this.guardarMetodo && !this.metodoGuardadoSeleccionado()) {
                await this.guardarMetodoPagoFn();
            }

            const ventaData = this.construirVentaDTO(usuario);
            
            this.ventaService.crearVenta(ventaData).subscribe({
                next: () => this.onCompraExitosa(),
                error: (error) => this.onCompraError(error)
            });
        } catch {
            this.onCompraError(null);
        }
    }

    private async validarFormularioPagoDirecto(): Promise<boolean> {
        if (this.metodoGuardadoSeleccionado()) return true;

        if (this.metodoPago() === 'tarjeta' && !this.validarFormularioTarjeta()) {
            await this.mostrarError('Por favor completa todos los datos de la tarjeta');
            return false;
        }
        if (this.metodoPago() === 'paypal' && !this.validarFormularioPaypal()) {
            await this.mostrarError('Por favor completa todos los datos de PayPal');
            return false;
        }
        return true;
    }

    private construirVentaDTO(usuario: any): CrearVentaDTO {
        const carritoActual = this.carritoService.carrito();
        const cantidadTotal = carritoActual.items.reduce((sum, item) => sum + item.cantidad, 0);
        
        const detalles = this.construirDetallesVenta(carritoActual.items);
        const { tipoPago, ideMetoPago } = this.obtenerInfoPago();

        const cabeceraVenta: CabeceraVentaDTO = {
            ideClie: usuario.ide_clie,
            numFacturaVent: `MOV-${Date.now()}`,
            fechaVent: new Date().toISOString(),
            cantidadVent: cantidadTotal,
            subTotalVent: carritoActual.subtotal,
            totalVent: carritoActual.total,
            dctoSocioVent: 0,
            dctoEdadVent: 0,
            usuaIngre: usuario.username || 'mobile',
            tipoPagoVent: tipoPago,
            ideMetoPago
        };

        return { cabeceraVenta, detalleVenta: detalles };
    }

    private construirDetallesVenta(items: any[]): DetalleVentaDTO[] {
        return items.map(item => {
            const precioUnitario = calcularPrecioFinal(item.producto);
            const dctoPromoPercent = (item.producto as any)['dctoPromoProd'] ?? 0;
            const subtotal = precioUnitario * item.cantidad;
            const descuentoPromoMonto = (precioUnitario * dctoPromoPercent / 100) * item.cantidad;

            return {
                ideProd: getProductoId(item.producto),
                cantidadProd: item.cantidad,
                precioUnitarioProd: precioUnitario,
                subtotalProd: subtotal,
                dctoPromoProd: descuentoPromoMonto,
                ivaProd: (item.producto as any)['ivaProd'] ?? 0,
                totalProd: subtotal - descuentoPromoMonto
            };
        });
    }

    private obtenerInfoPago(): { tipoPago: string; ideMetoPago?: number } {
        const metodoGuardado = this.metodoGuardadoSeleccionado();
        
        if (metodoGuardado) {
            return { tipoPago: metodoGuardado.tipoPago, ideMetoPago: metodoGuardado.ideMetoPago };
        }
        
        const tipoPago = this.metodoPago() === 'tarjeta' ? this.tipoTarjeta : this.metodoPago();
        return { tipoPago };
    }

    private async onCompraExitosa() {
        this.carritoService.limpiarCarrito();
        await this.mostrarConfirmacion();
        this.router.navigate(['/usuario/historial-compras']);
    }

    private async onCompraError(error: any) {
        await this.mostrarError(error?.error?.message || 'Error al procesar la compra');
        this.procesando.set(false);
    }

    // =====================================
    // GUARDAR MÉTODO DE PAGO
    // =====================================

    private guardarMetodoPagoFn(): Promise<void> {
        return new Promise(resolve => {
            const metodo = this.construirMetodoPagoDTO();

            this.metodoPagoService.crearMetodoPago(metodo).subscribe({
                next: () => resolve(),
                error: () => resolve() // Continuar con la compra aunque no se guarde
            });
        });
    }

    private construirMetodoPagoDTO(): CreateMetodoPagoDTO {
        if (this.metodoPago() === 'tarjeta') {
            return {
                tipoPago: this.tipoTarjeta,
                nombreTitular: this.nombreTitular.toUpperCase(),
                numeroTarjetaMasked: enmascararTarjeta(this.numeroTarjeta),
                marcaTarjeta: this.marcaDetectada() || undefined,
                fechaExpiracion: this.fechaExpiracion,
                esPredeterminado: 'no'
            };
        }
        
        return {
            tipoPago: 'paypal',
            nombreTitular: this.nombrePaypal,
            emailPaypal: this.emailPaypal,
            esPredeterminado: 'no',
            alias: 'Mi PayPal'
        };
    }

    // =====================================
    // UTILIDADES UI
    // =====================================

    private async mostrarConfirmacion() {
        const toast = await this.toastController.create({
            message: '¡Compra realizada con éxito!',
            duration: 3000,
            position: 'top',
            color: 'success',
            icon: 'checkmark-circle-outline'
        });
        await toast.present();
    }

    private async mostrarError(mensaje: string) {
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
