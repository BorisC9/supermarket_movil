import { Component, Input } from '@angular/core';
import { CommonModule } from '@angular/common';
import { IonicModule } from '@ionic/angular';

@Component({
  selector: 'app-loading-spinner',
  template: `
    <div class="spinner-container">
      <ion-spinner [name]="name"></ion-spinner>
      @if (mensaje) {
        <p>{{ mensaje }}</p>
      }
    </div>
  `,
  styles: [`
    .spinner-container {
      display: flex;
      flex-direction: column;
      align-items: center;
      justify-content: center;
      padding: 40px 20px;
      
      p {
        margin-top: 16px;
        color: var(--ion-color-medium);
      }
    }
  `],
  standalone: true,
  imports: [CommonModule, IonicModule]
})
export class LoadingSpinnerComponent {
  @Input() mensaje: string = '';
  @Input() name: string = 'crescent';
}
