#!/bin/bash
set -e  # توقف عند أي خطأ

echo "Starting Webstudio development environment..."

# الانتقال إلى مجلد المشروع
cd /app

# بناء المشروع كاملاً أولاً (يشمل جميع الحزم مثل http-client)
echo "Building the project..."
pnpm build

# الانتقال إلى مجلد apps/builder (حيث package.json الخاص بالـ builder)
cd apps/builder

# تشغيل التطبيق في وضع التطوير مع hot reload
echo "Starting dev server in apps/builder..."
exec pnpm dev --host 0.0.0.0
