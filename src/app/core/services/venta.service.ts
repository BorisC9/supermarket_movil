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
    private apiUrl = `${environment.apiUrl}/mobile/ventas`;

    constructor(private http: HttpClient) { }

    /**
     * Crear una nueva venta
     */
    crearVenta(venta: CrearVentaDTO): Observable<any> {
        return this.http.post<any>(this.apiUrl, venta).pipe(
            map(response => response?.data || response)
        );
    }

    /**
     * Obtener historial de ventas del cliente autenticado
     * El backend obtiene el idCliente del token JWT
     */
    obtenerHistorialVentas(idCliente?: number): Observable<Venta[]> {
        return this.http.get<any>(`${this.apiUrl}/historial`).pipe(
            map(response => response || [])
        );
    }

    /**
     * Obtener detalle de una venta
     */
    obtenerDetalleVenta(idVenta: number): Observable<any> {
        return this.http.get<any>(`${this.apiUrl}/${idVenta}`).pipe(
            map(response => response?.data || response)
        );
    }
}
