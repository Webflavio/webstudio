#!/bin/sh
set -e  # توقف عند أي خطأ

echo "Starting Webstudio development environment..."

# إنشاء مجلدات pnpm و cache مع صلاحيات node
mkdir -p /home/node/.pnpm-store /home/node/.cache
chown -R node:node /home/node/.pnpm-store /home/node/.cache

# حذف جميع node_modules إذا وجدت
find /app -type d -name node_modules -exec sh -c 'rm -rf "$1"' _ {} \;

# إنشاء node_modules لكل package
find /app -type d -exec sh -c 'mkdir -p "$1/node_modules"' _ {} \;

# ضبط صلاحيات مجلد التطبيق
chown -R node:node /app

# إعداد pnpm store
su node -c 'pnpm config set store-dir /home/node/.pnpm-store'

# تثبيت الحزم
su node -c 'pnpm install'

# بناء المشروع
su node -c 'pnpm build'

# تشغيل migrations
su node -c 'pnpm migrations migrate'

# تشغيل التطبيق
su node -c 'pnpm dev --host 0.0.0.0'
