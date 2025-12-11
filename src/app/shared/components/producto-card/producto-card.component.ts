import { Component, Input, Output, EventEmitter } from '@angular/core';
import { CommonModule } from '@angular/common';
import { IonicModule } from '@ionic/angular';
import { Producto, calcularPrecioFinal, getProductoNombre, getProductoImagen, getProductoDctoPromo, getProductoPrecioVenta, getProductoStock, getProductoDisponible } from '../../../core/models';

@Component({
    selector: 'app-producto-card',
    templateUrl: './producto-card.component.html',
    styleUrls: ['./producto-card.component.scss'],
    standalone: true,
    imports: [CommonModule, IonicModule]
})
export class ProductoCardComponent {
    @Input() producto!: Producto;
    @Output() agregarCarrito = new EventEmitter<Producto>();
    @Output() verDetalle = new EventEmitter<Producto>();

    calcularPrecioFinal = calcularPrecioFinal;
    getProductoNombre = getProductoNombre;
    getProductoImagen = getProductoImagen;
    getProductoDctoPromo = getProductoDctoPromo;
    getProductoPrecioVenta = getProductoPrecioVenta;
    getProductoStock = getProductoStock;
    getProductoDisponible = getProductoDisponible;

    onAgregarCarrito() {
        this.agregarCarrito.emit(this.producto);
    }

    onVerDetalle() {
        this.verDetalle.emit(this.producto);
    }
}
