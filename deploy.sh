#!/bin/bash

# Script de despliegue para Render
echo "🚀 Preparando despliegue para Render..."

# Verificar que estamos en el directorio correcto
if [ ! -f "Dockerfile" ]; then
    echo "❌ Error: No se encontró el Dockerfile. Asegúrate de estar en el directorio raíz del proyecto."
    exit 1
fi

# Verificar que existe el directorio laravel
if [ ! -d "laravel" ]; then
    echo "❌ Error: No se encontró el directorio 'laravel'."
    exit 1
fi

# Crear archivo .env si no existe
if [ ! -f "laravel/.env" ]; then
    echo "📝 Creando archivo .env desde .env.production..."
    cp laravel/.env.production laravel/.env
fi

# Verificar que existe la base de datos SQLite
if [ ! -f "laravel/database/database.sqlite" ]; then
    echo "📝 Creando archivo de base de datos SQLite..."
    touch laravel/database/database.sqlite
fi

# Agregar todos los archivos al git
echo "📦 Agregando archivos al repositorio..."
git add .

# Hacer commit
echo "💾 Haciendo commit de los cambios..."
git commit -m "Configure Laravel app for Render deployment with Docker

- Add Dockerfile for production deployment
- Add nginx configuration
- Add supervisor configuration for process management
- Add render.yaml for Render service configuration
- Configure SQLite database for simplicity
- Add docker-compose.yml for local development
- Add deployment scripts and documentation"

# Push al repositorio
echo "🚀 Subiendo cambios al repositorio..."
git push origin main

echo "✅ ¡Listo! Tu proyecto está preparado para desplegarse en Render."
echo ""
echo "📋 Próximos pasos:"
echo "1. Ve a https://render.com y crea una cuenta"
echo "2. Conecta tu repositorio de GitHub"
echo "3. Crea un nuevo 'Web Service'"
echo "4. Selecciona tu repositorio"
echo "5. Render detectará automáticamente la configuración"
echo ""
echo "🔗 Tu aplicación estará disponible en: https://tu-nombre-app.onrender.com"
