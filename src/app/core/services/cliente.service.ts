import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';
import { map } from 'rxjs/operators';
import { environment } from '../../../environments/environment';
import { Cliente } from '../models';

@Injectable({
    providedIn: 'root'
})
export class ClienteService {
    private apiUrl = `${environment.apiUrl}/mobile/clientes`;

    constructor(private http: HttpClient) { }

    /**
     * Obtener perfil del cliente autenticado
     * El backend obtiene el ID del cliente desde el token JWT
     */
    obtenerPerfil(): Observable<Cliente> {
        return this.http.get<any>(`${this.apiUrl}/perfil`).pipe(
            map(response => response?.data || response)
        );
    }

    /**
     * Obtener información del cliente por ID (alias para compatibilidad)
     */
    obtenerCliente(idCliente?: number): Observable<Cliente> {
        return this.obtenerPerfil();
    }

    /**
     * Actualizar perfil del cliente autenticado
     */
    actualizarPerfil(cliente: Partial<Cliente>): Observable<Cliente> {
        return this.http.put<any>(`${this.apiUrl}/perfil`, cliente).pipe(
            map(response => response?.data || response)
        );
    }

    /**
     * Actualizar información del cliente (alias para compatibilidad)
     */
    actualizarCliente(idCliente: number, cliente: Partial<Cliente>): Observable<Cliente> {
        return this.actualizarPerfil(cliente);
    }
}
