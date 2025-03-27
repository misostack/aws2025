# Use Node.js LTS version as the base image
FROM node:22-alpine

# Set working directory
WORKDIR /app

# Copy package files
COPY package*.json ./

# Install dependencies
RUN npm ci --only=production

# Copy application code
COPY . .

# Expose the port your app runs on
EXPOSE 1337

# Set NODE_ENV
ENV NODE_ENV=production

# Start the application
CMD ["npm", "start"]