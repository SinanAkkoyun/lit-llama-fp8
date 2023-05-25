#!/bin/bash

# Start the service in detached mode
docker compose up -d

# Get the name of the service from docker-compose.yml
service_name=$(grep 'services:' -A 1 docker-compose.yml | tail -n1 | cut -d':' -f1 | tr -d ' ')

# Wait a moment for the container to fully start
sleep 5

# Get the ID of the container for the service
container_id=$(docker ps -qf "name=$service_name")

echo "Container ID: $container_id"

# Check if the container ID was found
if [[ -z "$container_id" ]]; then
    echo "Container ID not found. Is the container running?"
    exit 1
fi

# Enter the container
docker exec -it $container_id /bin/bash
