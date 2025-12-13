import { Component, OnInit, signal } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { IonicModule } from '@ionic/angular';
import { Router } from '@angular/router';
import { AuthService } from '../../../core/services';

@Component({
    selector: 'app-perfil',
    templateUrl: './perfil.page.html',
    styleUrls: ['./perfil.page.scss'],
    standalone: true,
    imports: [CommonModule, FormsModule, IonicModule]
})
export class PerfilPage implements OnInit {
    usuario = signal<any>(null);
    cargando = signal<boolean>(true);

    constructor(
        public authService: AuthService,
        private router: Router
    ) { }

    ngOnInit() {
        this.cargarDatosUsuario();
    }

    cargarDatosUsuario() {
        this.cargando.set(true);
        const usuario = this.authService.usuarioActual();
        this.usuario.set(usuario);
        this.cargando.set(false);
    }

    irAEditarPerfil() {
        this.router.navigate(['/perfil/editar']);
    }

    irAHistorialCompras() {
        this.router.navigate(['/perfil/historial-compras']);
    }

    irACambiarPassword() {
        // Por implementar
        console.log('Cambiar password - Por implementar');
    }

    cerrarSesion() {
        this.authService.logout();
    }
}
