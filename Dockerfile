# Development Dockerfile for Webstudio
FROM node:20-alpine

# Install pnpm
RUN npm install -g pnpm@9.14.4

# Set working directory
WORKDIR /app

# Copy package files
COPY package.json pnpm-lock.yaml pnpm-workspace.yaml ./

# Install dependencies
RUN pnpm install

# Copy source code
COPY . .

# Expose port for development
EXPOSE 3001

# Start development server
CMD ["pnpm", "--filter", "@webstudio-is/builder", "dev"]
