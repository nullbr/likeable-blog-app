# Likeable Blog App

[![Ruby Style Guide](https://img.shields.io/badge/code_style-rubocop-brightgreen.svg)](https://github.com/rubocop/rubocop)
![Ruby Version](https://img.shields.io/badge/ruby_version-3.3.5-blue.svg)
![Rails Version](https://img.shields.io/badge/rails_version-8.0.1-blue.svg)

This is a RESTful API for managing blog posts, users, and ratings. It provides endpoints to create posts, rate them, retrieve top-rated posts, and get information about posts based on IP addresses and associated authors. The API supports the following features:

## Features

- **Create a New Post**

  - Allows users to create new blog posts.
  - Automatically creates a new user if they do not exist, based on the provided login.
  - Accepts title, body, user login, and user IP address as input.
  - Returns the created post along with the associated user information.

- **Rate a Post**

  - Users can rate posts on a scale of 1 to 5.
  - Each user can rate a post only once.
  - The rating value is saved, and the average rating of the post is returned.

- **Get Top N Posts by Average Rating**

  - Allows querying the top N posts based on average ratings.
  - Returns the `id`, `title`, and `body` of the posts, ordered by their average rating.

- **Get Posts by IP with Multiple Authors**
  - Retrieves IP addresses that have been used to post by more than one unique user.
  - Returns a list of IP addresses along with an array of the authors (user logins) who posted from that IP.

## API Endpoints

### `POST /api/v1/posts`

- **Description:** Creates a new post.
- **Request Parameters:**
  - `title` (string): Title of the post.
  - `body` (string): Content of the post.
  - `login` (string): User's login.
  - `ip` (string): User's IP address.
- **Response:**
  - `201 Created`: The created post with user details.
  - `422 Unprocessable Entity`: Validation errors (e.g., missing parameters).

### `POST /api/v1/posts/rate`

- **Description:** Rates a post.
- **Request Parameters:**
  - `post_id` (integer): ID of the post to rate.
  - `user_id` (integer): ID of the user who is rating the post.
  - `value` (integer): Rating value (1 to 5).
- **Response:**
  - `200 OK`: The average rating of the post.
  - `422 Unprocessable Entity`: Validation errors (e.g., user already rated the post).
  - `404 Not Found`: User or Post were not found.

### `GET /api/v1/posts/top`

- **Description:** Retrieves the top N posts by average rating.
- **Request Parameters:**
  - `n` (integer): Number of top posts to retrieve.
- **Response:**
  - `200 OK`: List of top N posts with their `id`, `title`, and `body`.

### `GET /api/v1/posts/ip_authors`

- **Description:** Retrieves IP addresses with multiple authors.
- **Response:**
  - `200 OK`: List of IP addresses and associated authors.

## Technologies Used

- Ruby on Rails (backend)
- PostgreSQL (database)
- Faker (for generating fake data)
- curl (for making API requests)

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

### **Seed database with mock data**

```sh
docker-compose exec web rails db:seed
```

### **Run the Rails console** (optional)

```sh
docker-compose exec web rails console
```

### **Stop the development environment**

```sh
docker-compose down
```

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
