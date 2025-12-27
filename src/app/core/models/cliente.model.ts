export interface Cliente {
    ideClie: number;
    cedulaClie: string;
    fechaNacimientoClie: string;
    edadClie: number;
    telefonoClie: string;
    primerNombreClie: string;
    apellidoPaternoClie: string;
    emailClie: string;
    esSocio: string;  // 'si' o 'no'
    esTerceraEdad: string;  // 'si' o 'no'
    segundoNombreClie?: string;
    apellidoMaternoClie?: string;
    usuaIngre?: string;
    fechaIngre?: string;
    usuaActua?: string;
    fechaActua?: string;
}

export interface CuentaCliente {
    ideCuenClie: number;
    ideClie: number;
    usuarioClie: string;
    emailClie: string;
    estadoClie: boolean;
    fechaIngre: string;
    fechaActua?: string;
}
