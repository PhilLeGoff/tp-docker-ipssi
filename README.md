# MERN Project

This repository is a MERN (MongoDB, Express, React, Node.js) project that uses Git submodules for the backend and client, along with Docker Compose for container orchestration.

## Project Structure
```bash
  ├── backend/ # Git submodule for the backend API 
  ├── client/ # Git submodule for the frontend 
  └──  docker-compose.yaml # Docker Compose file to run all services 
```

## Setup

### 1. Clone the Repository and Initialize Submodules

Clone the repository and then initialize the submodules:

```bash
git clone <https://github.com/PhilLeGoff/tp-docker-ipssi.git>
cd <tp-docker-ipssi>
git submodule update --init --recursive
```

### 2. Run with Docker Compose

Build and start all services using Docker Compose:

```bash
docker compose up --build
```

This will start:

    Backend: Accessible at http://localhost:5000

    Frontend: Accessible at http://localhost:3000

    MongoDB: Running on port 27017

### 3. Update Submodules (When Needed)

To update the submodules to their latest remote commits:

```bash
git submodule update --remote --merge
```


