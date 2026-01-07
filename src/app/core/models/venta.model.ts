export interface Venta {
    ideVent: number;
    ideClie: number;
    ideEmpl: number;
    numFacturaVent: string;
    fechaVent: string;
    cantidadVent: number;
    subTotalVent: number;
    dctoSocioVent: number;
    dctoEdadVent: number;
    totalVent: number;
    estadoVent: string;
    tipoPagoVent?: string;
    ideMetoPago?: number;
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
    dctoPromoProd: number;
    ivaProd: number;
    totalProd: number;
    nombreProd?: string;
    imagenProd?: string;
}

export interface CrearVentaDTO {
    cabeceraVenta: CabeceraVentaDTO;
    detalleVenta: DetalleVentaDTO[];
}

export interface CabeceraVentaDTO {
    ideClie: number;
    numFacturaVent: string;
    fechaVent: string;
    cantidadVent: number;
    subTotalVent: number;
    totalVent: number;
    dctoSocioVent?: number;  // Descuento por ser socio
    dctoEdadVent?: number;   // Descuento por tercera edad
    usuaIngre?: string;
    tipoPagoVent?: string;   // 'efectivo', 'tarjeta_credito', 'tarjeta_debito', 'paypal'
    ideMetoPago?: number;    // ID del método de pago guardado
}

export interface DetalleVentaDTO {
    ideProd: number;
    cantidadProd: number;
    precioUnitarioProd: number;
    subtotalProd: number;
    dctoPromoProd?: number;  // Descuento por promoción del producto
    ivaProd?: number;
    totalProd: number;
}

