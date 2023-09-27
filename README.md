
# Cat Picture Management App

**Table of Contents**
- Introduction
- Getting Started
- Authentication
- Base URL
- Endpoints/Request and Response Examples
  - 1. Create a Cat Picture
  - 2. List Cat Pictures
  - 3. Get Cat Picture by ID
  - 4. Update Cat Picture
  - 5. Delete Cat Picture
- Status Codes/Error Responses
- Tests
- Conclusion

## Introduction

Welcome to the Cat Picture Management API documentation.The Cat Picture Management App is a Ruby on Rails application that allows users to manage and share cat pictures. It provides a set of RESTful APIs for creating, listing, getting, updating, and deleting cat pictures.Each API endpoint is designed to provide a specific set of functionalities for managing cat pictures in your application. This documentation provides an overview of the application and instructions for setup and usage.

---

## Getting Started and Deployment

### Prerequisites

Before you begin, make sure you have the following prerequisites installed and configured:

- **Docker:** Ensure that you have Docker installed on your system. You can download and install it from the official [Docker website](https://www.docker.com/products/docker-desktop/).

- **Git:** You'll need Git to clone the repository and manage your source code. Install Git from the [Git website](https://git-scm.com/downloads).

### Deployment Script

To deploy the Cat Picture Management App and get started quickly, follow these steps:

1. Clone the repository:

   ```shell
   git clone https://github.com/ankitshrey112/cat-images.git
   ```

2. Change to the project directory:

   ```shell
   cd cat-images
   ```

3. Run the deployment script:

   ```shell
   ./deploy-app.sh
   ```

The deployment script will automatically set up the application, install dependencies, configure the database, and start the Rails server.
Once the deployment script completes successfully, you can access the Cat Picture Management App by opening a web browser and navigating to:

```
http://localhost:3000
```

You can now start managing and sharing cat pictures using the application.

---

## Authentication

The Cat Picture Management App APIs are secured using Basic Authentication. Basic Authentication requires clients to include a username and password with their API requests. In our case, the username is "**ankit**" and the password is **12345**


## Base URL

The base URL for all API endpoints is:

```
http://localhost:3000/cat_images/
```
---

## Endpoints/Request and Response Examples

### 1. Create a Cat Picture

**Endpoint:** `POST /create`

**Description:** Upload a new cat picture to the database.

**Request Parameters:**

- `image` (File, required): The cat picture image file.
- `name` (String, optional): A title or description for the cat picture.
- `age` (String, optional): Age of the cat being uploaded.
- `breed` (String, optional): Breed of the cat being uploaded.

**Authentication:** Required

**Response (Success):**

```json
{
  "id": 1
}
```

**Possible Status Codes:** 201/401/400/500

### 2. List Cat Pictures

**Endpoint:** `GET /list`

**Description:** Retrieve a list of all cat pictures in the database.

**Request Parameters:**

- `page` (Integer, optional): The current page that needs to be accessed.
- `page_limit` (Integer, optional): Number of records to be accessed in the current page.

**Authentication:** Required

**Response (Success):**

```json
{
  "list": 
  [
    {
      "id": 1,
      "name": "Cute Cat 1",
      "age": 6,
      "breed": "Persian",
      "image_url": "https://your-api-domain.com/uploads/cat_picture_1.jpg",
      "created_at": "2023-09-30T12:00:00Z"
    },
    {
      "id": 2,
      "image_url": "https://your-api-domain.com/uploads/cat_picture_2.jpg",
      "created_at": "2023-09-30T12:30:00Z"
    }
  ],
  "current_page": 1,
  "current_count": 2,
  "total_pages": 1,
  "total_count": 2
}
```

**Possible Status Codes:** 200/401/400/500

### 3. Get Cat Picture by ID

**Endpoint:** `GET /get/:id`

**Description:** Retrieve a specific cat picture by its unique ID.

**Request Parameters:**

- `id` (Integer, required): The ID of the cat picture to retrieve.

**Authentication:** Required

**Response (Success):**

```json
{
  "data": {
    "id": 2,
    "name": "Cute Cat",
    "age": 10,
    "breed": "Persian",
    "image_url": "https://your-api-domain.com/uploads/cat_picture_2.jpg",
    "created_at": "2023-09-26T21:58:08.387Z"
  }
}
```
**Possible Status Codes:** 200/401/400/500/404

### 4. Update Cat Picture

**Endpoint:** `PUT /update/:id`

**Description:** Update the details or image of a cat picture.

**Request Parameters:**

- `id` (Integer, required): The ID of the cat picture to update.
- `image` (File, optional): The updated cat picture image file.
- `name` (String, optional): A title or description for the cat picture.
- `age` (String, optional): Age of the cat being uploaded.
- `breed` (String, optional): Breed of the cat being uploaded.

**Authentication:** Required

**Response (Success):**

```json
{
  "id": 1
}
```
**Possible Status Codes:** 200/401/400/500/404

### 5. Delete Cat Picture

**Endpoint:** `DELETE /cat_pictures/:id`

**Description:** Delete a specific cat picture by its unique ID.

**Request Parameters:**

- `id` (Integer, required): The ID of the cat picture to delete.

**Authentication:** Required

**Response (Success):**

```json
{
  "id": 1
}
```
**Possible Status Codes:** 200/401/400/500/404

---

## Status Codes/Error Responses

HTTP status codes are used to indicate the outcome of API requests. The following status codes have been commonly used in this API:

### 200 OK

- **Description**: The request was successful, and the server has returned the requested data.
- **Usage**: This status code is typically used for successful retrieval of resources in GET requests.

### 201 Created

- **Description**: The resource has been successfully created on the server.
- **Usage**: This status code is typically used for successful resource creation in POST requests.

### 400 Bad Request

- **Description**: The request is invalid or contains malformed data.
- **Usage**: This status code is returned when the client sends a request with invalid parameters or data.

### 401 Unauthorized

- **Description**: The client is not authenticated to access the requested resource.
- **Usage**: This status code is returned when the client lacks proper authentication credentials. The client should provide valid authentication to access the resource.

### 404 Not Found

- **Description**: The requested resource could not be found on the server.
- **Usage**: This status code is returned when the server cannot locate the resource specified in the request.

### 500 Internal Server Error

- **Description**: An unexpected error occurred on the server.
- **Usage**: This status code is returned when an unexpected error occurs during the processing of the request. It indicates a problem on the server-side.

Please refer to the specific API endpoints and their respective documentation for more details on the status codes they may return.

---

## Tests

This API is thoroughly tested using RSpec, a popular testing framework for Ruby. Test suites have been organized separately for each API service. You can run all the tests together by executing the provided script, `./run-tests.sh`. Below are details on running tests for each API service separately:

### Service 1 - /create

- **RSpec Test Suite**: The test suite for /create is located in the `spec/services/create_cat_image.rb` file.
- **Running Tests**:
  ```bash
  bundle exec rspec spec/services/create_cat_image.rb
  ```

### Service 2 - /update

- **RSpec Test Suite**: The test suite for /update is located in the `spec/services/update_cat_image.rb` file.
- **Running Tests**:
  ```bash
  bundle exec rspec spec/services/update_cat_image.rb
  ```

### Service 3 - /list

- **RSpec Test Suite**: The test suite for /list is located in the `spec/services/list_cat_images.rb` file.
- **Running Tests**:
  ```bash
  bundle exec rspec spec/services/list_cat_images.rb
  ```

### Service 4 - /get

- **RSpec Test Suite**: The test suite for /get is located in the `spec/services/get_cat_image.rb` file.
- **Running Tests**:
  ```bash
  bundle exec rspec spec/services/get_cat_image.rb
  ```

### Service 5 - /delete

- **RSpec Test Suite**: The test suite for /delete is located in the `spec/services/delete_cat_image.rb` file.
- **Running Tests**:
  ```bash
  bundle exec rspec spec/services/delete_cat_image.rb

### Running All Tests

You can run all the tests for all services together by executing the following script:
```bash
./run-tests.sh
```

This script will execute all the test suites in sequence, providing comprehensive coverage of you API endpoints.

---

## Conclusion

In conclusion, this documentation provides a comprehensive guide to the Cat Picture Management App's API, allowing you to seamlessly manage and share cat pictures. You've learned how to get started with the application, set up authentication, and interact with various endpoints for creating, listing, getting, updating, and deleting cat pictures.

By following the provided instructions, you can quickly deploy the application and begin using these powerful APIs to enhance your cat picture management experience.

---
---
