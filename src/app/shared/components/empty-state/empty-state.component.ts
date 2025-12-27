import { Component, Input } from '@angular/core';
import { CommonModule } from '@angular/common';
import { IonicModule } from '@ionic/angular';

@Component({
  selector: 'app-empty-state',
  template: `
    <div class="empty-state">
      <ion-icon [name]="icono"></ion-icon>
      <h2>{{ titulo }}</h2>
      @if (mensaje) {
        <p>{{ mensaje }}</p>
      }
      <ng-content></ng-content>
    </div>
  `,
  styles: [`
    .empty-state {
      display: flex;
      flex-direction: column;
      align-items: center;
      justify-content: center;
      padding: 40px 20px;
      text-align: center;

      ion-icon {
        font-size: 80px;
        color: var(--ion-color-medium);
        margin-bottom: 20px;
      }

      h2 {
        color: var(--ion-color-dark);
        margin-bottom: 10px;
      }

      p {
        color: var(--ion-color-medium);
        margin-bottom: 20px;
      }
    }
  `],
  standalone: true,
  imports: [CommonModule, IonicModule]
})
export class EmptyStateComponent {
  @Input() icono: string = 'alert-circle-outline';
  @Input() titulo: string = 'No hay datos';
  @Input() mensaje: string = '';
}
