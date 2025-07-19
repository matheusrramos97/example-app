#!/bin/bash

# Copiar .env se não existir
if [ ! -f ".env" ]; then
  cp .env.example .env
fi

# Gerar chave se ainda não foi feito
if ! grep -q "APP_KEY=base64" .env; then
  php artisan key:generate
fi

# Rodar migrations (ignorar erro se já estiverem feitas)
php artisan migrate --force || true

# Iniciar Octane com Swoole
exec "$@"