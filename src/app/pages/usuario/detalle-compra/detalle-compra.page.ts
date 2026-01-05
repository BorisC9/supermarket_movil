import { Component, OnInit, signal } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { IonicModule } from '@ionic/angular';
import { ActivatedRoute, Router } from '@angular/router';
import { VentaService } from '../../../core/services';
import { Venta, DetalleVenta } from '../../../core/models';

@Component({
    selector: 'app-detalle-compra',
    templateUrl: './detalle-compra.page.html',
    styleUrls: ['./detalle-compra.page.scss'],
    standalone: true,
    imports: [CommonModule, FormsModule, IonicModule]
})
export class DetalleCompraPage implements OnInit {
    compra = signal<any>(null);
    cargando = signal<boolean>(true);
    error = signal<string | null>(null);
    idVenta: number | null = null;

    constructor(
        private ventaService: VentaService,
        private route: ActivatedRoute,
        private router: Router
    ) { }

    ngOnInit() {
        this.route.params.subscribe(params => {
            this.idVenta = params['id'] ? +params['id'] : null;
            if (this.idVenta) {
                this.cargarDetalleCompra();
            } else {
                this.error.set('ID de compra no válido');
                this.cargando.set(false);
            }
        });
    }

    cargarDetalleCompra() {
        if (!this.idVenta) return;

        this.cargando.set(true);
        this.error.set(null);

        this.ventaService.obtenerDetalleVenta(this.idVenta).subscribe({
            next: (venta: any) => {
                if (venta && (venta.ideVent || venta.numFacturaVent)) {
                    this.compra.set(venta);
                } else {
                    this.error.set('No se encontraron datos de la compra');
                }
                this.cargando.set(false);
            },
            error: (error: any) => {
                if (error?.status === 404) {
                    this.error.set('La compra no fue encontrada');
                } else if (error?.status === 401 || error?.status === 403) {
                    this.error.set('No tienes permiso para ver esta compra');
                } else if (error?.error?.message) {
                    this.error.set(error.error.message);
                } else {
                    this.error.set('Error al cargar el detalle de la compra. Intenta nuevamente.');
                }
                this.cargando.set(false);
            }
        });
    }

    formatearFecha(fecha: string): string {
        if (!fecha) return 'N/A';
        const date = new Date(fecha);
        return date.toLocaleDateString('es-ES', {
            day: '2-digit',
            month: 'long',
            year: 'numeric',
            hour: '2-digit',
            minute: '2-digit'
        });
    }

    getEstadoColor(estado: string): string {
        const estados: { [key: string]: string } = {
            'completado': 'success',
            'cancelado': 'danger',
            'devuelto': 'warning'
        };
        return estados[estado?.toLowerCase()] || 'medium';
    }

    getEstadoTexto(estado: string): string {
        const estados: { [key: string]: string } = {
            'completado': 'Completado',
            'cancelado': 'Cancelado',
            'devuelto': 'Devuelto'
        };
        return estados[estado?.toLowerCase()] || estado;
    }

    /**
     * Formatea un valor numérico a 2 decimales
     * Maneja el caso cuando el valor viene como string desde la API
     */
    formatearPrecio(valor: any): string {
        const numero = Number(valor) || 0;
        return numero.toFixed(2);
    }

    volver() {
        this.router.navigate(['/perfil/historial-compras']);
    }
}
