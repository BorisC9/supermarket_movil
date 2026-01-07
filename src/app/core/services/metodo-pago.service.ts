import { Injectable, signal } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable, tap, catchError, of } from 'rxjs';
import { environment } from '../../../environments/environment';
import { MetodoPago, CreateMetodoPagoDTO, UpdateMetodoPagoDTO } from '../models';

/**
 * Servicio para gestionar métodos de pago del cliente.
 * Mantiene un estado local con signals para acceso reactivo.
 */
@Injectable({
    providedIn: 'root'
})
export class MetodoPagoService {
    private readonly apiUrl = `${environment.apiUrl}/mobile/metodos-pago`;
    
    // Estado reactivo
    readonly metodosPago = signal<MetodoPago[]>([]);
    readonly cargando = signal<boolean>(false);

    constructor(private http: HttpClient) { }

    /** Obtener todos los métodos de pago del cliente autenticado */
    obtenerMetodosPago(): Observable<MetodoPago[]> {
        this.cargando.set(true);
        
        return this.http.get<MetodoPago[]>(this.apiUrl).pipe(
            tap(metodos => {
                this.metodosPago.set(metodos || []);
                this.cargando.set(false);
            }),
            catchError(() => {
                this.cargando.set(false);
                return of([]);
            })
        );
    }

    /** Obtener el método de pago marcado como predeterminado */
    obtenerMetodoPredeterminado(): MetodoPago | undefined {
        return this.metodosPago().find(m => m.esPredeterminado === 'si');
    }

    /** Crear nuevo método de pago */
    crearMetodoPago(metodo: CreateMetodoPagoDTO): Observable<any> {
        return this.http.post(this.apiUrl, metodo).pipe(
            tap(() => this.obtenerMetodosPago().subscribe())
        );
    }

    /** Actualizar método de pago existente */
    actualizarMetodoPago(id: number, metodo: UpdateMetodoPagoDTO): Observable<any> {
        return this.http.put(`${this.apiUrl}/${id}`, metodo).pipe(
            tap(() => this.obtenerMetodosPago().subscribe())
        );
    }

    /** Eliminar método de pago (soft delete en backend) */
    eliminarMetodoPago(id: number): Observable<any> {
        return this.http.delete(`${this.apiUrl}/${id}`).pipe(
            tap(() => {
                this.metodosPago.update(lista => lista.filter(m => m.ideMetoPago !== id));
            })
        );
    }

    /** Establecer un método como predeterminado */
    establecerPredeterminado(id: number): Observable<any> {
        return this.http.put(`${this.apiUrl}/${id}/predeterminado`, {}).pipe(
            tap(() => {
                this.metodosPago.update(lista => 
                    lista.map(m => ({
                        ...m,
                        esPredeterminado: m.ideMetoPago === id ? 'si' : 'no'
                    } as MetodoPago))
                );
            })
        );
    }

    /** Limpiar datos al cerrar sesión */
    limpiarDatos(): void {
        this.metodosPago.set([]);
    }
}
