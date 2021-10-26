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

## Single Table Inheritance (STI)
The `Customer` and `Admin` are implemented as subclasses of `User` since the attributes are the same. The primary motivations for using STI were keeping the database schema simple and the code DRY. If the subclasses begin to diverge in schema, we might consider moving away from STI.

## Sessions
Sessions are implemented using the default Rails `CookieStore`, so session info is stored client side. The session object has up to 2 key:
1. `user_id`: used to identify the `current_user`
2. `admin_user_id`: used to identify the `current_admin_user`

If we need to support multiple, concurrent sessions, we'd want to implement a server side session store.

## Features

### Admin Login as Customer
`Admin` users can "login" to `Customer` accounts via the Admin index page `/admins`. This means they can navigate the app as if they were using the `Customer`'s account. To see the difference:
1. View a `Customer`'s details by using the "Show" action - you should see a section called "Admin Debug Info" on the details page.
2. Navigate back to the Admin index (via browser navigation or "Admin" link at the top)
3. Login as the same `Customer` using the "Login" action - you should see the same details page, but without the "Admin Debug Info" section.

Logging out as an `Admin` logged in as a `Customer` should not fully sign out of the app - it should return you to the Admin index.

### Customer Last Login
When creating a session, we `touch` the `User` record so we can effectively use the `updated_at` column as the last login.
