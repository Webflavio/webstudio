FROM node:20-bookworm

# تثبيت su-exec للتبديل الآمن بين المستخدمين
RUN apt-get update && apt-get install -y \
    git \
    curl \
    build-essential \
    postgresql-client \
    su-exec \
    && rm -rf /var/lib/apt/lists/*

# تفعيل corepack وتثبيت pnpm (كـ root)
RUN corepack enable && \
    corepack prepare pnpm@9.14.4 --activate

# إنشاء وتجهيز المجلدات اللازمة
RUN mkdir -p /home/node/.pnpm-store /home/node/.cache /workspace && \
    chown -R node:node /home/node /workspace

# تعيين مجلد العمل
WORKDIR /workspace

# تعريض المنفذ
EXPOSE 3002

# سيتم تعريف ENTRYPOINT و CMD في docker-compose
