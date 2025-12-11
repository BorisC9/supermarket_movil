import { Injectable } from '@angular/core';
import { HttpClient, HttpParams } from '@angular/common/http';
import { Observable } from 'rxjs';
import { map } from 'rxjs/operators';
import { environment } from '../../../environments/environment';
import { Producto } from '../models';

@Injectable({
    providedIn: 'root'
})
export class ProductoService {
    private apiUrl = `${environment.apiUrl}/productos`;

    constructor(private http: HttpClient) { }

    /**
     * Obtener todos los productos
     */
    obtenerProductos(filtros?: {
        categoria?: number;
        disponible?: boolean;
        busqueda?: string;
        sort?: 'precio' | 'descuento' | 'stock' | 'nombre';
        order?: 'asc' | 'desc';
        limit?: number;
        offset?: number;
    }): Observable<Producto[]> {
        // Si hay filtros, usar el endpoint /filtrar, sino usar el endpoint base
        if (filtros && (filtros.categoria || filtros.busqueda || filtros.disponible !== undefined)) {
            let params = new HttpParams();

            if (filtros.categoria) {
                params = params.set('ideCate', filtros.categoria.toString());
            }
            if (filtros.disponible !== undefined) {
                params = params.set('disponible', filtros.disponible ? 'S' : 'N');
            }
            if (filtros.busqueda) {
                params = params.set('busqueda', filtros.busqueda);
            }
            if (filtros.sort) {
                params = params.set('sort', filtros.sort);
            }
            if (filtros.order) {
                params = params.set('order', filtros.order);
            }
            if (typeof filtros.limit === 'number') {
                params = params.set('limit', String(filtros.limit));
            }
            if (typeof filtros.offset === 'number') {
                params = params.set('offset', String(filtros.offset));
            }

            return this.http.get<any>(`${this.apiUrl}/filtrar`, { params }).pipe(
                map(response => response?.data || response || [])
            );
        }

        // Sin filtros, listar todos
        return this.http.get<any>(this.apiUrl).pipe(
            map(response => response?.data || response || [])
        );
    }

    /**
     * Obtener un producto por ID
     */
    obtenerProductoPorId(id: number): Observable<Producto> {
        return this.http.get<any>(`${this.apiUrl}/buscar/${id}`).pipe(
            map(response => {
                const data = response?.data ?? response;
                // Backend may return an array or an object; normalize to object
                if (Array.isArray(data)) {
                    return data[0] ?? {};
                }
                return data ?? {};
            })
        );
    }

    /**
     * Obtener productos destacados o en promoción
     */
    obtenerProductosDestacados(): Observable<Producto[]> {
        return this.http.get<Producto[]>(`${this.apiUrl}/destacados`);
    }

    /**
     * Buscar productos por nombre o código de barra
     */
    buscarProductos(termino: string): Observable<Producto[]> {
        const params = new HttpParams().set('busqueda', termino);
        return this.http.get<any>(`${this.apiUrl}/filtrar`, { params }).pipe(
            map(response => response?.data || response || [])
        );
    }
}
