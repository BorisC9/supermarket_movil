import { Injectable, signal, computed } from '@angular/core';
import { ItemCarrito, Carrito, Producto, getProductoId, getProductoPrecioVenta, getProductoDctoPromo } from '../models';

@Injectable({
    providedIn: 'root'
})
export class CarritoService {
    // Estado del carrito usando signals
    private itemsSignal = signal<ItemCarrito[]>([]);

    // Computed values
    items = this.itemsSignal.asReadonly();

    cantidadTotal = computed(() => {
        return this.itemsSignal().reduce((total, item) => total + item.cantidad, 0);
    });

    subtotal = computed(() => {
        return this.itemsSignal().reduce((total, item) => total + item.subtotal, 0);
    });

    descuentoTotal = computed(() => {
        return this.itemsSignal().reduce((total, item) => total + item.descuento, 0);
    });

    total = computed(() => {
        return this.itemsSignal().reduce((total, item) => total + item.total, 0);
    });

    carrito = computed<Carrito>(() => ({
        items: this.itemsSignal(),
        cantidadTotal: this.cantidadTotal(),
        subtotal: this.subtotal(),
        descuentoTotal: this.descuentoTotal(),
        iva: 0, // Calculado en el backend
        total: this.total()
    }));

    constructor() {
        this.cargarCarritoLocal();
    }

    /**
     * Agregar producto al carrito
     */
    agregarProducto(producto: Producto, cantidad: number = 1): void {
        const items = [...this.itemsSignal()];
        const idProducto = getProductoId(producto);
        const index = items.findIndex(item => getProductoId(item.producto) === idProducto);

        if (index >= 0) {
            // Actualizar cantidad si ya existe
            items[index].cantidad += cantidad;
            items[index] = this.calcularTotalesItem(items[index]);
        } else {
            // Agregar nuevo item
            const nuevoItem: ItemCarrito = {
                producto,
                cantidad,
                subtotal: 0,
                descuento: 0,
                total: 0
            };
            items.push(this.calcularTotalesItem(nuevoItem));
        }

        this.itemsSignal.set(items);
        this.guardarCarritoLocal();
    }

    /**
     * Actualizar cantidad de un producto
     */
    actualizarCantidad(idProducto: number, cantidad: number): void {
        const items = [...this.itemsSignal()];
        const index = items.findIndex(item => getProductoId(item.producto) === idProducto);

        if (index >= 0) {
            if (cantidad <= 0) {
                items.splice(index, 1);
            } else {
                items[index].cantidad = cantidad;
                items[index] = this.calcularTotalesItem(items[index]);
            }
            this.itemsSignal.set(items);
            this.guardarCarritoLocal();
        }
    }

    /**
     * Eliminar producto del carrito
     */
    eliminarProducto(idProducto: number): void {
        const items = this.itemsSignal().filter(
            item => getProductoId(item.producto) !== idProducto
        );
        this.itemsSignal.set(items);
        this.guardarCarritoLocal();
    }

    /**
     * Limpiar todo el carrito
     */
    limpiarCarrito(): void {
        this.itemsSignal.set([]);
        this.guardarCarritoLocal();
    }

    /**
     * Calcular totales de un item
     */
    private calcularTotalesItem(item: ItemCarrito): ItemCarrito {
        const producto = item.producto;

        // Usar helpers para obtener valores
        const precioBase = getProductoPrecioVenta(producto);
        const descuentoPromoPct = getProductoDctoPromo(producto);

        const descuentoPromo = (precioBase * descuentoPromoPct) / 100;
        const precioUnitario = precioBase - descuentoPromo;

        // Calcular totales
        const subtotal = precioUnitario * item.cantidad;
        const descuento = descuentoPromo * item.cantidad;
        const total = subtotal;

        return {
            ...item,
            subtotal,
            descuento,
            total
        };
    }

    /**
     * Guardar carrito en localStorage
     */
    private guardarCarritoLocal(): void {
        try {
            localStorage.setItem('carrito', JSON.stringify(this.itemsSignal()));
        } catch {
            // Error al guardar carrito
        }
    }

    /**
     * Cargar carrito desde localStorage
     */
    private cargarCarritoLocal(): void {
        try {
            const carritoGuardado = localStorage.getItem('carrito');
            if (carritoGuardado) {
                const items = JSON.parse(carritoGuardado) as ItemCarrito[];
                this.itemsSignal.set(items);
            }
        } catch {
            // Error al cargar carrito
        }
    }
}
