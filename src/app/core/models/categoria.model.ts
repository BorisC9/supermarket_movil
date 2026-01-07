export interface Categoria {
    [key: string]: any;
    ide_cate?: number;
    nombre_cate?: string;
    descripcion_cate?: string;
}

/**
 * Mapa de categorías específicas a iconos de Ionicons.
 * Editar manualmente cuando se agreguen nuevas categorías.
 */
const ICONOS_CATEGORIA: Record<string, string> = {
    'Películas y Entretenimiento': 'film-outline',
    'Tecnología y Accesorios': 'desktop-outline',
    'Hogar y Limpieza': 'home-outline',
    'Alimentos y Abarrotes': 'nutrition-outline',
    'Deportes y Recreación': 'fitness-outline',
    'Iluminación y Herramientas': 'construct-outline'
};

/** Icono por defecto para categorías no mapeadas */
const ICONO_GENERICO = 'pricetag-outline';

/**
 * Obtiene el icono para una categoría.
 * @param nombreCategoria - El nombre exacto de la categoría
 * @returns El nombre del icono de Ionicons
 */
export function getIconoCategoria(nombreCategoria: string | undefined | null): string {
    if (!nombreCategoria) return ICONO_GENERICO;
    return ICONOS_CATEGORIA[nombreCategoria] || ICONO_GENERICO;
}
