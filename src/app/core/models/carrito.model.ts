import { Producto } from './producto.model';

export interface ItemCarrito {
    producto: Producto;
    cantidad: number;
    subtotal: number;
    descuento: number;
    total: number;
}

export interface Carrito {
    items: ItemCarrito[];
    cantidadTotal: number;
    subtotal: number;
    descuentoTotal: number;
    iva: number;
    total: number;
}
