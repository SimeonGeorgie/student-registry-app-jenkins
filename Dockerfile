# Use the official Node.js 14 image as a parent image
FROM node:14

# Set the working directory inside the container to /app
WORKDIR /app

# Copy package.json and package-lock.json files into the container at /app
COPY package*.json ./

# Retry npm install up to 5 times with a delay
RUN set -eux; \
    for i in $(seq 1 5); do \
      npm install && break || \
      echo "Retrying npm install ($i/5)..." && \
      sleep 5; \
    done

# Copy the rest of your app's source code from your host to your image filesystem.
COPY . .

# Expose the port the app runs on
EXPOSE 3030

# Define the command to run your app using CMD which defines your runtime
CMD [ "npm", "start" ]
# minor change