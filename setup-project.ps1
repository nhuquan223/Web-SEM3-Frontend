Write-Host "🚀 Setting up optimized React project structure..." -ForegroundColor Green

# Function to create directory if not exists
function New-DirectoryIfNotExists {
    param([string]$Path)
    if (!(Test-Path $Path)) {
        New-Item -Path $Path -ItemType Directory -Force | Out-Null
        Write-Host "✅ Created: $Path" -ForegroundColor Blue
    }
}

# Function to create file if not exists
function New-FileIfNotExists {
    param([string]$Path)
    if (!(Test-Path $Path)) {
        New-Item -Path $Path -ItemType File -Force | Out-Null
        Write-Host "✅ Created: $Path" -ForegroundColor Yellow
    }
}

Write-Host "📁 Creating directory structure..." -ForegroundColor Cyan

# Create all directories
$directories = @(
    "src/components/ui/Button",
    "src/components/ui/Input", 
    "src/components/ui/Modal",
    "src/components/ui/Card",
    "src/components/ui/LoadingSpinner",
    "src/components/layout/Header",
    "src/components/layout/Footer",
    "src/components/layout/Sidebar", 
    "src/components/layout/Layout",
    "src/components/common",
    "src/pages/Home",
    "src/pages/Dashboard",
    "src/pages/Profile",
    "src/pages/Auth", 
    "src/pages/NotFound",
    "src/hooks",
    "src/context",
    "src/services",
    "src/utils",
    "src/styles/components",
    "src/assets/images",
    "src/assets/icons",
    "src/assets/fonts",
    "src/router",
    "src/store/slices",
    "src/store/middleware"
)

foreach ($dir in $directories) {
    New-DirectoryIfNotExists $dir
}

Write-Host "📦 Moving existing files..." -ForegroundColor Cyan
if (Test-Path "src/logo.svg") {
    Move-Item -Path "src/logo.svg" -Destination "src/assets/images/" -Force
    Write-Host "✅ Moved logo.svg to assets/images/" -ForegroundColor Blue
}

Write-Host "📚 Installing dependencies..." -ForegroundColor Cyan
npm install react-router-dom axios react-hook-form yup @hookform/resolvers @reduxjs/toolkit react-redux

Write-Host "⚙️ Creating configuration files..." -ForegroundColor Cyan

# Create .env.example
Set-Content -Path ".env.example" -Value @"
REACT_APP_API_URL=http://localhost:3001/api
REACT_APP_APP_NAME=TeamApp
REACT_APP_VERSION=1.0.0
"@

# Create jsconfig.json
Set-Content -Path "jsconfig.json" -Value @"
{
  "compilerOptions": {
    "baseUrl": "src",
    "paths": {
      "@/*": ["*"],
      "@/components/*": ["components/*"],
      "@/pages/*": ["pages/*"],
      "@/hooks/*": ["hooks/*"],
      "@/services/*": ["services/*"],
      "@/utils/*": ["utils/*"],
      "@/context/*": ["context/*"],
      "@/styles/*": ["styles/*"],
      "@/assets/*": ["assets/*"]
    }
  },
  "include": ["src/**/*"]
}
"@

# Create .prettierrc
Set-Content -Path ".prettierrc" -Value @"
{
  "semi": true,
  "trailingComma": "es5",
  "singleQuote": true,
  "printWidth": 80,
  "tabWidth": 2
}
"@

Write-Host "✅ Project structure optimization completed!" -ForegroundColor Green
Write-Host "📖 Next steps:" -ForegroundColor Yellow
Write-Host "1. Copy .env.example to .env and update values" -ForegroundColor White
Write-Host "2. Start migrating your existing components" -ForegroundColor White
Write-Host "3. Run 'npm start' to test the setup" -ForegroundColor White
