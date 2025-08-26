# Dockerfile para Laravel en producción
FROM php:8.2-fpm-alpine

# Instalar dependencias del sistema
RUN apk add --no-cache \
    nginx \
    supervisor \
    curl \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    zip \
    unzip \
    git \
    sqlite \
    && docker-php-ext-install pdo_sqlite pdo_mysql mbstring exif pcntl bcmath gd

# Instalar Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Configurar directorio de trabajo
WORKDIR /var/www/html

# Copiar archivos del proyecto
COPY laravel/ .

# Instalar dependencias de PHP
RUN composer install --no-dev --optimize-autoloader --no-scripts

# Copiar archivo de entorno de producción
COPY laravel/.env.production .env

# Configurar permisos
RUN chown -R www-data:www-data /var/www/html \
    && chmod -R 755 /var/www/html \
    && chmod -R 775 /var/www/html/storage \
    && chmod -R 775 /var/www/html/bootstrap/cache \
    && chmod 664 /var/www/html/database/database.sqlite

# Configurar Nginx
COPY nginx/default.conf /etc/nginx/nginx.conf

# Configurar Supervisor
COPY supervisor/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Crear script de inicio
COPY docker/start.sh /start.sh
RUN chmod +x /start.sh

# Exponer puerto
EXPOSE 80

# Comando de inicio
CMD ["/start.sh"]
