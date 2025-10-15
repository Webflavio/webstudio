FROM node:20-bookworm

# تثبيت الأدوات الضرورية
RUN apt-get update && apt-get install -y \
    git \
    curl \
    build-essential \
    postgresql-client \
    && rm -rf /var/lib/apt/lists/*

# تفعيل corepack وتثبيت pnpm (كـ root)
RUN corepack enable && \
    corepack prepare pnpm@9.14.4 --activate

# تعيين مجلد العمل
WORKDIR /app

# نسخ ملفات package.json أولاً للاستفادة من cache
COPY --chown=node:node package.json pnpm-lock.yaml* ./
COPY --chown=node:node pnpm-workspace.yaml* ./

# تغيير ملكية المجلد
RUN chown -R node:node /app

# التبديل للمستخدم node
USER node

# تكوين pnpm
RUN pnpm config set store-dir /home/node/.pnpm-store

# تعريض المنفذ
EXPOSE 3002

# الأمر الافتراضي
CMD ["pnpm", "dev", "--host", "0.0.0.0"]
