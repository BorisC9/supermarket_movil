import { Component, signal } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { IonicModule, ToastController } from '@ionic/angular';
import { Router } from '@angular/router';
import { MetodoPagoService } from '../../../core/services';
import { 
    CreateMetodoPagoDTO, MarcaTarjeta,
    detectarMarcaTarjeta, enmascararTarjeta, formatearNumeroTarjeta,
    formatearFechaExpiracion, getNombreMarca, validarEmail 
} from '../../../core/models';

type TipoMetodo = 'tarjeta' | 'paypal';

/**
 * Página para agregar nuevos métodos de pago (tarjeta o PayPal).
 */
@Component({
    selector: 'app-agregar-tarjeta',
    templateUrl: './agregar-tarjeta.page.html',
    styleUrls: ['./agregar-tarjeta.page.scss'],
    standalone: true,
    imports: [CommonModule, FormsModule, IonicModule]
})
export class AgregarTarjetaPage {

    // Estado
    readonly tipoSeleccionado = signal<TipoMetodo>('tarjeta');
    readonly procesando = signal(false);
    readonly marcaDetectada = signal<MarcaTarjeta | null>(null);

    // Campos comunes
    nombreTitular = '';
    esPredeterminado = false;

    // Campos tarjeta
    numeroTarjeta = '';
    fechaExpiracion = '';
    cvv = '';
    alias = '';
    tipoTarjeta: 'tarjeta_credito' | 'tarjeta_debito' = 'tarjeta_credito';

    // Campos PayPal
    emailPaypal = '';
    aliasPaypal = '';

    // Helper exportado al template
    getNombreMarca = getNombreMarca;

    constructor(
        private metodoPagoService: MetodoPagoService,
        private router: Router,
        private toastController: ToastController
    ) { }

    // =====================================
    // SELECCIÓN Y FORMATEO
    // =====================================

    seleccionarTipo(tipo: TipoMetodo) {
        this.tipoSeleccionado.set(tipo);
    }

    onNumeroTarjetaChange(event: any) {
        const valor = event.detail.value || '';
        this.numeroTarjeta = formatearNumeroTarjeta(valor);
        this.marcaDetectada.set(detectarMarcaTarjeta(valor));
    }

    onFechaExpiracionChange(event: any) {
        const valor = event.detail.value || '';
        this.fechaExpiracion = formatearFechaExpiracion(valor);
    }

    getIconoMarca(): string {
        return this.marcaDetectada() ? 'card' : 'card-outline';
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
        return validarEmail(this.emailPaypal) && this.nombreTitular.trim().length >= 3;
    }

    // =====================================
    // GUARDAR MÉTODO DE PAGO
    // =====================================

    async guardarMetodoPago() {
        if (this.procesando()) return;

        const esTarjeta = this.tipoSeleccionado() === 'tarjeta';
        const esValido = esTarjeta ? this.validarFormularioTarjeta() : this.validarFormularioPaypal();

        if (!esValido) {
            await this.mostrarToast('Por favor completa todos los campos correctamente', 'warning');
            return;
        }

        this.procesando.set(true);
        const metodo = this.construirMetodoPagoDTO(esTarjeta);

        this.metodoPagoService.crearMetodoPago(metodo).subscribe({
            next: () => this.onGuardadoExitoso(esTarjeta),
            error: () => this.onGuardadoError(esTarjeta)
        });
    }

    private construirMetodoPagoDTO(esTarjeta: boolean): CreateMetodoPagoDTO {
        const esPredeterminado = this.esPredeterminado ? 'si' : 'no';

        if (esTarjeta) {
            return {
                tipoPago: this.tipoTarjeta,
                nombreTitular: this.nombreTitular.toUpperCase(),
                numeroTarjetaMasked: enmascararTarjeta(this.numeroTarjeta),
                marcaTarjeta: this.marcaDetectada() || undefined,
                fechaExpiracion: this.fechaExpiracion,
                esPredeterminado,
                alias: this.alias || undefined
            };
        }

        return {
            tipoPago: 'paypal',
            nombreTitular: this.nombreTitular,
            emailPaypal: this.emailPaypal,
            esPredeterminado,
            alias: this.aliasPaypal || 'Mi PayPal'
        };
    }

    private async onGuardadoExitoso(esTarjeta: boolean) {
        this.procesando.set(false);
        await this.mostrarToast(esTarjeta ? 'Tarjeta agregada correctamente' : 'PayPal agregado correctamente');
        this.router.navigate(['/usuario/metodos-pago']);
    }

    private async onGuardadoError(esTarjeta: boolean) {
        this.procesando.set(false);
        await this.mostrarToast(esTarjeta ? 'Error al agregar la tarjeta' : 'Error al agregar PayPal', 'danger');
    }

    // =====================================
    // UTILIDADES UI
    // =====================================

    private async mostrarToast(mensaje: string, color = 'success') {
        const toast = await this.toastController.create({
            message: mensaje,
            duration: 2000,
            position: 'bottom',
            color
        });
        await toast.present();
    }
}
