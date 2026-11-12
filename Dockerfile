# ==============================================================================
# Codyssey E1-1 Developer Workstation Custom Web Server Dockerfile
# Base Image: Nginx Alpine (Lightweight & Secure)
# ==============================================================================
FROM nginx:alpine

# Metadata labels
LABEL org.opencontainers.image.title="codyssey-dev-workstation" \
      org.opencontainers.image.description="Custom developer workstation dashboard container" \
      org.opencontainers.image.version="1.0.0" \
      org.opencontainers.image.authors="csusuy <wp03160@naver.com>"

# Environment variables
ENV APP_ENV=production \
    APP_PORT=80 \
    WORKSTATION_USER=developer

# Copy static web server source code to standard Nginx document root
COPY src/ /usr/share/nginx/html/

# Expose web server default HTTP port
EXPOSE 80

# Healthcheck configuration to monitor container health
HEALTHCHECK --interval=30s --timeout=5s --start-period=5s --retries=3 \
  CMD wget --quiet --tries=1 --spider http://localhost:80/ || exit 1

# Start Nginx server in foreground mode
CMD ["nginx", "-g", "daemon off;"]
