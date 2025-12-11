import { Component, computed } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { IonicModule } from '@ionic/angular';
import { Router } from '@angular/router';
import { CarritoService } from '../../core/services';
import { calcularPrecioFinal, getProductoNombre, getProductoImagen, getProductoId, getProductoStock } from '../../core/models';

@Component({
    selector: 'app-carrito',
    templateUrl: './carrito.page.html',
    styleUrls: ['./carrito.page.scss'],
    standalone: true,
    imports: [CommonModule, FormsModule, IonicModule]
})
export class CarritoPage {
    carrito = computed(() => this.carritoService.carrito());
    calcularPrecioFinal = calcularPrecioFinal;
    getProductoNombre = getProductoNombre;
    getProductoImagen = getProductoImagen;
    getProductoId = getProductoId;
    getProductoStock = getProductoStock;

    constructor(
        public carritoService: CarritoService,
        private router: Router
    ) { }

    actualizarCantidad(idProducto: number, cantidad: number) {
        this.carritoService.actualizarCantidad(idProducto, cantidad);
    }

    eliminarItem(idProducto: number) {
        this.carritoService.eliminarProducto(idProducto);
    }

    incrementarCantidad(idProducto: number, cantidadActual: number) {
        this.carritoService.actualizarCantidad(idProducto, cantidadActual + 1);
    }

    decrementarCantidad(idProducto: number, cantidadActual: number) {
        if (cantidadActual > 1) {
            this.carritoService.actualizarCantidad(idProducto, cantidadActual - 1);
        }
    }

    continuarComprando() {
        this.router.navigate(['/productos']);
    }

    procederAlCheckout() {
        this.router.navigate(['/checkout']);
    }

    limpiarCarrito() {
        this.carritoService.limpiarCarrito();
    }
}
