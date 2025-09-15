# SpecFixer - Quote of the Day Application

A modern Rails 8 application featuring a beautiful "Quote of the Day" functionality, designed for learning GitHub Actions and Rails development best practices.

## 🌟 Features

### Quote of the Day
- **Daily Inspiration**: Get a consistent quote throughout the day based on the current date
- **Random Quotes**: Refresh to discover new quotes anytime with AJAX functionality
- **Curated Collection**: 12+ carefully selected quotes from various categories and authors
- **Beautiful UI**: Modern, responsive design with smooth animations
- **Categories**: Quotes organized by motivation, inspiration, success, wisdom, and more

### Technical Features
- **Rails 8**: Built with the latest Rails framework
- **Comprehensive Testing**: Full RSpec test suite with model, controller, and feature specs
- **GitHub Actions**: Automated CI/CD pipeline for testing and code quality
- **Responsive Design**: Mobile-first approach with modern CSS
- **AJAX Integration**: Seamless quote refreshing without page reload
- **Database Seeding**: Pre-populated with inspiring quotes

## 🚀 Getting Started

### Prerequisites
- Ruby 3.3.1
- Rails 8.0.2+
- SQLite3 (development) / PostgreSQL (production)
- Node.js (for asset pipeline)

### Installation

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd specfixer
   ```

2. **Install dependencies**
   ```bash
   bundle install
   ```

3. **Setup the database**
   ```bash
   rails db:create
   rails db:migrate
   rails db:seed
   ```

4. **Start the server**
   ```bash
   rails server
   ```

5. **Visit the application**
   Open your browser and navigate to `http://localhost:3000`

## 🧪 Testing

### Running the Test Suite

```bash
# Run all tests
bundle exec rspec

# Run specific test types
bundle exec rspec spec/models/
bundle exec rspec spec/controllers/
bundle exec rspec spec/features/

# Run with coverage
bundle exec rspec --format documentation
```

### Test Coverage
- **Model Tests**: Comprehensive validation and method testing for Quote model
- **Controller Tests**: Full coverage of HomeController actions
- **Feature Tests**: End-to-end testing of user interactions
- **Factory Bot**: Well-defined factories for test data generation

## 🔧 GitHub Actions Workflow

The application includes a comprehensive GitHub Actions workflow (`.github/workflows/rspec.yml`) that:

### Main Test Job
- Runs on Ubuntu with Ruby 3.3.1
- Sets up PostgreSQL database
- Installs dependencies and sets up the database
- Runs RSpec tests with JUnit formatting
- Uploads test results as artifacts
- Runs Rubocop for code style checking
- Runs Brakeman for security scanning

### System Test Job
- Runs feature tests with Chrome browser
- Captures screenshots on failure
- Uploads artifacts for debugging

### Triggers
- Push to `main` or `develop` branches
- Pull requests to `main` or `develop` branches

## 📁 Project Structure

```
app/
├── controllers/
│   └── home_controller.rb          # Main controller for homepage
├── models/
│   └── quote.rb                    # Quote model with business logic
├── views/
│   └── home/
│       ├── index.html.erb          # Homepage template
│       └── _quote_card.html.erb    # Quote card partial
└── assets/
    └── stylesheets/
        └── application.css         # Modern CSS styling

spec/
├── models/
│   └── quote_spec.rb              # Quote model tests
├── controllers/
│   └── home_controller_spec.rb    # Controller tests
├── features/
│   └── quote_of_the_day_spec.rb   # Feature tests
└── factories/
    └── quotes.rb                  # Test data factories

.github/
└── workflows/
    └── rspec.yml                  # GitHub Actions CI/CD pipeline
```

## 🎨 Quote of the Day Feature Details

### Quote Model (`app/models/quote.rb`)
- **Validations**: Ensures content, author, and category are present
- **Scopes**: Filter quotes by category
- **Class Methods**:
  - `daily_quote`: Returns consistent quote for the current day
  - `random_quote`: Returns random quote for refresh functionality
  - `create_default_quote`: Creates fallback quote when database is empty
- **Instance Methods**:
  - `formatted_display`: Returns formatted quote string

### Home Controller (`app/controllers/home_controller.rb`)
- **index**: Displays homepage with daily quote
- **refresh_quote**: AJAX endpoint for getting new random quotes

### Frontend Features
- **Responsive Design**: Works on desktop, tablet, and mobile
- **AJAX Refresh**: Get new quotes without page reload
- **Loading States**: Visual feedback during quote refresh
- **Smooth Animations**: CSS transitions and keyframe animations
- **Modern Styling**: Gradient backgrounds, cards, and hover effects

## 🗄️ Database Schema

### Quotes Table
```ruby
create_table "quotes" do |t|
  t.text "content", null: false      # The quote text
  t.string "author", null: false     # Quote author
  t.string "category", null: false   # Quote category
  t.timestamps
end
```

## 🌱 Seeding Data

The application comes with 12 pre-selected quotes from various categories:
- Motivation (Steve Jobs, Tony Robbins)
- Inspiration (Aristotle, Eleanor Roosevelt)
- Success (Winston Churchill)
- Wisdom (Will Rogers, Vernon Law)
- Life lessons (John Lennon)
- And more...

Run `rails db:seed` to populate your database with these quotes.

## 🚀 Deployment

### Using Kamal (Recommended)
The application is configured for deployment with Kamal:

```bash
kamal setup
kamal deploy
```

### Manual Deployment
1. Set up your production database
2. Configure environment variables
3. Run migrations: `rails db:migrate RAILS_ENV=production`
4. Seed data: `rails db:seed RAILS_ENV=production`
5. Precompile assets: `rails assets:precompile`
6. Start the server

## 🧰 Development Tools

### Code Quality
- **Rubocop**: Ruby style guide enforcement
- **Brakeman**: Security vulnerability scanning
- **RSpec**: Behavior-driven development testing

### Testing Tools
- **Factory Bot**: Test data generation
- **Capybara**: Integration testing
- **Selenium WebDriver**: Browser automation
- **Shoulda Matchers**: Rails-specific matchers

## 📚 Learning GitHub Actions

This project is perfect for learning GitHub Actions because it includes:

1. **Multiple Jobs**: Separate jobs for unit tests and system tests
2. **Matrix Strategy**: Testing across different Ruby versions
3. **Service Containers**: PostgreSQL database setup
4. **Artifacts**: Uploading test results and screenshots
5. **Conditional Steps**: Running steps based on success/failure
6. **Security Scanning**: Automated security checks
7. **Code Quality**: Style and lint checking

### Key GitHub Actions Concepts Demonstrated
- Workflow triggers (push, pull_request)
- Job dependencies and parallelization
- Environment variables and secrets
- Service containers for databases
- Artifact uploading and downloading
- Matrix builds for multiple environments
- Conditional execution with `if` statements

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch: `git checkout -b feature/amazing-feature`
3. Make your changes and add tests
4. Run the test suite: `bundle exec rspec`
5. Commit your changes: `git commit -m 'Add amazing feature'`
6. Push to the branch: `git push origin feature/amazing-feature`
7. Open a Pull Request

## 📄 License

This project is open source and available under the [MIT License](LICENSE).

## 🙏 Acknowledgments

- Quotes sourced from various inspirational figures
- Built with Ruby on Rails 8
- Styled with modern CSS and responsive design principles
- Tested with RSpec and comprehensive test coverage
