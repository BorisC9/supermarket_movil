import { Component, OnInit, signal } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormBuilder, FormGroup, ReactiveFormsModule, Validators } from '@angular/forms';
import { IonicModule } from '@ionic/angular';
import { Router } from '@angular/router';
import { ClienteService, AuthService } from '../../../core/services';
import { Cliente } from '../../../core/models';

@Component({
    selector: 'app-editar-perfil',
    templateUrl: './editar-perfil.page.html',
    styleUrls: ['./editar-perfil.page.scss'],
    standalone: true,
    imports: [CommonModule, ReactiveFormsModule, IonicModule]
})
export class EditarPerfilPage implements OnInit {
    perfilForm!: FormGroup;
    cargando = signal<boolean>(true);
    guardando = signal<boolean>(false);
    error = signal<string | null>(null);
    cliente = signal<Cliente | null>(null);

    constructor(
        private fb: FormBuilder,
        private clienteService: ClienteService,
        private authService: AuthService,
        private router: Router
    ) {
        this.crearFormulario();
    }

    ngOnInit() {
        this.cargarDatosCliente();
    }

    crearFormulario() {
        this.perfilForm = this.fb.group({
            primerNombreClie: ['', Validators.required],
            segundoNombreClie: [''],
            apellidoPaternoClie: ['', Validators.required],
            apellidoMaternoClie: [''],
            cedulaClie: ['', [Validators.required, Validators.pattern(/^\d{8,10}$/)]],
            emailClie: ['', [Validators.required, Validators.email]],
            telefonoClie: ['', [Validators.required, Validators.pattern(/^\d{9,10}$/)]],
            fechaNacimientoClie: ['', Validators.required]
        });
    }

    cargarDatosCliente() {
        this.cargando.set(true);
        this.error.set(null);

        const usuario = this.authService.usuarioActual();
        const idCliente = usuario?.ide_clie;

        if (!idCliente) {
            this.error.set('No se pudo identificar el usuario. Por favor, inicia sesión nuevamente.');
            this.cargando.set(false);
            return;
        }

        this.clienteService.obtenerCliente(idCliente).subscribe({
            next: (cliente: Cliente) => {
                console.log('Cliente cargado:', cliente);
                this.cliente.set(cliente);
                this.perfilForm.patchValue({
                    primerNombreClie: cliente.primerNombreClie,
                    segundoNombreClie: cliente.segundoNombreClie,
                    apellidoPaternoClie: cliente.apellidoPaternoClie,
                    apellidoMaternoClie: cliente.apellidoMaternoClie,
                    cedulaClie: cliente.cedulaClie,
                    emailClie: cliente.emailClie,
                    telefonoClie: cliente.telefonoClie,
                    fechaNacimientoClie: this.formatearFecha(cliente.fechaNacimientoClie)
                });
                this.cargando.set(false);
            },
            error: (error: any) => {
                console.error('Error al cargar cliente:', error);
                this.error.set('Error al cargar los datos del perfil');
                this.cargando.set(false);
            }
        });
    }

    formatearFecha(fecha: string): string {
        if (!fecha) return '';
        const date = new Date(fecha);
        return date.toISOString().split('T')[0];
    }

    async guardarCambios() {
        if (this.perfilForm.invalid) {
            Object.keys(this.perfilForm.controls).forEach(key => {
                this.perfilForm.get(key)?.markAsTouched();
            });
            return;
        }

        const cliente = this.cliente();
        if (!cliente) return;

        this.guardando.set(true);
        this.error.set(null);

        const datosActualizados = this.perfilForm.value;

        this.clienteService.actualizarCliente(cliente.ideClie, datosActualizados).subscribe({
            next: (clienteActualizado: Cliente) => {
                console.log('Cliente actualizado:', clienteActualizado);
                this.guardando.set(false);
                this.router.navigate(['/perfil'], {
                    state: { mensaje: 'Perfil actualizado correctamente' }
                });
            },
            error: (error: any) => {
                console.error('Error al actualizar:', error);
                this.error.set('Error al guardar los cambios');
                this.guardando.set(false);
            }
        });
    }

    cancelar() {
        this.router.navigate(['/perfil']);
    }

    getErrorMessage(controlName: string): string {
        const control = this.perfilForm.get(controlName);
        if (!control || !control.errors || !control.touched) return '';

        if (control.errors['required']) return 'Este campo es requerido';
        if (control.errors['email']) return 'Email inválido';
        if (control.errors['pattern']) {
            if (controlName === 'cedulaClie') return 'Cédula inválida (8-10 dígitos)';
            if (controlName === 'telefonoClie') return 'Teléfono inválido (9-10 dígitos)';
        }
        return '';
    }
}
