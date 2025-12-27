export interface LoginRequest {
    usuario: string;  // Campo del backend
    clave: string;    // Campo del backend
    numIntentos: number;
}

export interface LoginResponse {
    access_token: string;
    user: Usuario;
}

export interface Usuario {
    id?: number;          // ID de cuenta_cliente (ide_cuen_clie)
    ide_cuen?: number;    // Para admin (compatibilidad)
    ide_clie?: number;    // ID del cliente - PRINCIPAL para app móvil
    username?: string;    // usuario_clie o usuario_cuen
    email?: string;       // email del cliente
    usuario_cuen?: string;
    state?: string;       // Estado de la cuenta
    ide_empl?: number;    // Solo para admin
    perfil?: string;      // 'Cliente' o nombre del perfil admin
    tipo?: string;        // 'cliente' o 'admin'
    cliente?: any;        // Datos completos del cliente
    ide_perf?: number;
    nombre_perf?: string;
    ide_rol?: number;
    nombre_rol?: string;
    permisos?: any[];     // Solo para admin
    rutas_sidebar?: any[]; // Solo para admin
}

export interface RegisterRequest {
    cedulaClie: string;
    primerNombreClie: string;
    segundoNombreClie?: string;
    apellidoPaternoClie: string;
    apellidoMaternoClie?: string;
    emailClie: string;
    telefonoClie: string;
    fechaNacimientoClie: string;
    edadClie: number;
    password: string;
    esSocio?: string;
    esTerceraEdad?: string;
}
