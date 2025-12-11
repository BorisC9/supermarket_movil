import { Injectable, signal } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Router } from '@angular/router';
import { Observable, tap } from 'rxjs';
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
                tap(response => {
                    this.guardarSesion(response.access_token, response.user);
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
