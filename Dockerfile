FROM node:20-alpine

RUN npm install -g pnpm
WORKDIR /app
COPY . .
RUN pnpm install
EXPOSE 5173
CMD ["pnpm", "dev", "--host"]
