FROM node:20

WORKDIR /app

# نسخ ملفات المشروع
COPY . .

# تثبيت pnpm
RUN npm install -g corepack && corepack enable
RUN pnpm install --frozen-lockfile

# متغيرات البيئة
ENV DEV_LOGIN=true
ENV AUTH_SECRET=some-random-secret
ENV HOST=0.0.0.0
ENV PORT=5173

# أمر التشغيل
CMD ["pnpm", "dev"]
