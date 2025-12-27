import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';
import { map } from 'rxjs/operators';
import { environment } from '../../../environments/environment';
import { Categoria } from '../models';

@Injectable({
    providedIn: 'root'
})
export class CategoriaService {
    private apiUrl = `${environment.apiUrl}/mobile/categorias`;

    constructor(private http: HttpClient) { }

    /**
     * Obtener todas las categorías
     */
    obtenerCategorias(): Observable<Categoria[]> {
        return this.http.get<any>(this.apiUrl).pipe(
            map(response => response?.data || response || [])
        );
    }

    /**
     * Obtener una categoría por ID
     */
    obtenerCategoriaPorId(id: number): Observable<Categoria> {
        return this.http.get<any>(`${this.apiUrl}/${id}`).pipe(
            map(response => response?.data || response)
        );
    }
}
