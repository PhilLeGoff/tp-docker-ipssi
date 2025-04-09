#!/bin/bash
# stop on any error
set -e

# Create the network if it doesn't exist
if ! docker network ls | grep -q "mern-network"; then
  echo "Creating docker network 'mern-network'..."
  docker network create mern-network
fi

# Remove any pre-existing containers to avoid name conflicts
for container in mongodb api front; do
  if docker ps -a --format '{{.Names}}' | grep -q "^${container}\$"; then
    echo "Removing existing container: ${container}"
    docker rm -f "${container}"
  fi
done

# Run the MongoDB container with a volume for persistent storage
echo "Starting MongoDB container..."
docker run -d \
  --name mongodb \
  --network mern-network \
  -p 27017:27017 \
  -v mongo-data:/data/db \
  -e MONGO_INITDB_DATABASE=emotweets \
  mongo:6.0

# Run the API (backend) container
# Ensure your API code connects to the database using the container name "mongodb"
echo "Starting API container..."
docker run -d \
  --name api \
  --network mern-network \
  -p 5000:5000 \
  -e NODE_ENV=production \
  -e MONGO_URI=mongodb://mongodb:27017/emotweets \
  my-api-image

# Run the Frontend container
# Make sure your front-end code targets the API at http://api:5000 if needed.
echo "Starting Frontend container..."
docker run -d \
  --name front \
  --network mern-network \
  -p 3000:3000 \
  my-front-image

echo "All containers are up and running on network 'mern-network'."

