# Setup

## System Dependencies
Per [getting started section](https://guides.rubyonrails.org/getting_started.html#creating-a-new-rails-project) of the official Rails guides, you'll need the following dependencies:
- Ruby
- SQLite
- Node
- Yarn

## Versions
- Ruby: `3.0.2`
- Rails: `6.1.4`

## Local Development

To run this app locally:

1. Run database migrations: `rails db:migrate`
2. Seed the database: `rails db:seed`
3. Start webpack: `bin/webpack-dev-server`
4. Start the Rails server: `rails s`

The app should now be accessible at http://localhost:3000

## Testing

To run the test suite:

1. Compile webpack assets for test environment: `RAILS_ENV=test rails webpacker:compile`
2. Execute test command: `rails test`

# Design Decisions and Future Considerations

## Features

### Admin user viewing Customer account
The `Customer` index page uses the `users/show` template, so `Admin` users have access to the same view via `/user/:id` (`user_path`).

### Customer Last Login
When creating a session, we `touch` the `User` record so we can effectively use the `updated_at` column as the last login.

## Single Table Inheritance (STI)
The `Customer` and `Admin` are implemented as subclasses of `User` since the attributes are the same. The primary motivations for using STI were keeping the database schema simple and the code DRY. If the subclasses begin to diverge in schema, we might consider moving away from STI.

## Sessions
Sessions are implemented using the default Rails `CookieStore`, so session info is stored client side. As it's currently implemented, the app only supports a single user session (regardless of type) at a time. If we need to support multiple, concurrent sessions, we'd want to implement a server side session store.
