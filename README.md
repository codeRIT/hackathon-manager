# HackathonManager

[![Build Status](https://travis-ci.org/codeRIT/hackathon_manager.svg?branch=master)](https://travis-ci.org/codeRIT/hackathon_manager)
[![Code Climate](https://codeclimate.com/github/codeRIT/hackathon_manager/badges/gpa.svg)](https://codeclimate.com/github/codeRIT/hackathon_manager)
[![Test Coverage](https://codeclimate.com/github/codeRIT/hackathon_manager/badges/coverage.svg)](https://codeclimate.com/github/codeRIT/hackathon_manager/coverage)
[![security](https://hakiri.io/github/codeRIT/hackathon_manager/master.svg)](https://hakiri.io/github/codeRIT/hackathon_manager/master)

Originally developed for [BrickHack](https://github.com/codeRIT/brickhack.io), this is a Ruby on Rails web application for managing hackathons.

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
- [Sparkpost](https://www.sparkpost.com/) (email)
- [Paperclip](https://github.com/thoughtbot/paperclip) + [Amazon S3](https://aws.amazon.com/s3/) (resume storage)
- [Chartkick](http://chartkick.com/) (management charts)
- [Blazer](https://github.com/ankane/blazer) (custom SQL queries & analytics)
- [Doorkeeper](https://github.com/doorkeeper-gem/doorkeeper) (authentication via OAuth for API usage)

See [Deployment](#Deployment) for instructions to deploy.

### Customization

Be sure to review all of these before going live!

- **Content**: Various settings are available at http://your-site/manage/configs
- **Emails**: Default automated emails are loaded into http://your-site/manage/messages
- **Styling**: Custom styling is not yet supported, but should be available starting Summer 2019.

## Deployment

HackathonManager supports two platforms out of the box:

- [Heroku](https://www.heroku.com) — Easiest & quickest way that requires little server knowledge, however isn't cheap (free tier not recommended)
- [Dokku](http://dokku.viewdocs.io/dokku/) — A free alternative to Heroku, runs on your own virtual machine
- _Coming soon: OKD/OpenShift — "Enterprise Kubernetes for Developers" packaged with a useful management UI + tooling_

See the platform-specific guides [on the Wiki](https://github.com/codeRIT/hackathon_manager/wiki) to get started!

HackathonManager can also be deployed the same as any other Rails app, however this is **not** natively supported and will require you to fork this repo to integrate code changes.

[![Deploy](https://www.herokucdn.com/deploy/button.svg)](https://heroku.com/deploy)

## Contributing

GitHub issues and pull requests welcome!

## Development

Pre-requisite: Have a functioning, local Ruby + MySQL development environment. [See this guide for pointers.](https://gorails.com/setup)

1. Clone the repo

```bash
$ git clone git@github.com:codeRIT/hackathon_manager
$ cd hackathon_manager
```

2. Install dependencies

```bash
$ bundle install
```

3. Setup databse

```bash
$ bin/rails db:setup
```

4. Start up the server

```bash
$ bin/rails s  # short for bin/rails server
```

4. Visit http://localhost:3000/apply, create an account, and complete an application

5. In another bash window, promote your user to an admin

```bash
$ cd hackathon_manager
$ bin/rails c  # short for bin/rails console
# Wait for the console to start...
Loading development environment (Rails 5.1.1)
irb(main):001:0> User.last.update_attribute(:role, :admin)
```

6. Visit http://localhost:3000/manage and set up the hackathon as needed

### Development Utilities

- **Mail View** - Email templates can be previewed at http://localhost:3000/rails/mailers
- **Mail Catcher** - When active, emails will be captured by MailCatcher instead of slipping into a black hole (no emails are ever sent in development). Visit [mailcatcher.me](http://mailcatcher.me/) and follow instructions under "How" to get setup.
- **Guard** - Automatically runs tests based on the files you edit. `bundle exec guard`
- **Coverage** - Test coverage can be manually generated via the `bin/rails coverage:run` command. Results are then made available in the `coverage/` directory.
- **Sidekiq** - Run background jobs (such as emails) and view active & completed jobs. Sidekiq is automatically started with Docker - a dashboard is available at http://localhost:3000/sidekiq (_also available in production_).

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
