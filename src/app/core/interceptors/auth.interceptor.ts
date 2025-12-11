import { HttpInterceptorFn } from '@angular/common/http';
import { inject } from '@angular/core';
import { AuthService } from '../services';

export const authInterceptor: HttpInterceptorFn = (req, next) => {
    const authService = inject(AuthService);
    const token = authService.getToken();
    const usuario = authService.usuarioActual();

    if (token) {
        let headers = req.headers.set('Authorization', `Bearer ${token}`);

        // Agregar el header 'perfil' que requiere el RolesGuard del backend
        if (usuario?.perfil) {
            headers = headers.set('perfil', usuario.perfil);
        }

        const clonedRequest = req.clone({ headers });
        return next(clonedRequest);
    }

    return next(req);
};
