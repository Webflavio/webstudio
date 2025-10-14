FROM mcr.microsoft.com/devcontainers/javascript-node:1-20-bookworm

ENV PATH=/usr/local/bin:${PATH}

# تثبيت pnpm
RUN npm install -g pnpm@9.0.2

# تفعيل BuildKit (تسريع البناء)
ENV DOCKER_BUILDKIT=1

# تحديث النظام وحزم أساسية (اختياري)
RUN apt-get update && apt-get install -y git curl

# العمل كمستخدم node الافتراضي
USER node

WORKDIR /workspaces/webstudio

# تثبيت التبعيات
COPY package.json pnpm-lock.yaml* ./
RUN pnpm install --frozen-lockfile

# نسخ باقي المشروع
COPY . .

EXPOSE 5173

# أمر التشغيل في بيئة التطوير
CMD ["pnpm", "dev", "--host", "0.0.0.0", "--port", "5173"]
