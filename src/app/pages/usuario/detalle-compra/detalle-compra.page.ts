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
                this.compra.set(venta);
                this.cargando.set(false);
            },
            error: (error: any) => {
                console.error('Error al cargar detalle de compra:', error);
                this.error.set('Error al cargar el detalle de la compra');
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

    volver() {
        this.router.navigate(['/perfil/historial-compras']);
    }
}
