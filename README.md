# SLIDE-ME

## URLs
- Soon here will be staging api url

## Ruby version
3.0.0

## Major dependecies
- 'action_policy' for authorization and scoping,
- 'blueprinter' on 'oj' for serializing to JSON,
- 'devise', 'doorkeeper' and 'doorkeeper-jwt' for authentication,

### Runtime

### Development or Tests

- 'database_cleaner' for flushing db in the test mode,
- 'dotenv-rails' for local configuration,
- 'factory_bot' and 'factory_bot_rails' for test data setup,
- 'pry' for debugging,
- 'rspec-rails' for tests,
- 'rswag' for testing api responses against schemas and documentation,
- 'rubocop', 'rubocop-performance', 'rubocop-rails' for style checks,
- 'shoulda-matchers' mainly for model specs,
- 'faker' to generate test data
 
## Configuration

### Project Setup

1. Clone repo 

```bash
git clone https://github.com/bartosz-stafiej/Slide.me.git
cd slide.me
```

2. Copy configuration
```bash
cp .env.example .env
```

3. Instal deps
```bash
bundle install
```

4. Create DB
```bash
# need to install postgres 13 before 
bundle exec rails db:create 
bundle exec rails db:migrate
bundle exec rails db:seed
```

5. Running server (optionally since it is api only project)
```bash
bundle exec rails s
```

## Tests

Running rspec tests
```bash
bundle exec rspec 
```

## General info
- Cover all requests on and with 100% rspec tests 
- update swagger by running
```bash
SWAGGER_DRY_RUN=0  bundle exec rails rswag
```
- run this comman before commit to keep code clean
```bash
bundle exec rubocop -A 
```
- alwats create another branch and pr's if want to push on staging / main
- don't merge PR's without approve

