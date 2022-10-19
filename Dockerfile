# The image is built on top of one that has node preinstalled
FROM node:16-alpine

# Create app directory
WORKDIR /app

# Copy all files into the container
COPY . .

# Install dependencies
RUN npm install

# Open appropriate port 
EXPOSE 3000

# Start the application
CMD [ "node", "./src/index.js" ]