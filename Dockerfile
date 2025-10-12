FROM node:18-alpine

# Install pnpm
RUN npm install -g pnpm

# Set working directory
WORKDIR /app

# Copy source
COPY . .

# Install dependencies
RUN pnpm install

# Expose port used by vite
EXPOSE 5173

# Run development server
CMD ["pnpm", "dev"]
