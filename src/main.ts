import { bootstrapApplication } from '@angular/platform-browser';
import { AppComponent } from './app/app.component';
import { provideHttpClient } from '@angular/common/http';
import { provideRouter } from '@angular/router';
import { routes } from './app/app.routes';
import { importProvidersFrom } from '@angular/core';
import { BrowserAnimationsModule } from '@angular/platform-browser/animations';
import { MatSnackBarModule } from '@angular/material/snack-bar';

/**
 * Punto de entrada de la aplicación Angular para visualización de resultados SQL.
 * Este módulo configura la aplicación con los providers necesarios para:
 * - HTTP Client (para consumir resultados de consultas SQL)
 * - Router (para navegación entre vistas)
 * - Animaciones (para mejor experiencia de usuario)
 * - Notificaciones (para mostrar resultados de operaciones)
 */
bootstrapApplication(AppComponent, {
  providers: [
    provideHttpClient(),
    provideRouter(routes),
    importProvidersFrom(
      BrowserAnimationsModule,
      MatSnackBarModule
    )
  ]
}).catch(err => {
  console.error('Error al iniciar la aplicación:', err);
  // Manejo de errores al inicio de la aplicación
  const errorContainer = document.createElement('div');
  errorContainer.style.padding = '20px';
  errorContainer.style.backgroundColor = '#ffebee';
  errorContainer.style.color = '#c62828';
  errorContainer.style.border = '1px solid #ef9a9a';
  errorContainer.style.borderRadius = '4px';
  errorContainer.style.margin = '20px';
  errorContainer.style.fontFamily = 'Arial, sans-serif';
  errorContainer.innerHTML = `
    <h2>Error al iniciar la aplicación</h2>
    <p>No se pudo cargar la aplicación de gestión de préstamos.</p>
    <p>Detalles técnicos:</p>
    <pre>${err.message || err}</pre>
    <p>Verifique que:</p>
    <ul>
      <li>PostgreSQL 16.3 esté instalado y ejecutándose</li>
      <li>Los scripts SQL se hayan ejecutado correctamente</li>
      <li>No haya errores en la configuración de la base de datos</li>
    </ul>
  `;
  document.body.appendChild(errorContainer);
});