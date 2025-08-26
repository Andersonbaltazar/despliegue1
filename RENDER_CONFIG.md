# Configuración para Render

## Configuración del Servicio Web

### 📁 **Directorio raíz**
- **¿Es necesario?**: No, es opcional
- **Configuración actual**: No establecido (usa la raíz del repositorio)
- **Motivo**: Como usamos Docker, el Dockerfile maneja la estructura del proyecto correctamente
- **Estructura del proyecto**: 
  ```
  /
  ├── Dockerfile (en la raíz)
  ├── laravel/ (código de Laravel)
  └── otros archivos de configuración
  ```

### 🔨 **Comando de compilación**
- **Configuración actual**: `""` (vacío)
- **Motivo**: Docker maneja toda la compilación a través del Dockerfile
- **Proceso en Docker**:
  1. Instala dependencias PHP con Composer
  2. Optimiza autoloader
  3. Configura permisos
  4. Prepara el entorno de producción

### 🚀 **Comando de inicio**
- **Configuración actual**: `""` (vacío)
- **Motivo**: Docker usa el `CMD` del Dockerfile que ejecuta el script `/start.sh`
- **Proceso de inicio**:
  1. Configura directorios necesarios
  2. Copia archivo .env
  3. Genera APP_KEY
  4. Limpia y optimiza caché
  5. Inicia Nginx y PHP-FPM con Supervisor

## 🔐 Variables de Entorno Configuradas

### Variables principales:
- `APP_ENV`: production
- `APP_DEBUG`: false
- `APP_KEY`: Se genera automáticamente
- `APP_NAME`: Laravel App
- `APP_URL`: Se sincroniza con la URL de Render

### Base de datos:
- `DB_CONNECTION`: sqlite
- `DB_DATABASE`: /var/www/html/database/database.sqlite

### Configuración de aplicación:
- `LOG_CHANNEL`: single
- `LOG_LEVEL`: error
- `SESSION_DRIVER`: file
- `SESSION_LIFETIME`: 120
- `CACHE_DRIVER`: file
- `QUEUE_CONNECTION`: sync
- `BROADCAST_DRIVER`: log
- `FILESYSTEM_DISK`: local
- `MAIL_MAILER`: log

## 📋 Variables adicionales que puedes configurar en Render

Si necesitas configurar más variables, puedes agregarlas en el dashboard de Render:

### Para email (si usas servicios de email):
```
MAIL_HOST=smtp.mailtrap.io
MAIL_PORT=2525
MAIL_USERNAME=tu_usuario
MAIL_PASSWORD=tu_password
MAIL_ENCRYPTION=tls
MAIL_FROM_ADDRESS=noreply@tuapp.com
MAIL_FROM_NAME="Tu App"
```

### Para servicios externos:
```
AWS_ACCESS_KEY_ID=tu_key
AWS_SECRET_ACCESS_KEY=tu_secret
AWS_DEFAULT_REGION=us-east-1
AWS_BUCKET=tu_bucket
```

### Para autenticación social:
```
GOOGLE_CLIENT_ID=tu_client_id
GOOGLE_CLIENT_SECRET=tu_secret
FACEBOOK_CLIENT_ID=tu_client_id
FACEBOOK_CLIENT_SECRET=tu_secret
```

## 🔄 Actualizar configuración

Para actualizar la configuración:

1. **Modificar render.yaml** (para cambios estructurales)
2. **Usar dashboard de Render** (para variables de entorno)
3. **Hacer push al repositorio** (para cambios en código)

## ✅ Verificación de configuración

Tu configuración actual es correcta para:
- ✅ Plan gratuito de Render
- ✅ Aplicación Laravel básica
- ✅ Base de datos SQLite
- ✅ Entorno de producción optimizado
- ✅ Escalabilidad básica
