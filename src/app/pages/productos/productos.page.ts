import { Component, OnInit, signal } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { IonicModule, AlertController } from '@ionic/angular';
import { Router, RouterModule } from '@angular/router';
import { ProductoService, CategoriaService, CarritoService } from '../../core/services';
import { Producto, Categoria, calcularPrecioFinal, getProductoId, getProductoNombre, getProductoStock, getProductoPrecioVenta, getProductoImagen, getProductoDctoPromo, getCategoriaId, getCategoriaNombre, getIconoCategoria } from '../../core/models';

@Component({
    selector: 'app-productos',
    templateUrl: './productos.page.html',
    styleUrls: ['./productos.page.scss'],
    standalone: true,
    imports: [CommonModule, FormsModule, IonicModule, RouterModule]
})
export class ProductosPage implements OnInit {
    productos = signal<Producto[]>([]);
    categorias = signal<Categoria[]>([]);
    cargando = signal<boolean>(false);
    categoriaSeleccionada = signal<number | null>(null);
    terminoBusqueda = signal<string>('');

    constructor(
        private productoService: ProductoService,
        private categoriaService: CategoriaService,
        public carritoService: CarritoService,
        private router: Router,
        private alertCtrl: AlertController
    ) { }

    // Exponer helpers al template
    calcularPrecioFinal = calcularPrecioFinal;
    getProductoId = getProductoId;
    getProductoNombre = getProductoNombre;
    getProductoStock = getProductoStock;
    getProductoPrecioVenta = getProductoPrecioVenta;
    getProductoImagen = getProductoImagen;
    getProductoDctoPromo = getProductoDctoPromo;
    getCategoriaId = getCategoriaId;
    getCategoriaNombre = getCategoriaNombre;
    getIconoCategoria = getIconoCategoria;

    ngOnInit() {
        this.cargarCategorias();
        this.cargarProductos();
    }

    cargarCategorias() {
        this.categoriaService.obtenerCategorias().subscribe({
            next: (categorias) => {
                const lista = Array.isArray(categorias) ? categorias : [];
                this.categorias.set(lista);
            },
            error: () => {
                this.categorias.set([]);
            }
        });
    }

    cargarProductos() {
        this.cargando.set(true);

        // Solo enviar filtros si existen valores
        const filtros: any = {};

        if (this.categoriaSeleccionada()) {
            filtros.ideCate = this.categoriaSeleccionada();
        }
        if (this.terminoBusqueda()) {
            filtros.nombreProd = this.terminoBusqueda();
        }

        // Si no hay filtros, enviar undefined para usar el endpoint base
        const filtrosAplicar = Object.keys(filtros).length > 0 ? filtros : undefined;

        this.productoService.obtenerProductos(filtrosAplicar).subscribe({
            next: (productos) => {
                this.productos.set(Array.isArray(productos) ? productos : []);
                this.cargando.set(false);
            },
            error: async (error) => {
                this.productos.set([]);
                this.cargando.set(false);

                if (error?.status === 401 || error?.status === 403) {
                    const alert = await this.alertCtrl.create({
                        header: 'Autenticación',
                        message: 'No tienes permisos para ver estos productos o tu sesión expiró. Por favor inicia sesión nuevamente.',
                        buttons: [
                            {
                                text: 'Ir a login',
                                handler: () => this.router.navigate(['/auth/login'])
                            },
                            {
                                text: 'Cancelar',
                                role: 'cancel'
                            }
                        ]
                    });
                    await alert.present();
                }
            }
        });
    }

    filtrarPorCategoria(idCategoria: number | null) {
        this.categoriaSeleccionada.set(idCategoria);
        this.cargarProductos();
    }

    buscarProductos(event: any) {
        const termino = event.target.value?.trim() || '';
        this.terminoBusqueda.set(termino);
        this.cargarProductos();
    }

    limpiarBusqueda() {
        this.terminoBusqueda.set('');
        this.cargarProductos();
    }

    obtenerNombreCategoria(): string {
        const idCategoria = this.categoriaSeleccionada();
        if (!idCategoria) return '';

        const categoria = this.categorias().find(c => this.getCategoriaId(c) === idCategoria);
        return categoria ? this.getCategoriaNombre(categoria) : '';
    }

    agregarAlCarrito(producto: Producto) {
        this.carritoService.agregarProducto(producto, 1);
    }

    verDetalle(producto: Producto) {
        this.router.navigate(['/producto-detalle', getProductoId(producto)]);
    }

    irAlCarrito() {
        this.router.navigate(['/carrito']);
    }

    irAlPerfil() {
        this.router.navigate(['/perfil']);
    }

    onImageError(event: Event) {
        const img = event.target as HTMLImageElement;
        if (img) {
            img.src = 'assets/imgs/placeholder.png';
        }
    }

    getProductoCategoria(producto: Producto): string {
        if ((producto as any).nom_cate) {
            return (producto as any).nom_cate;
        }
        const ideCate = (producto as any).ide_cate || (producto as any).ideCate;
        if (ideCate) {
            const categoria = this.categorias().find(c => this.getCategoriaId(c) === ideCate);
            return categoria ? this.getCategoriaNombre(categoria) : '';
        }
        return '';
    }
}
