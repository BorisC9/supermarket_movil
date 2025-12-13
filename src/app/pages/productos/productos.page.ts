import { Component, OnInit, signal } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { IonicModule } from '@ionic/angular';
import { Router, RouterModule } from '@angular/router';
import { ProductoService, CategoriaService, CarritoService, AuthService } from '../../core/services';
import { Producto, Categoria, calcularPrecioFinal, getProductoId, getProductoNombre, getProductoStock, getProductoDisponible, getProductoPrecioVenta, getProductoImagen, getProductoDctoPromo, getCategoriaId, getCategoriaNombre } from '../../core/models';

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
        private authService: AuthService,
        private router: Router
    ) { }

    // Exponer helpers al template
    calcularPrecioFinal = calcularPrecioFinal;
    parseFloat = parseFloat;
    getProductoId = getProductoId;
    getProductoNombre = getProductoNombre;
    getProductoStock = getProductoStock;
    getProductoDisponible = getProductoDisponible;
    getProductoPrecioVenta = getProductoPrecioVenta;
    getProductoImagen = getProductoImagen;
    getProductoDctoPromo = getProductoDctoPromo;
    getCategoriaId = getCategoriaId;
    getCategoriaNombre = getCategoriaNombre;

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
            error: (error) => {
                console.error('Error al cargar categorías:', error);
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
                console.log('Productos cargados:', productos);
                this.productos.set(Array.isArray(productos) ? productos : []);
                this.cargando.set(false);
            },
            error: (error) => {
                console.error('Error al cargar productos:', error);
                this.productos.set([]); // Asegurar que siempre sea un array
                this.cargando.set(false);
                
                // Si el error es de autenticación, redirigir al login
                if (error.status === 401 || error.status === 403) {
                    console.warn('Sesión expirada o sin permisos, redirigiendo al login...');
                    this.authService.logout();
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

    limpiarTodosFiltros() {
        this.categoriaSeleccionada.set(null);
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

    logout() {
        this.authService.logout();
    }
}
