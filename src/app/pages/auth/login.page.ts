import { Component, OnInit, signal } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { IonicModule, AlertController } from '@ionic/angular';
import { Router } from '@angular/router';
import { AuthService } from '../../core/services';
import { LoginRequest } from '../../core/models';

@Component({
    selector: 'app-login',
    templateUrl: './login.page.html',
    styleUrls: ['./login.page.scss'],
    standalone: true,
    imports: [CommonModule, FormsModule, IonicModule]
})
export class LoginPage {
    usuario = signal<string>('');
    clave = signal<string>('');
    procesando = signal<boolean>(false);

    constructor(
        private authService: AuthService,
        private router: Router,
        private alertController: AlertController
    ) { }

    async login() {
        if (!this.usuario() || !this.clave()) {
            await this.mostrarError('Por favor ingrese usuario y contraseña');
            return;
        }

        this.procesando.set(true);

        const credentials: LoginRequest = {
            usuario: this.usuario().trim(),
            clave: this.clave().trim(),
            numIntentos: 1
        };

        console.log('Intentando login con:', { usuario: credentials.usuario, numIntentos: credentials.numIntentos });

        this.authService.login(credentials).subscribe({
            next: (response) => {
                console.log('Login exitoso:', response);
                this.procesando.set(false);
                this.router.navigate(['/productos']);
            },
            error: async (error) => {
                console.error('Error al iniciar sesión:', error);
                this.procesando.set(false);

                let mensaje = 'Error al iniciar sesión';
                if (error.status === 401) {
                    mensaje = 'Usuario o contraseña incorrectos';
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

    irARegistro() {
        this.router.navigate(['/auth/register']);
    }
}

