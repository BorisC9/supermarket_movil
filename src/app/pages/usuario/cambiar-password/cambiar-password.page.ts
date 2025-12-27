import { Component, signal } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormBuilder, FormGroup, ReactiveFormsModule, Validators } from '@angular/forms';
import { IonicModule, ToastController, AlertController } from '@ionic/angular';
import { Router } from '@angular/router';
import { ClienteService, CambiarPasswordDTO } from '../../../core/services/cliente.service';

@Component({
    selector: 'app-cambiar-password',
    templateUrl: './cambiar-password.page.html',
    styleUrls: ['./cambiar-password.page.scss'],
    standalone: true,
    imports: [CommonModule, ReactiveFormsModule, IonicModule]
})
export class CambiarPasswordPage {
    passwordForm!: FormGroup;
    guardando = signal<boolean>(false);
    mostrarPasswordActual = signal<boolean>(false);
    mostrarPasswordNuevo = signal<boolean>(false);
    mostrarPasswordConfirmar = signal<boolean>(false);

    constructor(
        private fb: FormBuilder,
        private clienteService: ClienteService,
        private router: Router,
        private toastController: ToastController,
        private alertController: AlertController
    ) {
        this.crearFormulario();
    }

    crearFormulario() {
        this.passwordForm = this.fb.group({
            passwordActual: ['', [Validators.required, Validators.minLength(1)]],
            passwordNuevo: ['', [Validators.required, Validators.minLength(6)]],
            passwordConfirmar: ['', [Validators.required, Validators.minLength(6)]]
        }, {
            validators: this.validarPasswordsIguales
        });
    }

    validarPasswordsIguales(group: FormGroup) {
        const nuevo = group.get('passwordNuevo')?.value;
        const confirmar = group.get('passwordConfirmar')?.value;
        return nuevo === confirmar ? null : { passwordsNoCoinciden: true };
    }

    toggleMostrarPasswordActual() {
        this.mostrarPasswordActual.set(!this.mostrarPasswordActual());
    }

    toggleMostrarPasswordNuevo() {
        this.mostrarPasswordNuevo.set(!this.mostrarPasswordNuevo());
    }

    toggleMostrarPasswordConfirmar() {
        this.mostrarPasswordConfirmar.set(!this.mostrarPasswordConfirmar());
    }

    async cambiarPassword() {
        if (this.passwordForm.invalid) {
            Object.keys(this.passwordForm.controls).forEach(key => {
                this.passwordForm.get(key)?.markAsTouched();
            });

            if (this.passwordForm.hasError('passwordsNoCoinciden')) {
                await this.mostrarError('Las contraseñas no coinciden');
            }
            return;
        }

        this.guardando.set(true);

        const data: CambiarPasswordDTO = {
            passwordActual: this.passwordForm.value.passwordActual,
            passwordNuevo: this.passwordForm.value.passwordNuevo
        };

        this.clienteService.cambiarPassword(data).subscribe({
            next: async (response) => {
                this.guardando.set(false);
                await this.mostrarExito('Contraseña cambiada correctamente');
                this.router.navigate(['/usuario/perfil']);
            },
            error: async (error) => {
                this.guardando.set(false);
                const mensaje = error?.error?.message || 'Error al cambiar la contraseña';
                await this.mostrarError(mensaje);
            }
        });
    }

    async mostrarExito(mensaje: string) {
        const toast = await this.toastController.create({
            message: mensaje,
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

    cancelar() {
        this.router.navigate(['/usuario/perfil']);
    }

    getErrorMessage(controlName: string): string {
        const control = this.passwordForm.get(controlName);
        if (!control || !control.errors || !control.touched) return '';

        if (control.errors['required']) return 'Este campo es requerido';
        if (control.errors['minlength']) {
            const minLength = control.errors['minlength'].requiredLength;
            return `Debe tener al menos ${minLength} caracteres`;
        }
        return '';
    }
}
