import { Routes } from '@angular/router';
import { authGuard } from './core/guards/auth.guard';

export const routes: Routes = [
  {
    path: '',
    redirectTo: 'productos',
    pathMatch: 'full',
  },
  {
    path: 'auth',
    children: [
      {
        path: 'login',
        loadComponent: () => import('./pages/auth/login/login.page').then(m => m.LoginPage)
      },
      {
        path: 'register',
        loadComponent: () => import('./pages/auth/register/register.page').then(m => m.RegisterPage)
      },
      {
        path: '',
        redirectTo: 'login',
        pathMatch: 'full'
      }
    ]
  },
  {
    path: 'productos',
    loadComponent: () => import('./pages/productos/productos.page').then(m => m.ProductosPage),
    canActivate: [authGuard]
  },
  {
    path: 'producto-detalle/:id',
    loadComponent: () => import('./pages/producto-detalle/producto-detalle.page').then(m => m.ProductoDetallePage),
    canActivate: [authGuard]
  },
  {
    path: 'carrito',
    loadComponent: () => import('./pages/carrito/carrito.page').then(m => m.CarritoPage),
    canActivate: [authGuard]
  },
  {
    path: 'checkout',
    loadComponent: () => import('./pages/checkout/checkout.page').then(m => m.CheckoutPage),
    canActivate: [authGuard]
  },
  {
    path: 'perfil',
    children: [
      {
        path: '',
        loadComponent: () => import('./pages/usuario/perfil/perfil.page').then(m => m.PerfilPage)
      },
      {
        path: 'editar',
        loadComponent: () => import('./pages/usuario/editar-perfil/editar-perfil.page').then(m => m.EditarPerfilPage)
      },
      {
        path: 'historial-compras',
        loadComponent: () => import('./pages/usuario/historial-compras/historial-compras.page').then(m => m.HistorialComprasPage)
      },
      {
        path: 'detalle-compra/:id',
        loadComponent: () => import('./pages/usuario/detalle-compra/detalle-compra.page').then(m => m.DetalleCompraPage)
      },
      {
        path: 'cambiar-password',
        loadComponent: () => import('./pages/usuario/cambiar-password/cambiar-password.page').then(m => m.CambiarPasswordPage)
      },
      {
        path: 'metodos-pago',
        loadComponent: () => import('./pages/usuario/metodos-pago/metodos-pago.page').then(m => m.MetodosPagoPage)
      },
      {
        path: 'agregar-tarjeta',
        loadComponent: () => import('./pages/usuario/agregar-tarjeta/agregar-tarjeta.page').then(m => m.AgregarTarjetaPage)
      }
    ],
    canActivate: [authGuard]
  },
  // Alias /usuario para compatibilidad
  {
    path: 'usuario',
    children: [
      {
        path: 'perfil',
        loadComponent: () => import('./pages/usuario/perfil/perfil.page').then(m => m.PerfilPage)
      },
      {
        path: 'editar-perfil',
        loadComponent: () => import('./pages/usuario/editar-perfil/editar-perfil.page').then(m => m.EditarPerfilPage)
      },
      {
        path: 'historial-compras',
        loadComponent: () => import('./pages/usuario/historial-compras/historial-compras.page').then(m => m.HistorialComprasPage)
      },
      {
        path: 'detalle-compra/:id',
        loadComponent: () => import('./pages/usuario/detalle-compra/detalle-compra.page').then(m => m.DetalleCompraPage)
      },
      {
        path: 'cambiar-password',
        loadComponent: () => import('./pages/usuario/cambiar-password/cambiar-password.page').then(m => m.CambiarPasswordPage)
      },
      {
        path: 'metodos-pago',
        loadComponent: () => import('./pages/usuario/metodos-pago/metodos-pago.page').then(m => m.MetodosPagoPage)
      },
      {
        path: 'agregar-tarjeta',
        loadComponent: () => import('./pages/usuario/agregar-tarjeta/agregar-tarjeta.page').then(m => m.AgregarTarjetaPage)
      }
    ],
    canActivate: [authGuard]
  },
  {
    path: 'home',
    loadComponent: () => import('./pages/home/home.page').then(m => m.HomePage),
    canActivate: [authGuard]
  },
  {
    path: '**',
    redirectTo: 'productos'
  }
];
