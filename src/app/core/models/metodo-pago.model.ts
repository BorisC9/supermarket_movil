// =====================================
// INTERFACES
// =====================================

export interface MetodoPago {
    ideMetoPago: number;
    ideClie: number;
    tipoPago: TipoPago;
    nombreTitular: string;
    numeroTarjetaMasked?: string;
    marcaTarjeta?: MarcaTarjeta;
    fechaExpiracion?: string;
    emailPaypal?: string;
    esPredeterminado: 'si' | 'no';
    alias?: string;
    estado: 'activo' | 'inactivo';
    fechaIngre?: string;
}

export interface CreateMetodoPagoDTO {
    tipoPago: TipoPago;
    nombreTitular: string;
    numeroTarjetaMasked?: string;
    marcaTarjeta?: MarcaTarjeta;
    fechaExpiracion?: string;
    emailPaypal?: string;
    esPredeterminado?: 'si' | 'no';
    alias?: string;
}

export interface UpdateMetodoPagoDTO {
    nombreTitular?: string;
    fechaExpiracion?: string;
    esPredeterminado?: 'si' | 'no';
    alias?: string;
}

// =====================================
// TIPOS
// =====================================

export type TipoPago = 'tarjeta_credito' | 'tarjeta_debito' | 'paypal';
export type MarcaTarjeta = 'visa' | 'mastercard' | 'amex' | 'diners';

// =====================================
// CONSTANTES
// =====================================

const NOMBRES_TIPO_PAGO: Record<string, string> = {
    'tarjeta_credito': 'Tarjeta de Crédito',
    'tarjeta_debito': 'Tarjeta de Débito',
    'paypal': 'PayPal'
};

const NOMBRES_MARCA: Record<string, string> = {
    'visa': 'Visa',
    'mastercard': 'Mastercard',
    'amex': 'American Express',
    'diners': 'Diners Club'
};

// =====================================
// FUNCIONES DE UTILIDAD
// =====================================

/** Obtener icono según la marca de tarjeta */
export function getIconoMarcaTarjeta(marca?: string): string {
    return marca ? 'card' : 'card-outline';
}

/** Obtener nombre legible del tipo de pago */
export function getNombreTipoPago(tipo: string): string {
    return NOMBRES_TIPO_PAGO[tipo] || tipo;
}

/** Obtener nombre legible de la marca */
export function getNombreMarca(marca: string | null): string {
    return marca ? (NOMBRES_MARCA[marca] || '') : '';
}

/** Detectar marca de tarjeta por los primeros dígitos */
export function detectarMarcaTarjeta(numero: string): MarcaTarjeta | null {
    const cleaned = numero.replace(/\s/g, '');
    if (!cleaned) return null;
    
    if (/^4/.test(cleaned)) return 'visa';
    if (/^5[1-5]/.test(cleaned)) return 'mastercard';
    if (/^3[47]/.test(cleaned)) return 'amex';
    if (/^3(?:0[0-5]|[68])/.test(cleaned)) return 'diners';
    
    return null;
}

/** Enmascarar número de tarjeta mostrando solo los últimos 4 dígitos */
export function enmascararTarjeta(numero: string): string {
    const cleaned = numero.replace(/\s/g, '');
    if (cleaned.length < 4) return cleaned;
    return `**** **** **** ${cleaned.slice(-4)}`;
}

/** Formatear número de tarjeta con espacios cada 4 dígitos */
export function formatearNumeroTarjeta(numero: string): string {
    const cleaned = numero.replace(/\D/g, '').slice(0, 16);
    const grupos = cleaned.match(/.{1,4}/g);
    return grupos ? grupos.join(' ') : cleaned;
}

/** Formatear fecha de expiración como MM/YY */
export function formatearFechaExpiracion(fecha: string): string {
    const cleaned = fecha.replace(/\D/g, '').slice(0, 4);
    if (cleaned.length >= 2) {
        return `${cleaned.slice(0, 2)}/${cleaned.slice(2)}`;
    }
    return cleaned;
}

/** Validar email con expresión regular */
export function validarEmail(email: string): boolean {
    return /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email);
}
