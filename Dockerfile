FROM node:20-alpine

# Install pnpm
RUN npm install -g pnpm

# Set working directory
WORKDIR /app

# Copy all files
COPY . .

# Install dependencies
RUN pnpm install

# Expose Vite port
EXPOSE 5173

# Run Vite on all network interfaces
CMD ["pnpm", "dev", "--host", "0.0.0.0"]
