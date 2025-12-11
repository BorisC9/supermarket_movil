// Función helper para calcular precio final de un producto
export function calcularPrecioFinal(producto: any): number {
    if (!producto) return 0;

    const precioVenta = parseFloat(producto.precio_venta_prod?.toString() || producto.precioVentaProd?.toString() || producto.precioVenta?.toString() || '0');
    const dctoPromo = parseFloat(producto.dcto_promo_prod?.toString() || producto.dctoPromoProd?.toString() || producto.descuentoPromocion?.toString() || '0');
    const dctoCaduc = parseFloat(producto.dcto_caduc_prod?.toString() || producto.dctoCaducProd?.toString() || producto.descuentoCaducidad?.toString() || '0');

    const descuentoPromo = (precioVenta * dctoPromo) / 100;
    const descuentoCaduc = (precioVenta * dctoCaduc) / 100;
    return precioVenta - descuentoPromo - descuentoCaduc;
}

// Función helper para verificar si un producto está disponible
export function estaDisponible(producto: any): boolean {
    const disponible = producto.disponible_prod || producto.disponibleProd || producto.disponible;
    const stock = producto.stock_prod || producto.stockProd || producto.stock || 0;
    return disponible === 'si' && stock > 0;
}

// Helpers para acceder a campos del producto de forma segura
export function getProductoId(producto: any): number {
    return producto.ide_prod || producto.ideProd || producto.id || 0;
}

export function getProductoNombre(producto: any): string {
    return producto.nombre_prod || producto.nombreProd || producto.nombre || '';
}

export function getProductoStock(producto: any): number {
    return producto.stock_prod || producto.stockProd || producto.stock || 0;
}

export function getProductoDisponible(producto: any): string {
    return producto.disponible_prod || producto.disponibleProd || producto.disponible || 'no';
}

export function getProductoPrecioVenta(producto: any): number {
    return parseFloat(producto.precio_venta_prod?.toString() || producto.precioVentaProd?.toString() || producto.precioVenta?.toString() || '0');
}

export function getProductoImagen(producto: any): string {
    return producto.url_img_prod || producto.urlImgProd || producto.imagen || 'https://via.placeholder.com/300x200?text=Producto';
}

export function getProductoDctoPromo(producto: any): number {
    return parseFloat(producto.dcto_promo_prod?.toString() || producto.dctoPromoProd?.toString() || producto.descuentoPromocion?.toString() || '0');
}

export function getProductoIva(producto: any): number {
    return parseFloat(producto.iva_prod?.toString() || producto.ivaProd?.toString() || producto.iva?.toString() || '0');
}

export function getProductoDescuento(producto: any): number {
    const dctoPromo = parseFloat(producto.dcto_promo_prod?.toString() || producto.dctoPromoProd?.toString() || producto.descuentoPromocion?.toString() || '0');
    const dctoCaduc = parseFloat(producto.dcto_caduc_prod?.toString() || producto.dctoCaducProd?.toString() || producto.descuentoCaducidad?.toString() || '0');
    return dctoPromo + dctoCaduc;
}

// Helpers para categoría
export function getCategoriaId(categoria: any): number {
    return categoria.ide_cate || categoria.ideCate || categoria.id || 0;
}

export function getCategoriaNombre(categoria: any): string {
    return categoria.nombre_cate || categoria.nombreCate || categoria.nombre || '';
}
