# ShabbosPDF Backend

This is a Rails API backend for the ShabbosPDF project, designed to work with the React frontend. It uses MariaDB for data storage and sends a weekly email to all users every Friday at 6am.

## Features

- User management (first name, last name, email)
- CORS enabled for local frontend development
- Weekly email job (Friday 6am)
- MariaDB database

## Setup Instructions

### 1. Install Dependencies

- Ruby (3.4+ recommended)
- Rails (8.0+)
- MariaDB (or MySQL)
- Bundler (`gem install bundler`)

### 2. Install Gems

```
bundle install
```

### 3. Configure Database

- Ensure MariaDB is running.
- The default config uses your system username with no password. You can change this in `config/database.yml` if needed.
- Create the databases:

```
mariadb -u <your-username> -e "CREATE DATABASE IF NOT EXISTS shabbospdf_backend_development; CREATE DATABASE IF NOT EXISTS shabbospdf_backend_test;"
```

- Run migrations:

```
rails db:migrate
```

### 4. Run the Rails Server

```
rails server
```

### 5. API Endpoints

- All endpoints are under `/api/v1/users`
  - `GET    /api/v1/users` (list users)
  - `GET    /api/v1/users/:id` (show user)
  - `POST   /api/v1/users` (create user)
  - `PATCH  /api/v1/users/:id` (update user)
  - `DELETE /api/v1/users/:id` (delete user)

### 6. Cron Job for Weekly Emails

- The backend uses the `whenever` gem to schedule a job every Friday at 6am.
- To update your crontab:

```
bundle exec whenever --update-crontab
```

- The job will enqueue a background job to send emails to all users.

### 7. Email Configuration

- By default, Rails uses the `:smtp` delivery method. Configure your SMTP settings in `config/environments/development.rb` and `production.rb` as needed.

---

## Development Notes

- CORS is enabled for `localhost:3000` and `localhost:3001` for frontend development.
- Make sure to run a background job processor (e.g., with `bin/jobs` or `rails jobs:work`) for email delivery.

---

## License

MIT
