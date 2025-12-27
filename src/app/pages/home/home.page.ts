import { Component } from '@angular/core';
import { CommonModule } from '@angular/common';
import { IonicModule } from '@ionic/angular';
import { Router } from '@angular/router';

@Component({
    selector: 'app-home',
    templateUrl: './home.page.html',
    styleUrls: ['./home.page.scss'],
    standalone: true,
    imports: [CommonModule, IonicModule]
})
export class HomePage {
    constructor(private router: Router) { }

    irAProductos() {
        this.router.navigate(['/productos']);
    }

    irAPerfil() {
        this.router.navigate(['/perfil']);
    }

    irACarrito() {
        this.router.navigate(['/carrito']);
    }
}
