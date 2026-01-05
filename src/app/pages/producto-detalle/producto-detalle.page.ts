import { Component, OnInit, signal } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { IonicModule } from '@ionic/angular';
import { ActivatedRoute, Router, RouterModule } from '@angular/router';
import { ProductoService } from '../../core/services/producto.service';
import { CarritoService } from '../../core/services/carrito.service';
import {
  Producto,
  calcularPrecioFinal,
  getProductoNombre,
  getProductoImagen,
  getProductoStock,
  getProductoDisponible,
  getProductoPrecioVenta,
  getProductoDescuento,
  getProductoId
} from '../../core/models';

@Component({
  selector: 'app-producto-detalle',
  templateUrl: './producto-detalle.page.html',
  styleUrls: ['./producto-detalle.page.scss'],
  standalone: true,
  imports: [CommonModule, FormsModule, IonicModule, RouterModule]
})
export class ProductoDetallePage implements OnInit {
  producto = signal<Producto | null>(null);
  cargando = signal(true);
  cantidad = signal(1);

  constructor(
    private route: ActivatedRoute,
    private router: Router,
    private productoService: ProductoService,
    public carritoService: CarritoService
  ) { }

  ngOnInit(): void {
    const id = Number(this.route.snapshot.paramMap.get('id'));
    if (id) {
      this.productoService.obtenerProductoPorId(id).subscribe({
        next: (p) => {
          this.producto.set(p);
          this.cargando.set(false);
        },
        error: () => {
          this.producto.set(null);
          this.cargando.set(false);
        }
      });
    }
  }

  getNombre(producto: Producto): string {
    return getProductoNombre(producto);
  }

  getPrecio(producto: Producto): string {
    return getProductoPrecioVenta(producto).toFixed(2);
  }

  getDescuento(producto: Producto): number {
    return getProductoDescuento(producto);
  }

  getPrecioConDescuento(producto: Producto): string {
    return calcularPrecioFinal(producto).toFixed(2);
  }

  getStock(producto: Producto): number {
    return getProductoStock(producto);
  }

  getDisponible(producto: Producto): boolean {
    const disponible = getProductoDisponible(producto);
    return disponible === 'si';
  }

  getImageUrl(producto: Producto): string {
    return getProductoImagen(producto);
  }

  getCodigoBarras(producto: any): string {
    return producto?.codigo_barra_prod || producto?.codigoBarraProd || 'N/A';
  }

  getCategoria(producto: any): string {
    return producto?.nombre_cate || producto?.categoria?.nombreCate || 'Sin categoría';
  }

  getMarca(producto: any): string {
    return producto?.nombre_marc || producto?.marca?.nombreMarc || 'Sin marca';
  }

  getDescripcion(producto: any): string {
    return producto?.descripcion_prod || producto?.descripcionProd || 'Sin descripción disponible';
  }

  incrementarCantidad(): void {
    const prod = this.producto();
    if (prod && this.cantidad() < this.getStock(prod)) {
      this.cantidad.update(c => c + 1);
    }
  }

  decrementarCantidad(): void {
    if (this.cantidad() > 1) {
      this.cantidad.update(c => c - 1);
    }
  }

  agregarAlCarrito(): void {
    const prod = this.producto();
    if (prod && this.getDisponible(prod)) {
      this.carritoService.agregarProducto(prod, this.cantidad());
      // Resetear cantidad después de agregar
      this.cantidad.set(1);
    }
  }

  irAlCarrito() {
    this.router.navigate(['/carrito']);
  }

  getStockStatus(producto: Producto): { color: string, texto: string, icon: string } {
    const stock = this.getStock(producto);
    const disponible = this.getDisponible(producto);

    if (!disponible) {
      return { color: 'danger', texto: 'Agotado', icon: 'close-circle' };
    }
    if (stock <= 5) {
      return { color: 'warning', texto: `Últimas ${stock} unidades`, icon: 'alert-circle' };
    }
    return { color: 'success', texto: `${stock} unidades disponibles`, icon: 'checkmark-circle' };
  }

  calcularAhorro(producto: Producto): string {
    const precioOriginal = parseFloat(this.getPrecio(producto));
    const precioConDescuento = parseFloat(this.getPrecioConDescuento(producto));
    return (precioOriginal - precioConDescuento).toFixed(2);
  }

  calcularSubtotal(producto: Producto): string {
    const precioConDescuento = parseFloat(this.getPrecioConDescuento(producto));
    return (precioConDescuento * this.cantidad()).toFixed(2);
  }

  onImageError(event: Event): void {
    const img = event.target as HTMLImageElement;
    if (img) {
      img.src = 'assets/imgs/placeholder.png';
    }
  }
}
