# Development Dockerfile for Webstudio
FROM node:20-alpine

# Install pnpm and wget for healthcheck
RUN npm install -g pnpm wget

# Set working directory
WORKDIR /app

# Copy all files at once to ensure patches are included
COPY . .

# Install dependencies
RUN pnpm install

# Expose port for development
EXPOSE 3001

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 \
  CMD wget --no-verbose --tries=1 --spider http://localhost:3000/health || exit 1

# Start development server
CMD ["pnpm", "--filter", "@webstudio-is/builder", "dev"]
