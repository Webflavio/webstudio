# Build stage
FROM node:20-alpine AS builder

# Install pnpm
RUN npm install -g pnpm@9.14.4

# Set working directory
WORKDIR /app

# Copy package files first (for better caching)
COPY package.json pnpm-lock.yaml pnpm-workspace.yaml ./

# Copy patches directory
COPY patches ./patches

# Copy all package.json files for workspace packages
COPY apps/builder/package.json ./apps/builder/
COPY packages/*/package.json ./packages/*/

# Install dependencies (this will now find the patches)
RUN pnpm install --frozen-lockfile

# Copy source code
COPY . .

# Build the application
RUN pnpm build

# Production stage
FROM node:20-alpine AS production

# Install pnpm
RUN npm install -g pnpm@9.14.4

# Set working directory
WORKDIR /app

# Copy built application and dependencies
COPY --from=builder /app/apps/builder/build ./build
COPY --from=builder /app/apps/builder/public ./public
COPY --from=builder /app/node_modules ./node_modules
COPY --from=builder /app/package.json ./package.json
COPY --from=builder /app/apps/builder/package.json ./apps/builder/package.json
COPY --from=builder /app/pnpm-lock.yaml ./pnpm-lock.yaml
COPY --from=builder /app/pnpm-workspace.yaml ./pnpm-workspace.yaml

# Create non-root user
RUN addgroup -g 1001 -S nodejs
RUN adduser -S webstudio -u 1001

# Change ownership
RUN chown -R webstudio:nodejs /app
USER webstudio

# Expose port
EXPOSE 8097

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 \
  CMD node -e "require('http').get('http://localhost:8080/health', (res) => { process.exit(res.statusCode === 200 ? 0 : 1) }).on('error', () => process.exit(1))"

# Start the application
CMD ["pnpm", "--filter", "@webstudio-is/builder", "start"]
