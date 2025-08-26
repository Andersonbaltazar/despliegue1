# Dockerfile para Laravel en producción
FROM php:8.2-fpm-alpine

# Variables de entorno
ENV COMPOSER_ALLOW_SUPERUSER=1

# Instalar dependencias del sistema paso a paso
RUN apk update --no-cache && apk add --no-cache \
    nginx \
    supervisor

RUN apk add --no-cache \
    curl \
    zip \
    unzip \
    git \
    sqlite

# Instalar dependencias de desarrollo para PHP
RUN apk add --no-cache \
    libpng-dev \
    oniguruma-dev \
    libxml2-dev \
    sqlite-dev

# Limpiar caché
RUN rm -rf /var/cache/apk/*

# Instalar extensiones PHP una por una
RUN docker-php-ext-install pdo_sqlite
RUN docker-php-ext-install mbstring
RUN docker-php-ext-install exif
RUN docker-php-ext-install pcntl
RUN docker-php-ext-install bcmath
RUN docker-php-ext-install gd

# Instalar Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Configurar directorio de trabajo
WORKDIR /var/www/html

# Copiar archivos del proyecto
COPY laravel/ .

# Instalar dependencias de PHP
RUN composer install --no-dev --optimize-autoloader --no-scripts

# El archivo .env se creará en el script de inicio, no lo copiamos aquí

# Configurar permisos básicos (los permisos específicos se configuran en el script de inicio)
RUN chown -R www-data:www-data /var/www/html \
    && chmod -R 755 /var/www/html

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
