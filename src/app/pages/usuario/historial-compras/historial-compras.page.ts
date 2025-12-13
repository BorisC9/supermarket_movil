import { Component, OnInit, signal } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { IonicModule } from '@ionic/angular';
import { Router } from '@angular/router';
import { VentaService, AuthService } from '../../../core/services';
import { Venta } from '../../../core/models';

@Component({
    selector: 'app-historial-compras',
    templateUrl: './historial-compras.page.html',
    styleUrls: ['./historial-compras.page.scss'],
    standalone: true,
    imports: [CommonModule, FormsModule, IonicModule]
})
export class HistorialComprasPage implements OnInit {
    compras = signal<Venta[]>([]);
    cargando = signal<boolean>(true);
    error = signal<string | null>(null);

    constructor(
        private ventaService: VentaService,
        private authService: AuthService,
        private router: Router
    ) { }

    ngOnInit() {
        this.cargarHistorial();
    }

    cargarHistorial() {
        this.cargando.set(true);
        this.error.set(null);

        const usuario = this.authService.usuarioActual();
        const idCliente = usuario?.ide_clie;

        if (!idCliente) {
            this.error.set('No se pudo identificar el usuario. Por favor, inicia sesión nuevamente.');
            this.cargando.set(false);
            return;
        }

        this.ventaService.obtenerHistorialVentas(idCliente).subscribe({
            next: (ventas: Venta[]) => {
                console.log('Historial de compras:', ventas);
                this.compras.set(Array.isArray(ventas) ? ventas : []);
                this.cargando.set(false);
            },
            error: (error: any) => {
                console.error('Error al cargar historial:', error);
                this.error.set('Error al cargar el historial de compras');
                this.cargando.set(false);
            }
        });
    }

    verDetalleCompra(compra: Venta) {
        this.router.navigate(['/perfil/detalle-compra', compra.ideVent]);
    }

    formatearFecha(fecha: string): string {
        if (!fecha) return 'N/A';
        const date = new Date(fecha);
        return date.toLocaleDateString('es-ES', {
            day: '2-digit',
            month: '2-digit',
            year: 'numeric'
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

    doRefresh(event: any) {
        this.cargarHistorial();
        setTimeout(() => {
            event.target.complete();
        }, 1000);
    }
}
