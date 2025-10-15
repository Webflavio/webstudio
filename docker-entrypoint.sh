#!/bin/bash
set -e  # توقف عند أي خطأ

echo "Starting Webstudio development environment..."

# تنظيف npm و corepack caches
npm cache clean -f
rm -rf /tmp/corepack-cache
rm -rf /usr/local/lib/node_modules/corepack || true

# إعادة تثبيت corepack وتفعيله
npm install -g corepack@latest --force
corepack enable

echo "Corepack version: $(corepack --version)"

# تجهيز pnpm
corepack prepare pnpm@9.14.4 --activate

# الانتقال إلى مجلد المشروع
cd /app

# ضبط pnpm store directory
pnpm config set store-dir $HOME/.pnpm-store

# تثبيت الحزم، build، run migrations
pnpm install
pnpm build
pnpm migrations migrate

# تشغيل التطبيق مباشرة
pnpm dev --host 0.0.0.0
