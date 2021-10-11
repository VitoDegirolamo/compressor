# Create ECR repository
resource "aws_ecr_repository" "compressor" {
  name = "compressor"
}

resource "docker_registry_image" "compressor" {
  name = "${aws_ecr_repository.compressor.name}:latest"

  build {
      context = "."
      dockerfile = "Dockerfile"
  }
}
