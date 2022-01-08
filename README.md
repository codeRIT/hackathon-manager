# HackathonManager

Test

[![Build Status](https://travis-ci.org/codeRIT/hackathon-manager.svg?branch=master)](https://travis-ci.org/codeRIT/hackathon-manager)
[![Code Climate](https://codeclimate.com/github/codeRIT/hackathon-manager/badges/gpa.svg)](https://codeclimate.com/github/codeRIT/hackathon-manager)
[![Test Coverage](https://codeclimate.com/github/codeRIT/hackathon-manager/badges/coverage.svg)](https://codeclimate.com/github/codeRIT/hackathon-manager/coverage)
[![security](https://hakiri.io/github/codeRIT/hackathon-manager/master.svg)](https://hakiri.io/github/codeRIT/hackathon-manager/master)

An all-in-one platform for managing hackathon registration & logistics, originally developed for [BrickHack](https://github.com/codeRIT/brickhack.io).

Read more at **[coderit.org/hackathon-manager/](https://coderit.org/hackathon-manager/)**

- **Hacker applications:** Enable hackers to apply to your hackathon while providing all relevant information (contact info, school, demographics, etc)
- **MyMLH support:** Streamline the application process when users log in with [MyMLH](https://my.mlh.io/), a common platform for applying to any MLH hackathon. Basic info is pre-filled based on a common application, so hackers don't have to re-type it every time.
- **Admissions & RSVPs**: Facilitate accepting hackers to your hackathon & enable them to RSVP
- **Bus Lists:** Coordinate bus sign-ups during the RSVP process while communicating important information to riders & captains
- **Email communication**: Ensure hackers get consistent, timely information throughout their application process, while enabling your organizing team to communicate important information at any time.
- **Statistics & Visualization:** Surface key analytics about your admissions, distribution of applicants, progress towards attendance, etc.

## Usage

HackathonManager is a standalone web app separate from your regular marketing website/public homepage.

A typical setup would be:

- **brickhack.io** — Marketing site with event info, schedule, sponsors, etc and a button to apply
- **apply.brickhack.io** — HackathonManager deployment to accept hacker applications + host management dashboard

This allows your public marketing site to operate however you want it (e.g. GitHub pages) while HackathonManager lives in an isolated, consistent environment.

HackathonManager makes use of a few different third-party services & Ruby gems:

- [Devise](https://github.com/plataformatec/devise) + [MyMLH](https://my.mlh.io/) (authentication & attendee identity)
- [Sidekiq](https://github.com/mperham/sidekiq) (background jobs)
- [SendGrid](https://sendgrid.com) (email)
- [Amazon S3](https://aws.amazon.com/s3) (resume storage)
- [Chartkick](http://chartkick.com) (management UI charts)
- [Blazer](https://github.com/ankane/blazer) (custom SQL queries, analytics, and charts)
- [Doorkeeper](https://github.com/doorkeeper-gem/doorkeeper) (authentication via OAuth for API usage)

## Get Started

**[Deploy HackathonManager for your hackathon &raquo;](https://coderit.org/hackathon-manager/docs/deployment)**

[![Deploy](https://www.herokucdn.com/deploy/button.svg)](https://heroku.com/deploy)

## Documentation

Documentation is available at https://coderit.org/hackathon-manager/

Docs are maintained as markdown files in the `docs/` folder, with the website configuration & tooling stored in `website/`.

Doc & website changes are auto-built and deployed via [Travis CI](https://travis-ci.org/codeRIT/hackathon-manager) once merged into master.

## Commits + Releases

Releases are automatically generated by [semantic-release](https://github.com/semantic-release/semantic-release) using commit messages.

Commit messages should follow the standard `type(scope): subject` format. For example:

* `feat: Improve form typography`
* `deploy(heroku): Ensure db:migrate is run after each deploy`
* `fix: Support HTTPS in questionnaire portfolio URL`

For more information, see semantic-release's [how does it work](https://github.com/semantic-release/semantic-release#how-does-it-work).

## Contributing

GitHub issues and pull requests welcome!

All documentation is easily editable using the GitHub UI. Click the "Edit" button at the top of any documentation page to get started.

If there's a new feature you're looking to implement, **please** file an issue to open discussion on the feature before starting work or opening a pull request.

## Local Development

1. Setup Ruby + MySQL for local development

If you don't already have Ruby + MySQL set up, see [this guide by GoRails](https://gorails.com/setup) for pointers.

* Select your computer's operating system & version
* If given the choice, use `rbenv` -- this will ensure a clean, sustainable Ruby dev environment
* SQLite and PostgreSQL steps are optional

2. Clone the repo

```bash
$ git clone git@github.com:codeRIT/hackathon-manager
$ cd hackathon-manager
```

3. Install dependencies

```bash
$ bundle install
```

4. Setup databse

```bash
$ bin/rails db:setup
```

5. Start up the server

```bash
$ bin/rails s  # short for bin/rails server
```

6. Visit http://localhost:3000/apply, create an account, and complete an application

7. In another bash window, promote your user to a director

```bash
$ cd hackathon-manager
$ bin/rails c  # short for bin/rails console
# Wait for the console to start...
Loading development environment (Rails 5.1.1)
irb(main):001:0> User.last.update_attribute(:role, :director)
```

8. Visit http://localhost:3000/manage and set up the hackathon as needed

_See https://coderit.org/hackathon-manager/ for docs on regular hackathon setup_

### Local Development Utilities

- **Mail View** - Email templates can be previewed at http://localhost:3000/rails/mailers
- **Mail Catcher** - When active, emails will be captured by MailCatcher instead of slipping into a black hole (no emails are ever sent in development). Visit [mailcatcher.me](http://mailcatcher.me/) and follow instructions under "How" to get setup.
- **Guard** - Automatically runs tests based on the files you edit. `bundle exec guard`
- **Coverage** - Test coverage can be manually generated via the `bin/rails coverage:run` command. Results are then made available in the `coverage/` directory.
- **Sidekiq** - Run background jobs (such as emails) and view active & completed jobs. Sidekiq is automatically started with Docker - a dashboard is available at http://localhost:3000/sidekiq (_also available in production_).

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
