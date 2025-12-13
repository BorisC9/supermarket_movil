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
     * Obtener todos los productos con filtros opcionales
     */
    obtenerProductos(filtros?: {
        ideCate?: number;           // ID de categoría
        ideMarc?: number;           // ID de marca
        nombreProd?: string;        // Nombre del producto (búsqueda exacta o parcial)
        codigoBarraProd?: string;   // Código de barras
        disponibleProd?: string;    // 'S' o 'N'
        estadoProd?: string;        // Estado del producto
    }): Observable<Producto[]> {
        // Si hay filtros, usar el endpoint /filtrar, sino usar el endpoint base
        if (filtros && Object.keys(filtros).length > 0) {
            let params = new HttpParams();

            if (filtros.ideCate) {
                params = params.set('ideCate', filtros.ideCate.toString());
            }
            if (filtros.ideMarc) {
                params = params.set('ideMarc', filtros.ideMarc.toString());
            }
            if (filtros.nombreProd) {
                params = params.set('nombreProd', filtros.nombreProd);
            }
            if (filtros.codigoBarraProd) {
                params = params.set('codigoBarraProd', filtros.codigoBarraProd);
            }
            if (filtros.disponibleProd) {
                params = params.set('disponibleProd', filtros.disponibleProd);
            }
            if (filtros.estadoProd) {
                params = params.set('estadoProd', filtros.estadoProd);
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
        const params = new HttpParams().set('nombreProd', termino);
        return this.http.get<any>(`${this.apiUrl}/filtrar`, { params }).pipe(
            map(response => response?.data || response || [])
        );
    }
}
