# 🔍 Análisis del Problema: App Móvil no visualiza productos

## ❌ Problema Identificado

La aplicación móvil **NO puede acceder a los productos** porque:

### Backend Actual:
```typescript
@UseGuards(AuthGuard('jwt'), RolesGuard)
@Roles('padmin', 'pinventario')
@Controller('productos')
export class ProductosController {
    @Get()
    async listar() {
        return this.servicio.listar(); 
    }
}
```

**Todas las rutas de productos requieren**:
1. ✅ Token JWT válido (`AuthGuard('jwt')`)
2. ✅ Rol específico (`'padmin'` o `'pinventario'`)

### App Móvil Actual:
- ❌ Intenta acceder a `/productos` sin autenticación
- ❌ No tiene token JWT
- ❌ Recibe error 401 Unauthorized

---

## 📊 Estado del Backend

### Módulos Existentes:
```
src/modules/
├── admin/          ← PROTEGIDO (requiere auth + roles)
│   ├── productos/
│   ├── ventas/
│   └── ...
├── auth/           ← Login disponible
└── landing/        ← VACÍO (sin implementar)
```

### Módulo Landing:
```typescript
// landing.module.ts
@Module({})
export class LandingModule {}  // ← VACÍO, sin controladores
```

**Este módulo está registrado pero NO tiene nada implementado.**

---

## 💡 Soluciones Posibles

### Opción 1: Usar Autenticación (Recomendado para producción)

**Pros:**
- ✅ Seguro
- ✅ Control de acceso
- ✅ Auditoría de usuarios

**Contras:**
- ❌ Requiere login antes de ver productos
- ❌ Menos fricción para usuarios nuevos

**Implementación en App Móvil:**
```typescript
// 1. Usuario debe hacer login primero
authService.login(credentials) → obtiene token

// 2. Token se envía automáticamente (ya configurado)
authInterceptor → agrega header Authorization

// 3. Ahora puede acceder a productos
productoService.obtenerProductos() → ✅ Funciona
```

---

### Opción 2: Crear Rutas Públicas (Recomendado para app móvil)

**Necesitas que el backend implemente rutas públicas** sin autenticación:

```typescript
// Nuevo: landing/productos.controller.ts
@Controller('public/productos')  // ← Sin @UseGuards
export class PublicProductosController {
    
    @Get()
    async listarPublico() {
        // Solo productos activos y disponibles
        return this.servicio.listarPublicos(); 
    }

    @Get(':id')
    async buscarPublico(@Param('id') id: number) {
        return this.servicio.buscarPublico(id);
    }

    @Get('categoria/:idCategoria')
    async listarPorCategoria(@Param('idCategoria') id: number) {
        return this.servicio.listarPorCategoria(id);
    }
}

// Nuevo: landing/categorias.controller.ts
@Controller('public/categorias')
export class PublicCategoriasController {
    
    @Get()
    async listarPublico() {
        return this.servicio.listar();
    }
}
```

**Ventajas:**
- ✅ Los usuarios pueden ver productos sin login
- ✅ Solo requiere auth para checkout/compra
- ✅ Mejor UX para e-commerce
- ✅ Las rutas admin siguen protegidas

---

### Opción 3: Modificar Guards (NO recomendado)

Quitar protección de algunas rutas existentes.

**NO RECOMENDADO** porque:
- ❌ Expone endpoints administrativos
- ❌ Pierde control de acceso
- ❌ Problemas de seguridad

---

## 🎯 Recomendación

### Implementar Opción 2: Rutas Públicas en Landing Module

#### Backend necesita:

1. **Crear controladores públicos**:
   ```
   src/modules/landing/
   ├── productos/
   │   ├── productos.controller.ts   ← @Controller('public/productos')
   │   └── productos.service.ts
   ├── categorias/
   │   └── categorias.controller.ts  ← @Controller('public/categorias')
   └── landing.module.ts             ← Registrar controladores
   ```

2. **Reusar servicios existentes**:
   - Los servicios de productos/categorías ya funcionan
   - Solo necesitas nuevos controladores SIN guards

3. **Filtrar datos sensibles**:
   ```typescript
   async listarPublicos() {
       const productos = await this.productoRepository.find({
           where: {
               estado_prod: 'activo',
               disponible_prod: 'si'
           },
           select: [
               'ide_prod',
               'nombre_prod',
               'precio_venta_prod',
               'dcto_promo_prod',
               'stock_prod',
               // NO incluir: precio_compra_prod
           ]
       });
       return productos;
   }
   ```

#### App Móvil necesita:

Cambiar las URLs de:
```typescript
// Antes
private apiUrl = `${environment.apiUrl}/productos`;

// Después
private apiUrl = `${environment.apiUrl}/public/productos`;
```

---

## 📝 Lo que NO debes modificar en Backend

### Mantener intacto:
- ✅ `admin/productos` - Sigue protegido
- ✅ Auth guards - Siguen funcionando
- ✅ Roles - Siguen validando
- ✅ JWT strategy - Sigue igual

### Solo agregar:
- ✅ Nuevos controladores en `landing/`
- ✅ Rutas con prefijo `public/`
- ✅ Sin guards de autenticación

---

## 🔐 Flujo Recomendado para App Móvil

```
1. Usuario abre app
   ↓
2. Ve productos (public/productos) ← SIN AUTH
   ↓
3. Agrega al carrito (local)
   ↓
4. Va a checkout
   ↓
5. Requiere LOGIN ← AQUÍ SÍ AUTH
   ↓
6. Crea venta (requiere token)
```

---

## 🚀 Implementación Rápida

### Backend (Nuevo archivo):

**src/modules/landing/productos/public-productos.controller.ts:**
```typescript
import { Controller, Get, Param, Query } from '@nestjs/common';
import { ProductosService } from '../../admin/productos/productos/productos.service';

@Controller('public/productos')
export class PublicProductosController {
    constructor(private readonly productosService: ProductosService) {}

    @Get()
    async listar() {
        // Reutiliza el servicio existente
        const productos = await this.productosService.listar();
        
        // Filtra solo productos públicos
        return productos.filter(p => 
            p.estado_prod === 'activo' && 
            p.disponible_prod === 'si'
        );
    }

    @Get(':id')
    async buscar(@Param('id') id: number) {
        return this.productosService.buscar(id);
    }
}
```

**src/modules/landing/landing.module.ts:**
```typescript
import { Module } from '@nestjs/common';
import { PublicProductosController } from './productos/public-productos.controller';
import { ProductosModule } from '../admin/productos/productos/productos.module';

@Module({
    imports: [ProductosModule], // Importa para reusar servicios
    controllers: [PublicProductosController]
})
export class LandingModule {}
```

### App Móvil:

**src/app/core/services/producto.service.ts:**
```typescript
private apiUrl = `${environment.apiUrl}/public/productos`;
```

---

## ⚠️ Consideración Importante

Si prefieres que **TODA la app requiera autenticación** (como Instagram, Facebook):

1. Usuario debe hacer login primero
2. Solo usuarios autenticados ven productos
3. Más control y datos del usuario

Pero esto **reduce conversión** en e-commerce.

---

## 📌 Resumen

**Problema:** Backend requiere auth, app móvil no tiene token

**Solución:** Crear rutas públicas en `landing/` para productos sin auth

**¿Qué hacer?**
1. Implementar controladores públicos en backend
2. Actualizar URLs en app móvil a `public/productos`
3. Mantener auth solo para checkout/ventas

**¿Modificar backend existente?** NO, solo agregar nuevos controladores públicos.
