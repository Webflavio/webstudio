FROM node:20-bookworm

# تثبيت الأدوات الضرورية
RUN apt-get update && apt-get install -y \
    git \
    curl \
    build-essential \
    postgresql-client \
    && rm -rf /var/lib/apt/lists/*

# إنشاء مستخدم غير root
RUN useradd -m -s /bin/bash node

# تفعيل corepack وتثبيت pnpm
RUN corepack enable && \
    corepack prepare pnpm@9.14.4 --activate

# تعيين مجلد العمل
WORKDIR /app

# نسخ ملفات package.json أولاً للاستفادة من cache
COPY package.json pnpm-lock.yaml* ./
COPY pnpm-workspace.yaml* ./

# تكوين pnpm
RUN pnpm config set store-dir /home/node/.pnpm-store

# تغيير ملكية المجلد
RUN chown -R node:node /app /home/node

# التبديل للمستخدم node
USER node

# تعريض المنفذ
EXPOSE 3000

# الأمر الافتراضي
CMD ["pnpm", "dev", "--host", "0.0.0.0"]
