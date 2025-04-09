MERN Project

This is a full-stack MERN application that includes a backend API and a frontend client. The project is organized as a monorepo (or with submodules) and uses Docker for containerized development and deployment.
Project Structure

.
├── backend            # Express/Node.js API server (MERN backend)
├── client             # Frontend application (React/Vite, etc.)
├── docker-compose.yaml  # Docker Compose configuration to run all services
└── start-all.sh         # Shell script to start all containers manually

    backend:
    Contains the Node.js/Express API code that serves the REST endpoints.

        It connects to a MongoDB database.

        The API listens on port 5000 (inside Docker, mapped to host port 5000).

        Environment variables (such as NODE_ENV and MONGO_URI) are injected at runtime.

    client:
    Contains the frontend code for the application (built using a tool such as Create React App, Vite, or similar).

        It serves static assets.

        The static server listens on port 3000 (inside Docker, mapped to host port 3000).

        API calls are configured to target the backend service.

    docker-compose.yaml:
    Defines three services:

        backend (mern-backend): Builds and runs the API.

        client (mern-client): Builds and serves the frontend.

        mongodb: Runs a MongoDB instance that the backend connects to.

    start-all.sh:
    A shell script that cleans up and starts all Docker containers manually (if not using Docker Compose).
    Ensure you have Docker installed and the Docker daemon is running.

Requirements

    Docker

    Docker Compose

    (Optional) Node.js and npm if you want to run the development environment outside of Docker.

Getting Started
Using Docker Compose

    Clone the Repository

git clone https://github.com/YourUsername/your-repo.git
cd your-repo

Initialize Submodules (if using submodules)
If your backend and client directories are set up as Git submodules, run:

git submodule update --init --recursive

Run Docker Compose

This command builds and starts all containers:

    docker compose up --build

        The backend is available at http://localhost:5000.

        The frontend is available at http://localhost:3000.

        MongoDB runs on port 27017.

Using the start-all.sh Script

    Clean Up Existing Containers (if necessary)

    Make sure there are no conflicting containers:

    ./start-all.sh

    This script will:

        Remove old containers named mongodb, mern-backend, and mern-client.

        Create a Docker network (if not already present).

        Start containers for MongoDB, backend, and frontend.

    Access the Application

        Backend API: http://localhost:5000

        Frontend App: http://localhost:3000

Environment Variables

Environment variables can be supplied via a .env file or directly in Docker Compose. For example, you could create a root-level .env file:

NODE_ENV=development
MONGO_URI=mongodb://mongodb:27017/emotweets

Then reference them in docker-compose.yaml:

services:
  backend:
    environment:
      - NODE_ENV=${NODE_ENV}
      - MONGO_URI=${MONGO_URI}

Development

    Backend:
    Navigate to the backend directory and run:

npm install
npm start   # (or use nodemon for development)

Client:
Navigate to the client directory and run:

    npm install
    npm run dev   # (or npm start depending on your setup)

Deployment

For production deployments, consider:

    Using a production-ready process manager (like PM2) for the backend.

    Optimizing the build of the client (ensure the Dockerfile builds a static bundle).

    Securing your environment variables.

    Setting NODE_ENV=production in your Docker Compose or host environment.

Troubleshooting

    Nested Repositories:
    If you see warnings about nested Git repositories in backend or client, decide if you want them to be submodules or part of a single monorepo.

        To convert to a monorepo, remove the .git folders from the nested directories.

        To keep them as submodules, follow Git's instructions to add them as submodules properly.

    Docker Issues:
    Ensure the Docker daemon is running. Use docker ps to verify containers are running. Check container logs with docker logs [container-name] for debugging.

License

MIT