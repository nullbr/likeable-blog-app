# Likeable Blog App

[![Ruby Style Guide](https://img.shields.io/badge/code_style-rubocop-brightgreen.svg)](https://github.com/rubocop/rubocop)
![Ruby Version](https://img.shields.io/badge/ruby_version-3.3.5-blue.svg)
![Rails Version](https://img.shields.io/badge/rails_version-8.0.1-blue.svg)

TODO: add description

## Features

- TODO: add features

---

## Development Setup

### **Prerequisites**

Ensure you have the following installed on your machine:

- **Docker**
- **Docker Compose**

### **Clone the repository**

```sh
git clone https://github.com/nullbr/likeable-blog-app.git
cd likeable-blog-app
```

### **Start the development environment**

```sh
docker-compose up --build
```

This will:

- Build the Docker images
- Start the PostgreSQL database
- Start the Rails server at ``

### **Set up the database**

```sh
docker-compose exec web rails db:create db:migrate
```

### **Run the Rails console** (optional)

```sh
docker-compose exec web rails console
```

### **Stop the development environment**

```sh
docker-compose down
```

---

## Troubleshooting

If you encounter issues:

1. Ensure Docker and Docker Compose are installed and running.
2. Check if the database container is running:
   ```sh
   docker ps
   ```
3. Restart the environment:
   ```sh
   docker-compose down && docker-compose up --build
   ```
4. Check logs for errors:
   ```sh
   docker-compose logs web
   ```
