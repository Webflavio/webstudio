FROM node:20-alpine

# تثبيت pnpm
RUN npm install -g pnpm

WORKDIR /workspace

# نسخ ملفات المشروع
COPY package.json pnpm-lock.yaml ./
COPY . .

# تثبيت المكتبات
RUN pnpm install

EXPOSE 3000 5173

CMD ["pnpm", "dev"]
