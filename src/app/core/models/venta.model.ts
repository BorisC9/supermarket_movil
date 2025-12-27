export interface Venta {
    ideVent: number;
    ideClie: number;
    ideEmpl: number;
    numFacturaVent: string;
    fechaVent: string;
    cantidadVent: number;
    subTotalVent: number;
    dctoSocioVent: number;  // Descuento por ser socio
    dctoEdadVent: number;   // Descuento por tercera edad
    totalVent: number;
    estadoVent: string; // 'completado', 'cancelado', 'devuelto'
    usuaIngre?: string;
    fechaIngre?: string;
    usuaActua?: string;
    fechaActua?: string;
}

export interface DetalleVenta {
    ideDetaVent: number;
    ideVent: number;
    ideProd: number;
    cantidadProd: number;
    precioUnitarioProd: number;
    subtotalProd: number;
    dctoPromoProd: number;  // Descuento por promoción del producto
    ivaProd: number;
    totalProd: number;
    nombreProd?: string;  // Nombre del producto (cuando se hace JOIN)
}

export interface CrearVentaDTO {
    cabeceraVenta: CabeceraVentaDTO;
    detalleVenta: DetalleVentaDTO[];
}

export interface CabeceraVentaDTO {
    ideVent?: number;
    ideEmpl: number;
    ideClie: number;
    numFacturaVent: string;
    fechaVent: string;
    cantidadVent: number;
    subTotalVent: number;
    totalVent: number;
    dctoVent: number;  // Descuento total aplicado a la venta
    estadoVent: 'completado' | 'cancelado' | 'devuelto';
    usuaIngre?: string;
}

export interface DetalleVentaDTO {
    ideDetaVent?: number;
    ideVent?: number;
    ideProd: number;
    cantidadProd: number;
    precioUnitarioProd: number;
    subtotalProd: number;
    dctoPromoProd: number;  // Descuento por promoción del producto
    ivaProd: number;
    totalProd: number;
}

