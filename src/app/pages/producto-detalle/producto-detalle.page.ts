import { Component, OnInit, signal } from '@angular/core';
import { CommonModule } from '@angular/common';
import { IonicModule } from '@ionic/angular';
import { ActivatedRoute, Router } from '@angular/router';
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
  imports: [CommonModule, IonicModule]
})
export class ProductoDetallePage implements OnInit {
  producto = signal<Producto | null>(null);
  cargando = signal(true);

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

  agregarAlCarrito(): void {
    const prod = this.producto();
    if (prod && this.getDisponible(prod)) {
      this.carritoService.agregarProducto(prod);
    }
  }

  irAlCarrito() {
    this.router.navigate(['/carrito']);
  }
}
