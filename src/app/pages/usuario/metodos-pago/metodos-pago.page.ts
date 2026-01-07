import { Component, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { IonicModule, AlertController, ToastController } from '@ionic/angular';
import { Router } from '@angular/router';
import { MetodoPagoService } from '../../../core/services';
import { MetodoPago, getNombreTipoPago } from '../../../core/models';

/** Colores por marca de tarjeta */
const COLORES_MARCA: Record<string, string> = {
    visa: '#1A1F71',
    mastercard: '#EB001B',
    amex: '#006FCF'
};

/**
 * Página para gestionar los métodos de pago guardados del usuario.
 */
@Component({
    selector: 'app-metodos-pago',
    templateUrl: './metodos-pago.page.html',
    styleUrls: ['./metodos-pago.page.scss'],
    standalone: true,
    imports: [CommonModule, IonicModule]
})
export class MetodosPagoPage implements OnInit {

    // Helper exportado al template
    getNombreTipoPago = getNombreTipoPago;

    constructor(
        public metodoPagoService: MetodoPagoService,
        private router: Router,
        private alertController: AlertController,
        private toastController: ToastController
    ) { }

    ngOnInit() {
        this.cargarMetodosPago();
    }

    ionViewWillEnter() {
        this.cargarMetodosPago();
    }

    // =====================================
    // OPERACIONES CRUD
    // =====================================

    cargarMetodosPago() {
        this.metodoPagoService.obtenerMetodosPago().subscribe();
    }

    agregarMetodoPago() {
        this.router.navigate(['/usuario/agregar-tarjeta']);
    }

    async establecerPredeterminado(metodo: MetodoPago) {
        if (metodo.esPredeterminado === 'si') return;

        this.metodoPagoService.establecerPredeterminado(metodo.ideMetoPago).subscribe({
            next: () => this.mostrarToast('Método de pago establecido como predeterminado'),
            error: () => this.mostrarToast('Error al establecer como predeterminado', 'danger')
        });
    }

    async confirmarEliminar(metodo: MetodoPago) {
        const descripcion = metodo.alias || this.getDescripcionMetodo(metodo);
        
        const alert = await this.alertController.create({
            header: 'Eliminar método de pago',
            message: `¿Estás seguro de eliminar ${descripcion}?`,
            buttons: [
                { text: 'Cancelar', role: 'cancel' },
                { text: 'Eliminar', role: 'destructive', handler: () => this.eliminarMetodo(metodo) }
            ]
        });
        await alert.present();
    }

    private eliminarMetodo(metodo: MetodoPago) {
        this.metodoPagoService.eliminarMetodoPago(metodo.ideMetoPago).subscribe({
            next: () => this.mostrarToast('Método de pago eliminado'),
            error: () => this.mostrarToast('Error al eliminar el método de pago', 'danger')
        });
    }

    // =====================================
    // HELPERS DE VISUALIZACIÓN
    // =====================================

    getDescripcionMetodo(metodo: MetodoPago): string {
        return metodo.tipoPago === 'paypal' 
            ? (metodo.emailPaypal || 'PayPal')
            : (metodo.numeroTarjetaMasked || 'Tarjeta');
    }

    getIconoTipoPago(metodo: MetodoPago): string {
        return metodo.tipoPago === 'paypal' ? 'logo-paypal' : 'card';
    }

    getColorMarca(marca?: string): string {
        return COLORES_MARCA[marca?.toLowerCase() ?? ''] || 'var(--ion-color-primary)';
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
