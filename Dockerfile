FROM node:18-alpine

WORKDIR /usr/src/app

# Copy package files first for caching
COPY package*.json ./

# Install dependencies
RUN npm install --only=production

# Copy app files
COPY . .

# Optional: remove if 'public' exists in repo
RUN mkdir -p public

# Non-root user
RUN addgroup -g 1001 -S nodejs && adduser -S nodejs -u 1001 \
    && chown -R nodejs:nodejs /usr/src/app
USER nodejs

# Expose port (informative)
EXPOSE 7000

# CMD
CMD ["node", "server.js"]
