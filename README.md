# Despliegue de Laravel en Render con Docker

Este proyecto está configurado para desplegarse en Render usando Docker.

## Archivos de configuración creados:

- `Dockerfile` - Configuración del contenedor Docker
- `docker-compose.yml` - Para desarrollo local
- `render.yaml` - Configuración del servicio en Render
- `nginx/default.conf` - Configuración del servidor web Nginx
- `supervisor/supervisord.conf` - Configuración del supervisor de procesos
- `docker/start.sh` - Script de inicio del contenedor
- `.dockerignore` - Archivos a ignorar en la imagen Docker

## Pasos para desplegar en Render:

### 1. Preparar el repositorio
```bash
git add .
git commit -m "Add Docker configuration for Render deployment"
git push origin main
```

### 2. Crear servicio en Render
1. Ve a [render.com](https://render.com) y crea una cuenta
2. Conecta tu repositorio de GitHub
3. Crea un nuevo "Web Service"
4. Selecciona tu repositorio
5. Render detectará automáticamente el `render.yaml` y configurará el servicio

### 3. Variables de entorno en Render
Render configurará automáticamente las variables de entorno desde el `render.yaml`, pero puedes agregar más si necesitas:

- `APP_NAME`: Nombre de tu aplicación
- `APP_URL`: URL de tu aplicación (ej: https://tu-app.onrender.com)
- Cualquier otra variable específica que necesites

### 4. Base de datos
El proyecto está configurado para usar SQLite por simplicidad en el plan gratuito de Render. Si necesitas MySQL:

1. Crea un servicio de base de datos PostgreSQL en Render
2. Actualiza las variables de entorno en el dashboard de Render
3. Modifica el `render.yaml` para usar PostgreSQL en lugar de SQLite

## Desarrollo local:

Para probar localmente con Docker:

```bash
# Construir y ejecutar
docker-compose up --build

# La aplicación estará disponible en http://localhost:8000
```

## Notas importantes:

1. **Plan gratuito**: Render suspende servicios gratuitos después de 15 minutos de inactividad
2. **Base de datos**: SQLite se reinicia en cada despliegue. Para datos persistentes, usa PostgreSQL
3. **Archivos**: Los archivos subidos se perderán en cada despliegue. Usa almacenamiento externo como AWS S3
4. **Variables de entorno**: Asegúrate de que `APP_KEY` esté configurado

## Solución de problemas:

1. **Error de permisos**: Verifica que los directorios `storage` y `bootstrap/cache` tengan los permisos correctos
2. **Error de base de datos**: Asegúrate de que el archivo `database.sqlite` exista y tenga permisos de escritura
3. **Error 500**: Revisa los logs en el dashboard de Render

## Comandos útiles:

```bash
# Ver logs en tiempo real
render logs follow

# Ejecutar comandos en el contenedor
render shell

# Reiniciar servicio
render restart
```
