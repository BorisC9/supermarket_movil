import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';
import { map } from 'rxjs/operators';
import { environment } from '../../../environments/environment';
import { Venta, CrearVentaDTO } from '../models';

@Injectable({
    providedIn: 'root'
})
export class VentaService {
    private apiUrl = `${environment.apiUrl}/ventas`;

    constructor(private http: HttpClient) { }

    /**
     * Crear una nueva venta
     */
    crearVenta(venta: CrearVentaDTO): Observable<Venta> {
        return this.http.post<any>(`${this.apiUrl}/insertar`, venta).pipe(
            map(response => response?.data || response)
        );
    }

    /**
     * Obtener historial de ventas del cliente
     */
    obtenerHistorialVentas(idCliente: number): Observable<Venta[]> {
        return this.http.get<any>(`${this.apiUrl}/cliente/${idCliente}`).pipe(
            map(response => response?.data || response || [])
        );
    }

    /**
     * Obtener detalle de una venta
     */
    obtenerDetalleVenta(idVenta: number): Observable<Venta> {
        return this.http.get<any>(`${this.apiUrl}/buscar/${idVenta}`).pipe(
            map(response => response?.data || response)
        );
    }
}
