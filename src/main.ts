import { bootstrapApplication } from '@angular/platform-browser';
import { RouteReuseStrategy, provideRouter, withPreloading, PreloadAllModules } from '@angular/router';
import { IonicRouteStrategy, provideIonicAngular } from '@ionic/angular/standalone';
import { provideHttpClient, withInterceptors } from '@angular/common/http';
import { addIcons } from 'ionicons';
import {
  // Cart & Shopping
  cartOutline,
  cart,
  storefrontOutline,
  storefront,
  receiptOutline,
  walletOutline,
  pricetagOutline,

  // Auth & User
  logInOutline,
  logOutOutline,
  personOutline,
  person,
  personCircleOutline,
  personAddOutline,
  lockClosedOutline,
  keyOutline,
  shieldCheckmark,

  // Actions
  searchOutline,
  trashOutline,
  trash,
  add,
  remove,
  addCircleOutline,
  removeCircleOutline,
  saveOutline,

  // Status & Feedback
  checkmarkCircleOutline,
  closeCircleOutline,
  alertCircleOutline,
  checkmarkCircle,
  closeCircle,
  checkmark,

  // Navigation
  arrowForward,
  arrowBack,
  arrowBackOutline,
  arrowUpOutline,
  arrowDownOutline,
  chevronForward,
  closeOutline,
  close,
  gridOutline,

  // Misc
  refreshOutline,
  briefcaseOutline,
  cashOutline,
  cardOutline,
  swapHorizontalOutline,
  barcodeOutline,
  cubeOutline,
  locationOutline,
  eyeOutline,
  eyeOffOutline
} from 'ionicons/icons';

import { routes } from './app/app.routes';
import { AppComponent } from './app/app.component';
import { authInterceptor } from './app/core/interceptors/auth.interceptor';

// Registrar iconos de Ionicons
addIcons({
  // Cart & Shopping
  'cart-outline': cartOutline,
  'cart': cart,
  'storefront-outline': storefrontOutline,
  'storefront': storefront,
  'receipt-outline': receiptOutline,
  'wallet-outline': walletOutline,
  'pricetag-outline': pricetagOutline,

  // Auth & User
  'log-in-outline': logInOutline,
  'log-out-outline': logOutOutline,
  'person-outline': personOutline,
  'person': person,
  'person-circle-outline': personCircleOutline,
  'person-add-outline': personAddOutline,
  'lock-closed-outline': lockClosedOutline,
  'key-outline': keyOutline,
  'shield-checkmark': shieldCheckmark,

  // Actions
  'search-outline': searchOutline,
  'trash-outline': trashOutline,
  'trash': trash,
  'add': add,
  'remove': remove,
  'add-circle-outline': addCircleOutline,
  'remove-circle-outline': removeCircleOutline,
  'save-outline': saveOutline,

  // Status & Feedback
  'checkmark-circle-outline': checkmarkCircleOutline,
  'close-circle-outline': closeCircleOutline,
  'alert-circle-outline': alertCircleOutline,
  'checkmark-circle': checkmarkCircle,
  'close-circle': closeCircle,
  'checkmark': checkmark,

  // Navigation
  'arrow-forward': arrowForward,
  'arrow-back': arrowBack,
  'arrow-back-outline': arrowBackOutline,
  'arrow-up-outline': arrowUpOutline,
  'arrow-down-outline': arrowDownOutline,
  'chevron-forward': chevronForward,
  'close-outline': closeOutline,
  'close': close,
  'grid-outline': gridOutline,

  // Misc
  'refresh-outline': refreshOutline,
  'briefcase-outline': briefcaseOutline,
  'cash-outline': cashOutline,
  'card-outline': cardOutline,
  'swap-horizontal-outline': swapHorizontalOutline,
  'barcode-outline': barcodeOutline,
  'cube-outline': cubeOutline,
  'location-outline': locationOutline,
  'eye-outline': eyeOutline,
  'eye-off-outline': eyeOffOutline
});

bootstrapApplication(AppComponent, {
  providers: [
    { provide: RouteReuseStrategy, useClass: IonicRouteStrategy },
    provideIonicAngular(),
    provideRouter(routes, withPreloading(PreloadAllModules)),
    provideHttpClient(withInterceptors([authInterceptor])),
  ],
});
