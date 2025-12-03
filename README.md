# Local WordPress (Bedrock) Dev Environment

This repository contains a **local development setup** for a WordPress site using:

- [Roots Bedrock](https://roots.io/bedrock/) (modern WordPress stack)
- **PHP-FPM + Nginx** (single container)
- **MySQL** (separate container via Docker Compose)
- **Composer & PHP inside Docker** (no PHP required on host)
- Simple **Makefile** commands to manage the app container

You can use this repo as a template for starting similar Bedrock-based projects.

---

## 1. Architecture Overview

### Components

- **MySQL container**
  - Started via `docker-compose.yml`
  - Accessible on Docker network as `kummaatty-mysql`
  - DB name/user/password configurable in `.env`

- **App container **
  - Built from `Dockerfile` using `richarvey/nginx-php-fpm` base image
  - Runs **nginx** + **php-fpm** (supervisor)
  - Serves Bedrock from `/var/www/html/web`
  - Composer is installed inside the image

- **Code (this repo)**
  - Mounted into container at `/var/www/html`
  - WordPress/Bedrock lives in the `web/` directory
  - Bedrock config in `config/`
  - Nginx virtual host in `conf/nginx/nginx-site.conf`

### Key Directories

- `web/`  
  Bedrock webroot (contains `index.php`, `wp/`, etc.)

- `config/`  
  Bedrock configuration (environments, application config).

- `conf/nginx/nginx-site.conf`  
  Custom Nginx server configuration pointing to `web/` as document root.

- `Dockerfile`  
  Builds the php-fpm + nginx + composer image.

- `docker-compose.yml`  
  Defines and runs the MySQL container.

- `Makefile`  
  Provides handy commands: `build`, `composer-install`, `start`, `stop`, etc.

---

## 2. Prerequisites

On your host machine you need:

- **Docker**  
- **Docker Compose** (the `docker compose` CLI)
- **make**  
  - On Ubuntu:  
    ```bash
    sudo apt update
    sudo apt install make
    ```

You **do not** need PHP or Composer installed locally.

---

## 3. First-Time Setup (Clone & Configure)

### 3.1. Clone the repository

```bash
cd ~/project          # or wherever you keep your projects
git clone <REPO_URL> <folder>
cd <folder>
make bedrock-init
```

### 3.1. Environment file
If not already present, create .env from the Bedrock and update values

### Remember to update your project name in Make file as well!


## 4. Running the Stack

### 4.1 Clone the repository
    ```bash
    docker compose up -d
    ```
### 4.2 Build the PHP-FPM + Nginx image
    ```bash
    make build
    ```
### 4.3 Install PHP dependencies via Composer (inside Docker)
    ```bash
    make composer-install
    ```
### 4.4 Start the application container
    ```bash
    make start
    ```

Happy hacking 👨‍💻🚀
This setup is designed so you can focus on building the WordPress/Bedrock site itself, while Docker handles PHP, webserver, and database for you.