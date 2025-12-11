# Aplicación Móvil Supermercado - Ionic + Angular

## Estructura del Proyecto

La aplicación móvil ha sido estructurada siguiendo las mejores prácticas de Ionic y Angular, con una arquitectura modular y escalable.

### 📁 Estructura de Carpetas

```
supermarket_movil/src/app/
├── core/                          # Funcionalidad central de la app
│   ├── models/                    # Interfaces y modelos de datos
│   │   ├── producto.model.ts
│   │   ├── categoria.model.ts
│   │   ├── cliente.model.ts
│   │   ├── venta.model.ts
│   │   ├── carrito.model.ts
│   │   ├── auth.model.ts
│   │   └── index.ts
│   ├── services/                  # Servicios para comunicación con API
│   │   ├── producto.service.ts
│   │   ├── categoria.service.ts
│   │   ├── venta.service.ts
│   │   ├── carrito.service.ts
│   │   ├── auth.service.ts
│   │   └── index.ts
│   ├── guards/                    # Guards para protección de rutas
│   │   └── auth.guard.ts
│   └── interceptors/              # Interceptores HTTP
│       └── auth.interceptor.ts
├── pages/                         # Páginas de la aplicación
│   ├── productos/                 # Listado de productos
│   ├── carrito/                   # Carrito de compras
│   ├── checkout/                  # Finalizar compra
│   ├── auth/                      # Login y registro
│   └── perfil/                    # Perfil de usuario
└── shared/                        # Componentes compartidos
    └── components/
        ├── producto-card/         # Card de producto
        ├── loading-spinner/       # Spinner de carga
        └── empty-state/           # Estado vacío
```

## 🎯 Funcionalidades Implementadas

### 1. **Gestión de Productos**
- ✅ Listado de productos con filtros por categoría
- ✅ Búsqueda de productos
- ✅ Visualización de precios con descuentos
- ✅ Indicador de stock disponible
- ✅ Imágenes de productos

### 2. **Carrito de Compras**
- ✅ Agregar/eliminar productos
- ✅ Modificar cantidades
- ✅ Cálculo automático de totales
- ✅ Aplicación de descuentos
- ✅ Persistencia en localStorage
- ✅ Gestión de estado con Signals

### 3. **Proceso de Compra (Checkout)**
- ✅ Resumen del pedido
- ✅ Selección de método de pago
- ✅ Información de entrega
- ✅ Confirmación de compra
- ✅ Integración con API de ventas

### 4. **Autenticación**
- ✅ Login de usuarios
- ✅ Registro de nuevos clientes
- ✅ Protección de rutas con guards
- ✅ Interceptor para tokens JWT
- ✅ Gestión de sesión

## 🔧 Servicios Principales

### ProductoService
```typescript
- obtenerProductos(filtros?)
- obtenerProductoPorId(id)
- obtenerProductosDestacados()
- buscarProductos(termino)
```

### CarritoService
```typescript
- agregarProducto(producto, cantidad)
- actualizarCantidad(idProducto, cantidad)
- eliminarProducto(idProducto)
- limpiarCarrito()
```

### VentaService
```typescript
- crearVenta(ventaDTO)
- obtenerHistorialVentas(idCliente)
- obtenerDetalleVenta(idVenta)
```

### AuthService
```typescript
- login(credentials)
- register(data)
- logout()
- estaAutenticado()
```

## 🛣️ Rutas Configuradas

| Ruta | Componente | Guard | Descripción |
|------|-----------|-------|-------------|
| `/` | → `/productos` | - | Redirección a productos |
| `/productos` | ProductosPage | - | Catálogo de productos |
| `/carrito` | CarritoPage | - | Carrito de compras |
| `/checkout` | CheckoutPage | ✅ Auth | Finalizar compra |
| `/auth/login` | LoginPage | - | Iniciar sesión |

## 🔐 Seguridad

- **Auth Guard**: Protege rutas que requieren autenticación
- **Auth Interceptor**: Añade token JWT a todas las peticiones HTTP
- **Gestión de sesión**: Persistencia segura en localStorage

## 📱 Características de UI/UX

- **Diseño responsivo** con Ionic components
- **Estados de carga** con spinners
- **Estados vacíos** informativos
- **Badges** para cantidades en carrito
- **Indicadores visuales** de descuentos y stock
- **Navegación intuitiva** con back buttons

## 🔄 Integración con Backend

La app móvil se conecta al backend NestJS (`supermarket_backend`) a través de:

### Endpoints utilizados:
```
GET    /api/productos              # Listar productos
GET    /api/productos/:id          # Detalle producto
GET    /api/categorias             # Listar categorías
POST   /api/ventas                 # Crear venta
GET    /api/ventas/cliente/:id     # Historial ventas
POST   /api/auth/login             # Autenticación
POST   /api/auth/register          # Registro
```

## ⚙️ Configuración

### Environments

**environment.ts** (Desarrollo):
```typescript
export const environment = {
  production: false,
  apiUrl: 'http://localhost:3000/api'
};
```

**environment.prod.ts** (Producción):
```typescript
export const environment = {
  production: true,
  apiUrl: 'https://api.tudominio.com/api'
};
```

## 🚀 Próximos Pasos

Para completar la aplicación:

1. **Implementar página de perfil** con historial de compras
2. **Agregar página de registro** completa
3. **Implementar notificaciones** (toast/alerts)
4. **Agregar imágenes por defecto** en `/assets/img/`
5. **Implementar detalle de producto** (página individual)
6. **Agregar filtros avanzados** (precio, marca)
7. **Implementar favoritos**
8. **Agregar escaneo de código de barras**

## 📦 Instalación

```bash
cd supermarket_movil
npm install
```

## 🏃 Ejecución

```bash
# Desarrollo web
ionic serve

# Desarrollo móvil
ionic capacitor run android
ionic capacitor run ios
```

## 🧪 Testing

```bash
npm test
```

---

**Nota**: Asegúrate de que el backend esté corriendo en `http://localhost:3000` antes de iniciar la app móvil.
