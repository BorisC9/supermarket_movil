export interface Venta {
    ideVent: number;
    ideClie: number;
    ideEmpl: number;
    numFacturaVent: string;
    fechaVent: string;
    subTotalVent: number;
    dctoVent: number;
    totalVent: number;
    estadoVent: string; // 'completado', 'cancelado', 'devuelto'
}

export interface DetalleVenta {
    ideDetaVent: number;
    ideVent: number;
    ideProd: number;
    cantidadProd: number;
    precioUnitarioProd: number;
    subtotalProd: number;
    dctoProd: number;
    dctoPromo: number;
    ivaProd: number;
}

export interface CrearVentaDTO {
    cabeceraVenta: CabeceraVentaDTO;
    detalleVenta: DetalleVentaDTO[];
}

export interface CabeceraVentaDTO {
    ideVent: number;
    ideEmpl: number;
    ideClie: number;
    numFacturaVent: string;
    fechaVent: string;
    cantidadVent: number;
    subTotalVent: number;
    totalVent: number;
    dctoVent: number;
    estadoVent: 'completado' | 'cancelado' | 'devuelto';
}

export interface DetalleVentaDTO {
    ideDetaVent: number;
    ideVent: number;
    ideProd: number;
    cantidadProd: number;
    precioUnitarioProd: number;
    subtotalProd: number;
    dctoProd: number;
    dctoPromo: number;
    ivaProd: number;
}

