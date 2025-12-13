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
    private apiUrl = `${environment.apiUrl}/clientes`;

    constructor(private http: HttpClient) { }

    /**
     * Obtener información del cliente por ID
     */
    obtenerCliente(idCliente: number): Observable<Cliente> {
        return this.http.get<any>(`${this.apiUrl}/buscar/${idCliente}`).pipe(
            map(response => response?.data || response)
        );
    }

    /**
     * Actualizar información del cliente
     */
    actualizarCliente(idCliente: number, cliente: Partial<Cliente>): Observable<Cliente> {
        return this.http.put<any>(`${this.apiUrl}/actualizar/${idCliente}`, cliente).pipe(
            map(response => response?.data || response)
        );
    }

    /**
     * Buscar cliente por DNI
     */
    buscarPorDni(dni: string): Observable<Cliente> {
        return this.http.get<any>(`${this.apiUrl}/dni/${dni}`).pipe(
            map(response => response?.data || response)
        );
    }

    /**
     * Buscar cliente por email
     */
    buscarPorEmail(email: string): Observable<Cliente | null> {
        return this.http.get<any>(`${this.apiUrl}/filtrar`, {
            params: { email_clie: email }
        }).pipe(
            map(response => {
                const clientes = response?.data || response || [];
                return clientes.length > 0 ? clientes[0] : null;
            })
        );
    }
}
