# --- المرحلة 1: بناء المشروع ---
FROM node:20-bookworm AS build

WORKDIR /app
COPY . .
RUN corepack enable && pnpm install --frozen-lockfile
RUN pnpm --filter="@webstudio-is/builder" build

# --- المرحلة 2: تشغيل التطبيق ---
FROM node:20-bookworm

WORKDIR /app
COPY --from=build /app /app

ENV NODE_ENV=production
EXPOSE 5173

CMD ["pnpm", "--filter=@webstudio-is/builder", "start"]
