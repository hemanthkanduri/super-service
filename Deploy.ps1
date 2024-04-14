# Set variables
$dockerImageName = "superserviceimg"
$containerName = "superservicecontainer"
$portMapping = "8080:80"  # Map host port to container port

# Check if the container already exists, if so remove it
$existingContainer = docker ps -a --filter "name=$containerName" --format "{{.ID}}"
if ($existingContainer) {
    docker stop $containerName
    docker rm $containerName
}

# Run the container
docker run -d -p $portMapping --name $containerName $dockerImageName

# Check if the container is running
$containerState = docker inspect -f "{{.State.Running}}" $containerName

if ($containerState -eq "true") {
    Write-Host "Container $containerName is running."
} else {
    Write-Host "Failed to start container $containerName."
}
