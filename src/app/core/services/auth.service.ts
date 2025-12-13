import { Injectable, signal, inject } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Router } from '@angular/router';
import { Observable, tap, switchMap, of, catchError, map } from 'rxjs';
import { environment } from '../../../environments/environment';
import { LoginRequest, LoginResponse, RegisterRequest, Usuario } from '../models';

@Injectable({
    providedIn: 'root'
})
export class AuthService {
    private apiUrl = `${environment.apiUrl}/auth`;
    private tokenKey = 'auth_token';
    private userKey = 'user_data';

    // Señal para el estado de autenticación
    private usuarioActualSignal = signal<Usuario | null>(null);
    usuarioActual = this.usuarioActualSignal.asReadonly();

    constructor(
        private http: HttpClient,
        private router: Router
    ) {
        this.cargarSesion();
    }

    /**
     * Iniciar sesión
     */
    login(credentials: LoginRequest): Observable<LoginResponse> {
        return this.http.post<LoginResponse>(`${this.apiUrl}/login`, credentials)
            .pipe(
                switchMap(response => {
                    // Si el usuario tiene email y NO tiene ide_clie, buscarlo por email
                    if (response.user && !response.user.ide_clie) {
                        const email = this.extractEmailFromUsername(credentials.usuario);
                        if (email) {
                            return this.fetchClienteIdByEmail(email).pipe(
                                tap(ide_clie => {
                                    // Agregar ide_clie al usuario (solo si no es null)
                                    if (ide_clie !== null) {
                                        response.user.ide_clie = ide_clie;
                                    }
                                    this.guardarSesion(response.access_token, response.user);
                                }),
                                switchMap(() => of(response))
                            );
                        }
                    }
                    // Si ya tiene ide_clie o no se puede buscar, guardar directamente
                    this.guardarSesion(response.access_token, response.user);
                    return of(response);
                })
            );
    }

    /**
     * Extraer email del nombre de usuario si es un email
     */
    private extractEmailFromUsername(usuario: string): string | null {
        // Si el usuario contiene @, asumimos que es un email
        return usuario.includes('@') ? usuario : null;
    }

    /**
     * Buscar cliente ID por email usando el API de clientes
     */
    private fetchClienteIdByEmail(email: string): Observable<number | null> {
        return this.http.get<any>(`${environment.apiUrl}/clientes/filtrar`, {
            params: { email_clie: email }
        }).pipe(
            map(response => {
                const clientes = response?.data || response || [];
                return clientes.length > 0 ? clientes[0].ideClie : null;
            }),
            catchError(error => {
                console.error('Error al buscar cliente por email:', error);
                return of(null);
            })
        );
    }

    /**
     * Registrar nuevo usuario
     */
    register(data: RegisterRequest): Observable<LoginResponse> {
        return this.http.post<LoginResponse>(`${this.apiUrl}/register`, data)
            .pipe(
                tap(response => {
                    this.guardarSesion(response.access_token, response.user);
                })
            );
    }

    /**
     * Cerrar sesión
     */
    logout(): void {
        localStorage.removeItem(this.tokenKey);
        localStorage.removeItem(this.userKey);
        this.usuarioActualSignal.set(null);
        this.router.navigate(['/auth/login']);
    }

    /**
     * Verificar si está autenticado
     */
    estaAutenticado(): boolean {
        return !!this.getToken();
    }

    /**
     * Obtener token
     */
    getToken(): string | null {
        return localStorage.getItem(this.tokenKey);
    }

    /**
     * Guardar sesión
     */
    private guardarSesion(token: string, user: Usuario): void {
        localStorage.setItem(this.tokenKey, token);
        localStorage.setItem(this.userKey, JSON.stringify(user));
        this.usuarioActualSignal.set(user);
    }

    /**
     * Cargar sesión guardada
     */
    private cargarSesion(): void {
        try {
            const userData = localStorage.getItem(this.userKey);
            if (userData) {
                const user = JSON.parse(userData) as Usuario;
                this.usuarioActualSignal.set(user);
            }
        } catch (error) {
            console.error('Error al cargar sesión:', error);
        }
    }
}
