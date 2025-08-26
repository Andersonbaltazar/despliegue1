# Script de despliegue para Render (PowerShell)
Write-Host "🚀 Preparando despliegue para Render..." -ForegroundColor Green

# Verificar que estamos en el directorio correcto
if (!(Test-Path "Dockerfile")) {
    Write-Host "❌ Error: No se encontró el Dockerfile. Asegúrate de estar en el directorio raíz del proyecto." -ForegroundColor Red
    exit 1
}

# Verificar que existe el directorio laravel
if (!(Test-Path "laravel")) {
    Write-Host "❌ Error: No se encontró el directorio 'laravel'." -ForegroundColor Red
    exit 1
}

# Crear archivo .env si no existe
if (!(Test-Path "laravel\.env")) {
    Write-Host "📝 Creando archivo .env desde .env.production..." -ForegroundColor Yellow
    Copy-Item "laravel\.env.production" "laravel\.env"
}

# Verificar que existe la base de datos SQLite
if (!(Test-Path "laravel\database\database.sqlite")) {
    Write-Host "📝 Creando archivo de base de datos SQLite..." -ForegroundColor Yellow
    New-Item -ItemType File -Path "laravel\database\database.sqlite" -Force | Out-Null
}

# Agregar todos los archivos al git
Write-Host "📦 Agregando archivos al repositorio..." -ForegroundColor Cyan
git add .

# Hacer commit
Write-Host "💾 Haciendo commit de los cambios..." -ForegroundColor Cyan
git commit -m "Configure Laravel app for Render deployment with Docker

- Add Dockerfile for production deployment
- Add nginx configuration
- Add supervisor configuration for process management
- Add render.yaml for Render service configuration
- Configure SQLite database for simplicity
- Add docker-compose.yml for local development
- Add deployment scripts and documentation"

# Push al repositorio
Write-Host "🚀 Subiendo cambios al repositorio..." -ForegroundColor Cyan
git push origin main

Write-Host "✅ ¡Listo! Tu proyecto está preparado para desplegarse en Render." -ForegroundColor Green
Write-Host ""
Write-Host "📋 Próximos pasos:" -ForegroundColor Blue
Write-Host "1. Ve a https://render.com y crea una cuenta" -ForegroundColor White
Write-Host "2. Conecta tu repositorio de GitHub" -ForegroundColor White
Write-Host "3. Crea un nuevo Web Service" -ForegroundColor White
Write-Host "4. Selecciona tu repositorio" -ForegroundColor White
Write-Host "5. Render detectará automáticamente la configuración" -ForegroundColor White
Write-Host ""
Write-Host "🔗 Tu aplicación estará disponible en: https://tu-nombre-app.onrender.com" -ForegroundColor Yellow
