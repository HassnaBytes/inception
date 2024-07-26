# Inception Project

## Project Overview
Inception is an advanced system administration project focused on using Docker to set up a small infrastructure composed of different services. The entire project is implemented within a virtual machine, utilizing Docker Compose to manage the services. This project deepens understanding of system administration concepts, particularly in containerized environments.

## Key Concepts

### 1. Docker and Containerization
Docker is a platform for developing, shipping, and running applications in containers. Containers are lightweight, standalone, and executable packages that include everything needed to run a piece of software, including the code, runtime, system tools, libraries, and settings.

Key benefits of Docker:
- Consistency across development, testing, and production environments
- Lightweight and fast compared to traditional virtual machines
- Improved resource utilization
- Easy scaling and deployment

Unlike virtual machines, containers share the host system's OS kernel, making them more efficient and faster to start.

### 2. Docker Compose
Docker Compose is a tool for defining and running multi-container Docker applications. It uses YAML files to configure the application's services and allows you to create and start all the services from your configuration with a single command.

The `docker-compose.yml` file in this project defines:
- Services (NGINX, WordPress, MariaDB)
- Networks
- Volumes
- Environment variables

### 3. Services Implemented

#### NGINX with TLS
- Serves as the entry point for the infrastructure
- Configured with TLS v1.2 or v1.3 for secure communication
- Listens on port 443

#### WordPress + php-fpm
- WordPress application files
- PHP-FPM (FastCGI Process Manager) for processing PHP requests

#### MariaDB
- Database server for WordPress
- Stores WordPress data and user information

#### Volumes
- WordPress database volume: Persists the MariaDB data
- WordPress files volume: Stores WordPress core files, themes, plugins, and uploads

#### Docker Network
- Creates a bridge network for communication between containers

### 4. Security Considerations
- Environment variables: Used to store sensitive information like database credentials
- TLS implementation: Ensures encrypted communication between clients and the server
- Password handling: Avoids hardcoding passwords in Dockerfiles or exposing them in the repository
- Docker secrets: Recommended for storing confidential information (not implemented in the mandatory part)

### 5. Networking
- Custom domain configuration: The project uses a domain in the format `login.42.fr`, where `login` is your username
- NGINX as the single point of entry: All traffic is routed through NGINX on port 443

### 6. Dockerfile Best Practices
- Base images: Using the penultimate stable version of Alpine or Debian
- Avoiding "hacky patches": No use of infinite loops or tail -f for keeping containers running
- Proper use of daemons: Understanding and implementing correct process management within containers
- PID 1: Ensuring the main process in the container is correctly handled

### 7. Volume Management
Docker volumes are used for persisting data and sharing it between the host and containers. In this project:
- MariaDB data is stored in a volume to persist the database across container restarts
- WordPress files are stored in a volume for easy management and persistence

Volumes are located in `/home/login/data` on the host machine.

### 8. Project Structure
.
├── Makefile
├── secrets/
│   ├── credentials.txt
│   ├── db_password.txt
│   └── db_root_password.txt
└── srcs/
├── docker-compose.yml
├── .env
└── requirements/
├── mariadb/
│   ├── conf/
│   ├── Dockerfile
│   └── tools/
├── nginx/
│   ├── conf/
│   ├── Dockerfile
│   └── tools/
└── wordpress/
├── conf/
├── Dockerfile
└── tools/

## Setup and Usage
1. Clone the repository
2. Navigate to the project directory
3. Run `make` to build and start the containers
4. Access the WordPress site at https://login.42.fr

Makefile commands:
- `make`: Build and start the containers
- `make clean`: Stop and remove containers, networks, and volumes
- `make fclean`: Perform clean and remove all built Docker images

## Challenges and Learning Outcomes
- Understanding the intricacies of Docker networking and inter-container communication
- Implementing secure TLS configuration in NGINX
- Managing sensitive information securely using environment variables
- Debugging issues related to container connectivity and volume permissions

Key learnings:
- Docker container orchestration with Docker Compose
- Proper separation of concerns in a multi-service architecture
- Importance of security in containerized environments
- Best practices for Dockerfile creation and image building

## Additional Resources
- [Docker Documentation](https://docs.docker.com/)
- [Docker Compose Documentation](https://docs.docker.com/compose/)
- [NGINX Documentation](https://nginx.org/en/docs/)
- [WordPress Docs](https://wordpress.org/support/)
- [MariaDB Documentation](https://mariadb.com/kb/en/documentation/)![docker_](https://github.com/user-attachments/assets/2ed7ddfe-aaf8-4277-939f-43bd33770d28)
