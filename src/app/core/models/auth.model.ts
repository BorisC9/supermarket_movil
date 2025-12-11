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
    id?: number;          // Del backend
    ide_cuen?: number;
    username?: string;    // Del backend
    usuario_cuen?: string;
    state?: string;       // Del backend
    ide_empl?: number;
    perfil?: string;      // Del backend (nombre_perf)
    ide_perf?: number;
    nombre_perf?: string;
    ide_rol?: number;
    nombre_rol?: string;
    permisos?: any[];     // Del backend
    rutas_sidebar?: any[]; // Del backend
}

export interface RegisterRequest {
    cedulaClie: string;
    primerNombreClie: string;
    apellidoPaternoClie: string;
    emailClie: string;
    telefonoClie: string;
    fechaNacimientoClie: string;
    password: string;
}
