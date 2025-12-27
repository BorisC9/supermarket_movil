import { Component, signal } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormBuilder, FormGroup, ReactiveFormsModule, Validators } from '@angular/forms';
import { IonicModule, AlertController } from '@ionic/angular';
import { Router } from '@angular/router';
import { AuthService } from '../../core/services';
import { RegisterRequest } from '../../core/models';

@Component({
    selector: 'app-register',
    templateUrl: './register.page.html',
    styleUrls: ['./register.page.scss'],
    standalone: true,
    imports: [CommonModule, ReactiveFormsModule, IonicModule]
})
export class RegisterPage {
    registerForm!: FormGroup;
    procesando = signal<boolean>(false);

    constructor(
        private fb: FormBuilder,
        private authService: AuthService,
        private router: Router,
        private alertController: AlertController
    ) {
        this.crearFormulario();
    }

    crearFormulario() {
        this.registerForm = this.fb.group({
            cedulaClie: ['', [Validators.required, Validators.pattern(/^\d{8,15}$/)]],
            primerNombreClie: ['', Validators.required],
            segundoNombreClie: [''],
            apellidoPaternoClie: ['', Validators.required],
            apellidoMaternoClie: [''],
            fechaNacimientoClie: ['', Validators.required],
            telefonoClie: ['', [Validators.required, Validators.pattern(/^\d{9,15}$/)]],
            emailClie: ['', [Validators.required, Validators.email]],
            password: ['', [Validators.required, Validators.minLength(6)]],
            confirmarPassword: ['', Validators.required]
        }, { validators: this.passwordMatchValidator });
    }

    passwordMatchValidator(form: FormGroup) {
        const password = form.get('password');
        const confirmar = form.get('confirmarPassword');
        return password && confirmar && password.value === confirmar.value
            ? null
            : { passwordMismatch: true };
    }

    calcularEdad(fechaNacimiento: string): number {
        if (!fechaNacimiento) return 0;
        const hoy = new Date();
        const nacimiento = new Date(fechaNacimiento);
        let edad = hoy.getFullYear() - nacimiento.getFullYear();
        const mes = hoy.getMonth() - nacimiento.getMonth();
        if (mes < 0 || (mes === 0 && hoy.getDate() < nacimiento.getDate())) {
            edad--;
        }
        return edad;
    }

    async registrar() {
        if (this.registerForm.invalid) {
            Object.keys(this.registerForm.controls).forEach(key => {
                this.registerForm.get(key)?.markAsTouched();
            });
            await this.mostrarError('Por favor complete todos los campos correctamente');
            return;
        }

        this.procesando.set(true);

        const formValue = this.registerForm.value;
        const edad = this.calcularEdad(formValue.fechaNacimientoClie);

        const registerData: RegisterRequest = {
            cedulaClie: formValue.cedulaClie.trim(),
            primerNombreClie: formValue.primerNombreClie.trim(),
            segundoNombreClie: formValue.segundoNombreClie?.trim() || undefined,
            apellidoPaternoClie: formValue.apellidoPaternoClie.trim(),
            apellidoMaternoClie: formValue.apellidoMaternoClie?.trim() || undefined,
            fechaNacimientoClie: formValue.fechaNacimientoClie,
            edadClie: edad,
            telefonoClie: formValue.telefonoClie.trim(),
            emailClie: formValue.emailClie.trim(),
            password: formValue.password,
            esSocio: 'no',
            esTerceraEdad: edad >= 65 ? 'si' : 'no'
        };

        this.authService.register(registerData).subscribe({
            next: (response) => {
                this.procesando.set(false);
                this.mostrarExito('¡Registro exitoso! Bienvenido');
                setTimeout(() => {
                    this.router.navigate(['/productos']);
                }, 1500);
            },
            error: async (error) => {
                console.error('Error al registrar:', error);
                this.procesando.set(false);

                let mensaje = 'Error al registrar. Intente nuevamente';
                if (error.status === 401) {
                    mensaje = error.error?.message || 'El cliente ya está registrado';
                } else if (error.status === 0) {
                    mensaje = 'No se puede conectar con el servidor';
                }

                await this.mostrarError(mensaje);
            }
        });
    }

    async mostrarError(mensaje: string) {
        const alert = await this.alertController.create({
            header: 'Error',
            message: mensaje,
            buttons: ['OK']
        });
        await alert.present();
    }

    async mostrarExito(mensaje: string) {
        const alert = await this.alertController.create({
            header: 'Éxito',
            message: mensaje,
            buttons: ['OK']
        });
        await alert.present();
    }

    getErrorMessage(controlName: string): string {
        const control = this.registerForm.get(controlName);
        if (!control || !control.errors || !control.touched) return '';

        if (control.errors['required']) return 'Este campo es requerido';
        if (control.errors['email']) return 'Email inválido';
        if (control.errors['minLength']) return 'Mínimo 6 caracteres';
        if (control.errors['pattern']) {
            if (controlName === 'cedulaClie') return 'Cédula inválida (8-15 dígitos)';
            if (controlName === 'telefonoClie') return 'Teléfono inválido (9-15 dígitos)';
        }
        if (this.registerForm.errors?.['passwordMismatch'] && controlName === 'confirmarPassword') {
            return 'Las contraseñas no coinciden';
        }
        return '';
    }

    irALogin() {
        this.router.navigate(['/auth/login']);
    }
}
