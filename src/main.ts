import { bootstrapApplication } from '@angular/platform-browser';
import { RouteReuseStrategy, provideRouter, withPreloading, PreloadAllModules } from '@angular/router';
import { IonicRouteStrategy, provideIonicAngular } from '@ionic/angular/standalone';
import { provideHttpClient, withInterceptors } from '@angular/common/http';
import { addIcons } from 'ionicons';
import { 
  cartOutline, 
  logInOutline,
  logOutOutline,
  searchOutline, 
  trashOutline, 
  trash,
  addCircleOutline, 
  removeCircleOutline,
  checkmarkCircleOutline,
  closeCircleOutline,
  alertCircleOutline,
  checkmarkCircle,
  closeCircle,
  arrowForward,
  personOutline,
  briefcaseOutline,
  cashOutline,
  cardOutline,
  swapHorizontalOutline
} from 'ionicons/icons';

import { routes } from './app/app.routes';
import { AppComponent } from './app/app.component';
import { authInterceptor } from './app/core/interceptors/auth.interceptor';

// Registrar iconos de Ionicons
addIcons({
  'cart-outline': cartOutline,
  'log-in-outline': logInOutline,
  'log-out-outline': logOutOutline,
  'search-outline': searchOutline,
  'trash-outline': trashOutline,
  'trash': trash,
  'add-circle-outline': addCircleOutline,
  'remove-circle-outline': removeCircleOutline,
  'checkmark-circle-outline': checkmarkCircleOutline,
  'close-circle-outline': closeCircleOutline,
  'alert-circle-outline': alertCircleOutline,
  'checkmark-circle': checkmarkCircle,
  'close-circle': closeCircle,
  'arrow-forward': arrowForward,
  'person-outline': personOutline,
  'briefcase-outline': briefcaseOutline,
  'cash-outline': cashOutline,
  'card-outline': cardOutline,
  'swap-horizontal-outline': swapHorizontalOutline
});

bootstrapApplication(AppComponent, {
  providers: [
    { provide: RouteReuseStrategy, useClass: IonicRouteStrategy },
    provideIonicAngular(),
    provideRouter(routes, withPreloading(PreloadAllModules)),
    provideHttpClient(withInterceptors([authInterceptor])),
  ],
});
