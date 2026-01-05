FROM node:22.14.0-bookworm AS build
WORKDIR /app
COPY package*.json ./
RUN npm install --production
COPY . .

FROM node:22.14.0-slim
WORKDIR /app
COPY --from=build /app /app

# Set environment variable placeholder (will be replaced during build)
ENV ENVIRONMENT=BUILD_CMD

# Copy entrypoint script
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Expose port 3000
EXPOSE 3000

# Use entrypoint script
ENTRYPOINT ["/entrypoint.sh"]
