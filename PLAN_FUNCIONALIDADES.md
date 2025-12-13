# 📱 Plan de Funcionalidades para Supermarket Móvil

## 📊 Análisis del Backend Actual

### ✅ Endpoints Disponibles (Protegidos con JWT)

| Módulo | Endpoint | Roles Requeridos | Estado |
|--------|----------|------------------|---------|
| Autenticación | `/api/auth/login` | Público | ✅ Funcional |
| Productos | `/api/productos` | `padmin`, `pinventario` | ✅ Funcional |
| Categorías | `/api/categorias` | `padmin`, `pinventario` | ✅ Funcional |
| Marcas | `/api/marcas` | `padmin`, `pinventario` | ✅ Funcional |
| Ventas | `/api/ventas` | `padmin`, `pventas` | ✅ Funcional |
| Clientes | `/api/clientes` | `padmin`, `pventas` | ✅ Funcional |
| Cuentas | `/api/cuentas` | `padmin`, `pseguridad` | ✅ Funcional |

### 📋 Campos Disponibles en Base de Datos

#### Tabla `cliente`
```sql
- ide_clie (ID)
- cedula_clie (Cédula)
- primer_nombre_clie, segundo_nombre_clie
- apellido_paterno_clie, apellido_materno_clie
- email_clie
- telefono_clie
- fecha_nacimiento_clie, edad_clie
- es_socio ('si' / 'no') ⭐
- es_tercera_edad ('si' / 'no')
```

#### Tabla `venta`
```sql
- ide_vent (ID)
- ide_empl (Empleado)
- ide_clie (Cliente)
- num_factura_vent
- fecha_vent
- cantidad_vent
- sub_total_vent
- dcto_vent
- total_vent
- estado_vent ('completado', 'cancelado', 'devuelto')
```

#### Tabla `cuenta`
```sql
- ide_cuen (ID)
- ide_empl (Empleado)
- ide_perf (Perfil)
- usuario_cuen
- password_cuen
- estado_cuen ('activo', 'inactivo', 'bloqueado')
```

---

## 🎯 FUNCIONALIDADES QUE SE PUEDEN IMPLEMENTAR YA

### 1. ✅ Página de Perfil del Usuario (RECOMENDADO)

**Backend:** Ya soportado
**Endpoints necesarios:**
- `GET /api/clientes/buscar/:id` ✅
- `PUT /api/clientes/actualizar/:id` ✅
- `PUT /api/cuentas/actualizar/:id` ✅

**Funcionalidades:**
```typescript
✅ Ver datos personales (nombre, email, teléfono, cédula)
✅ Editar datos personales
✅ Cambiar contraseña
✅ Ver estado de membresía (es_socio: 'si' / 'no')
✅ Ver si es tercera edad
✅ Ver fecha de nacimiento y edad
```

**Pantallas sugeridas:**
- `perfil/perfil.page.ts` - Vista principal del perfil
- `perfil/editar-perfil.page.ts` - Editar datos personales
- `perfil/cambiar-password.page.ts` - Cambiar contraseña

---

### 2. ✅ Historial de Compras/Ventas (RECOMENDADO)

**Backend:** Ya soportado
**Endpoints necesarios:**
- `GET /api/ventas/filtrar?ideClie={id}` ✅
- `GET /api/ventas/buscar/:id` ✅ (detalle de una venta)

**Funcionalidades:**
```typescript
✅ Ver historial de compras del cliente
✅ Filtrar por fecha
✅ Ver detalles de cada compra (productos, cantidades, precios)
✅ Ver número de factura
✅ Ver estado de la venta (completado, cancelado, devuelto)
✅ Descargar/ver factura
```

**Pantallas sugeridas:**
- `perfil/historial-compras.page.ts`
- `perfil/detalle-compra.page.ts`

---

### 3. ✅ Filtros de Productos (PARCIALMENTE IMPLEMENTADO)

**Backend:** Ya soportado
**Endpoints necesarios:**
- `GET /api/productos/filtrar?ideCate=X&disponible=S&busqueda=texto` ✅
- `GET /api/categorias` ✅
- `GET /api/marcas` ✅

**Funcionalidades a mejorar:**
```typescript
✅ Filtro por categorías (ya existe, mejorar UI)
✅ Filtro por marcas (NUEVO)
✅ Filtro por precio (min-max)
✅ Filtro por disponibilidad
✅ Ordenar por:
   - Precio (ascendente/descendente)
   - Descuento
   - Stock
   - Nombre
✅ Búsqueda por código de barras
```

**Mejoras sugeridas:**
- Mejorar UI de filtros (modal o drawer)
- Agregar chips para filtros activos
- Guardar preferencias de filtros

---

### 4. ⚠️ Métodos de Pago (REQUIERE BACKEND)

**Estado actual:** ❌ NO IMPLEMENTADO EN BACKEND

**Lo que existe:**
- Campo `estado_vent` en la tabla `venta`
- NO hay tabla para métodos de pago
- NO hay campo para método de pago en venta

**Sugerencias:**

#### Opción A: Solo mostrar opciones (sin guardar)
```typescript
// En el móvil, solo mostrar opciones visuales
// El backend registra la venta sin especificar método
✅ Efectivo
✅ Tarjeta de crédito
✅ Tarjeta de débito
✅ Transferencia
✅ PayPal / Stripe (futuro)
```

#### Opción B: Modificar Backend (RECOMENDADO)
Ver sección "Cambios Necesarios en Backend"

---

### 5. ✅ Programa de Membresía/Socio (Ya existe en BD)

**Backend:** Campo `es_socio` ya existe ✅
**Endpoints necesarios:**
- `GET /api/clientes/buscar/:id` ✅
- `PUT /api/clientes/actualizar/:id` ✅

**Funcionalidades:**
```typescript
✅ Mostrar estado de membresía
✅ Mostrar beneficios si es socio:
   - Descuentos especiales
   - Acumulación de puntos (si se implementa)
   - Ofertas exclusivas
✅ Permitir solicitar membresía (cambiar es_socio a 'si')
```

---

## 🆕 FUNCIONALIDADES ADICIONALES SUGERIDAS

### 6. ✅ Notificaciones Push

**Backend:** Requiere agregar tabla
**Funcionalidades:**
```typescript
✅ Notificar nuevas ofertas
✅ Notificar cuando productos en wishlist tienen descuento
✅ Notificar estado de pedidos
✅ Notificar cambios en cuenta
```

---

### 7. ✅ Lista de Deseos (Wishlist)

**Backend:** ⚠️ Requiere nueva tabla
**Funcionalidades:**
```typescript
✅ Agregar productos a favoritos
✅ Ver lista de productos favoritos
✅ Recibir notificaciones de ofertas
✅ Mover de wishlist al carrito
```

---

### 8. ✅ Reseñas y Calificaciones

**Backend:** ⚠️ Requiere nueva tabla
**Funcionalidades:**
```typescript
✅ Calificar productos (1-5 estrellas)
✅ Escribir reseña
✅ Ver reseñas de otros usuarios
✅ Filtrar productos por calificación
```

---

## 🔧 CAMBIOS NECESARIOS EN BACKEND Y BASE DE DATOS

### A. Para Métodos de Pago

#### 1. Crear tabla `metodo_pago`
```sql
CREATE TABLE metodo_pago (
    ide_metodo integer PRIMARY KEY,
    nombre_metodo varchar(50) NOT NULL, -- 'Efectivo', 'Tarjeta', etc.
    descripcion_metodo varchar(250),
    activo_metodo varchar(2) DEFAULT 'si',
    icono_metodo varchar(50) -- nombre del icono
);
```

#### 2. Modificar tabla `venta`
```sql
ALTER TABLE venta 
ADD COLUMN ide_metodo integer REFERENCES metodo_pago(ide_metodo);
```

#### 3. Crear endpoints
```typescript
// Backend nuevo
@Controller('metodos-pago')
export class MetodosPagoController {
    @Get() // Listar métodos disponibles
    @Get('activos') // Solo métodos activos
}
```

---

### B. Para Lista de Deseos (Wishlist)

#### 1. Crear tabla `wishlist`
```sql
CREATE TABLE wishlist (
    ide_wish integer PRIMARY KEY,
    ide_clie integer REFERENCES cliente(ide_clie),
    ide_prod integer REFERENCES producto(ide_prod),
    fecha_agregado timestamp DEFAULT CURRENT_TIMESTAMP,
    UNIQUE(ide_clie, ide_prod)
);
```

#### 2. Crear endpoints
```typescript
@Controller('wishlist')
export class WishlistController {
    @Get(':idCliente') // Obtener wishlist del cliente
    @Post('agregar') // Agregar producto
    @Delete('eliminar/:idWish') // Eliminar producto
}
```

---

### C. Para Reseñas y Calificaciones

#### 1. Crear tabla `resena_producto`
```sql
CREATE TABLE resena_producto (
    ide_resena integer PRIMARY KEY,
    ide_prod integer REFERENCES producto(ide_prod),
    ide_clie integer REFERENCES cliente(ide_clie),
    calificacion integer CHECK (calificacion >= 1 AND calificacion <= 5),
    comentario varchar(500),
    fecha_resena timestamp DEFAULT CURRENT_TIMESTAMP,
    UNIQUE(ide_prod, ide_clie) -- Un cliente solo puede reseñar una vez por producto
);
```

#### 2. Crear endpoints
```typescript
@Controller('resenas')
export class ResenasController {
    @Get('producto/:idProd') // Obtener reseñas de un producto
    @Post('crear') // Crear reseña
    @Put('actualizar/:id') // Actualizar reseña
    @Delete('eliminar/:id') // Eliminar reseña
}
```

---

### D. Para Programa de Puntos/Recompensas

#### 1. Crear tabla `puntos_cliente`
```sql
CREATE TABLE puntos_cliente (
    ide_puntos integer PRIMARY KEY,
    ide_clie integer REFERENCES cliente(ide_clie),
    puntos_acumulados integer DEFAULT 0,
    puntos_usados integer DEFAULT 0,
    puntos_disponibles integer GENERATED ALWAYS AS (puntos_acumulados - puntos_usados) STORED,
    fecha_actualizacion timestamp DEFAULT CURRENT_TIMESTAMP
);
```

#### 2. Crear tabla `historial_puntos`
```sql
CREATE TABLE historial_puntos (
    ide_hist_puntos integer PRIMARY KEY,
    ide_clie integer REFERENCES cliente(ide_clie),
    ide_vent integer REFERENCES venta(ide_vent),
    puntos integer,
    tipo varchar(20), -- 'ganado', 'canjeado', 'expirado'
    descripcion varchar(250),
    fecha timestamp DEFAULT CURRENT_TIMESTAMP
);
```

---

### E. Para Notificaciones

#### 1. Crear tabla `notificacion`
```sql
CREATE TABLE notificacion (
    ide_notif integer PRIMARY KEY,
    ide_clie integer REFERENCES cliente(ide_clie),
    titulo varchar(100),
    mensaje varchar(500),
    tipo varchar(50), -- 'oferta', 'pedido', 'cuenta', 'general'
    leida varchar(2) DEFAULT 'no',
    fecha_creacion timestamp DEFAULT CURRENT_TIMESTAMP,
    fecha_leida timestamp
);
```

---

## 📋 PRIORIDADES RECOMENDADAS

### 🔥 ALTA PRIORIDAD (Implementar Ya)
1. **Página de Perfil** - Backend ya soporta
2. **Historial de Compras** - Backend ya soporta
3. **Mejorar Filtros de Productos** - Backend ya soporta
4. **Mostrar Membresía** - Backend ya soporta

### ⚡ MEDIA PRIORIDAD (Requiere cambios menores)
5. **Métodos de Pago** - Requiere nueva tabla
6. **Lista de Deseos** - Requiere nueva tabla

### 🔮 BAJA PRIORIDAD (Futuro)
7. **Reseñas y Calificaciones** - Requiere nueva tabla
8. **Programa de Puntos** - Requiere nuevas tablas
9. **Notificaciones Push** - Requiere nueva tabla + servicio

---

## 🎨 ESTRUCTURA DE CARPETAS SUGERIDA

```
supermarket_movil/src/app/
├── pages/
│   ├── auth/
│   │   └── login.page.ts ✅
│   ├── productos/
│   │   ├── productos.page.ts ✅
│   │   └── producto-detalle.page.ts ✅
│   ├── carrito/
│   │   └── carrito.page.ts ✅
│   ├── checkout/
│   │   └── checkout.page.ts ✅
│   ├── perfil/ 🆕
│   │   ├── perfil.page.ts (vista principal)
│   │   ├── editar-perfil.page.ts
│   │   ├── cambiar-password.page.ts
│   │   ├── historial-compras.page.ts
│   │   ├── detalle-compra.page.ts
│   │   └── membresia.page.ts
│   └── wishlist/ 🆕
│       └── wishlist.page.ts
├── shared/
│   └── components/
│       ├── filtros-modal/ 🆕
│       ├── metodo-pago-selector/ 🆕
│       └── calificacion-estrellas/ 🆕
```

---

## 📝 RESUMEN EJECUTIVO

### ✅ Puedes Implementar YA (sin cambios en backend):
- ✅ Página de Perfil completa
- ✅ Historial de Compras/Ventas
- ✅ Editar datos del cliente
- ✅ Cambiar contraseña
- ✅ Mejorar filtros de productos (categorías, marcas, precio)
- ✅ Mostrar estado de membresía
- ✅ Ordenamiento de productos

### ⚠️ Requiere Cambios Menores en Backend:
- ⚠️ Métodos de pago (nueva tabla + endpoints)
- ⚠️ Lista de deseos (nueva tabla + endpoints)

### 🔮 Requiere Cambios Mayores (Futuro):
- 🔮 Reseñas y calificaciones
- 🔮 Programa de puntos
- 🔮 Notificaciones push

---

## 🚀 PLAN DE ACCIÓN INMEDIATO

1. **Implementar Página de Perfil** (3-4 horas)
2. **Implementar Historial de Compras** (2-3 horas)
3. **Mejorar Filtros de Productos** (2-3 horas)
4. **Agregar Modal de Métodos de Pago** (1 hora - solo visual)

**Total estimado:** 8-11 horas de desarrollo en móvil

---

¿Quieres que implemente alguna de estas funcionalidades ahora? 🚀
