export enum EstadoProducto {
    ACTIVO = 'activo',
    INACTIVO = 'inactivo'
}

export interface Producto {
    // Campos que retorna el backend (pueden venir en cualquier formato)
    [key: string]: any;

    // Campos principales
    ide_prod?: number;
    ide_cate?: number;
    ide_marc?: number;
    nombre_prod?: string;
    precio_venta_prod?: any;
    stock_prod?: number;
    disponible_prod?: string;
    estado_prod?: string;
    dcto_promo_prod?: any;
    dcto_caduc_prod?: any;
    iva_prod?: any;
    url_img_prod?: string;
    descripcion_prod?: string;
    codigo_barra_prod?: string;
    precio_compra_prod?: any;
    fecha_ingre?: string;
    usua_ingre?: string;
}
