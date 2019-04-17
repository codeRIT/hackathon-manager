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

**_HackathonManager is in the midst of a significant change to how it's deployed. If you're looking to use this *right now,* reach out to [Stuart Olivera](https://github.com/sman591)_**

HackathonManager uses a variety of third-party services & Ruby gems:

- [Devise](https://github.com/plataformatec/devise) + [MyMLH](https://my.mlh.io/) (authentication & attendee identity)
- [Sidekiq](https://github.com/mperham/sidekiq) (background jobs)
- [Sparkpost](https://www.sparkpost.com/) (email)
- [Paperclip](https://github.com/thoughtbot/paperclip) + [Amazon S3](https://aws.amazon.com/s3/) (resume storage)
- [Chartkick](http://chartkick.com/) (management charts)
- [Blazer](https://github.com/ankane/blazer) (custom SQL queries & analytics)

TODO: re-write usage here

## Installation

TODO: re-write installation here

### Customization

Be sure to review all of these before going live!

- **Content**: Various settings are available at http://your-site/manage/configs
- **Emails**: Default automated emails are loaded into http://your-site/manage/messages
- **Styling**: Custom styling is not yet supported, but should be available starting Summer 2019.

## Deployment

Deployment to Heroku and Dokku is supported out of the box, though anything that operates on Heroku's buildpacks should work too.

TODO: re-write deployment here

~See [BrickHack's production setup](https://github.com/codeRIT/brickhack.io/wiki/Production-Environment-Setup) for detailed notes.~

## Contributing

GitHub issues and pull requests welcome!

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
