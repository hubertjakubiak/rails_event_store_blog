# Rails Event Store Blog

This project is a Ruby on Rails application that implements a simple blog system with event sourcing using the Rails Event Store. The main features of the project include:

## Post Management

- Users can create, update, and delete blog posts.
- Each post has a title and body.

## Event Sourcing

The application uses event sourcing to manage the state of posts. Events such as `PostCreated`, `PostUpdated`, and `PostDeleted` are used to track changes to posts.

## Command Pattern

Commands encapsulate the intent to perform actions like creating, updating, and deleting posts. They are validated and then passed to the aggregates to apply the necessary changes.

## Aggregates

The `PostAggregate` class is used to encapsulate the domain logic for creating, updating, and deleting posts, ensuring that the state changes are validated and applied consistently.

## Projections

The `PostProjection` class is used to update the read model based on the events.

## How to Test the Application

1. Create and migrate the database:
    ```sh
    rails db:create db:migrate
    ```

2. Start the Rails server:
    ```sh
    bundle exec rails s
    ```

3. Visit the application in your browser:
    ```
    http://localhost:3000/
    ```

4. Perform the following actions:
    - Create a new post
    - Edit the post
    - Destroy the post

5. View all events:
    ```
    http://localhost:3000/res
    ```
