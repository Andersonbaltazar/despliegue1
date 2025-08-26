#!/bin/sh

# Script de inicio para el contenedor Docker

# Crear directorios necesarios
mkdir -p /var/log/supervisor
mkdir -p /var/log/nginx
mkdir -p /run/nginx

# Configurar permisos de directorios Laravel
chmod -R 775 /var/www/html/storage
chmod -R 775 /var/www/html/bootstrap/cache

# Configurar permisos de base de datos SQLite si existe
if [ -f "/var/www/html/database/database.sqlite" ]; then
    chmod 664 /var/www/html/database/database.sqlite
fi

# Copiar archivo .env si no existe
if [ ! -f "/var/www/html/.env" ]; then
    cp /var/www/html/.env.example /var/www/html/.env
fi

# Generar clave de aplicación si no existe
php artisan key:generate --force

# Limpiar caché
php artisan config:clear
php artisan cache:clear
php artisan view:clear
php artisan route:clear

# Optimizar para producción
php artisan config:cache
php artisan route:cache
php artisan view:cache

# Ejecutar migraciones (opcional, descomenta si lo necesitas)
# php artisan migrate --force

# Iniciar supervisor que manejará nginx y php-fpm
exec /usr/bin/supervisord -c /etc/supervisor/conf.d/supervisord.conf
