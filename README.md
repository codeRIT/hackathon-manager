# HackathonManager [![Build Status](https://travis-ci.org/codeRIT/hackathon_manager.svg?branch=master)](https://travis-ci.org/codeRIT/hackathon_manager) [![Code Climate](https://codeclimate.com/github/codeRIT/hackathon_manager/badges/gpa.svg)](https://codeclimate.com/github/codeRIT/hackathon_manager) [![Test Coverage](https://codeclimate.com/github/codeRIT/hackathon_manager/badges/coverage.svg)](https://codeclimate.com/github/codeRIT/hackathon_manager/coverage) [![security](https://hakiri.io/github/codeRIT/hackathon_manager/master.svg)](https://hakiri.io/github/codeRIT/hackathon_manager/master)

***Still a work in progress! Instructions below are incomplete.** Check out [WiCHacks](https://github.com/sman591/wichacks) for an implementation example.*

Originally developed for [BrickHack](https://github.com/codeRIT/brickhack.io), this is a Ruby on Rails "plugin" that adds typical hackathon management features to any existing Ruby on Rails application.

* **Hacker applications:** Users sign up/in using [MyMLH](https://my.mlh.io/), which includes standard hackathon application info. This pre-fills the BrickHack application, so hackers don't have to duplicate information!
* **Acceptance, RSVPs**: Manage applications & coordinate acceptance/waitlist/denials
* **Bus Lists:** Coordinate bus sign-ups during the RSVP process while communicating important information to riders & captains
* **Email communication**: Ensure hackers get consistent, timely information throughout their application process, while enabling the organizing team to communicate important information at any time.
* **Statistics & Visualization:** Surface key information about the application base, distribution of applicants, progress towards attendance, etc.

## Usage

HackathonManager uses a variety of third-party services & Ruby gems:

* [Devise](https://github.com/plataformatec/devise) + [MyMLH](https://my.mlh.io/) (authentication & attendee identity)
* [Sidekiq](https://github.com/mperham/sidekiq) (background jobs)
* [Sparkpost](https://www.sparkpost.com/) (email)
* [Paperclip](https://github.com/thoughtbot/paperclip) + [Amazon S3](https://aws.amazon.com/s3/) (resume storage)
* [Chartkick](http://chartkick.com/) (management charts)

Steps to get the basic flow working:

1. Add an "apply" or "register" button on your hackathon homepage. This button directs the user through a sign up/login flow to collect their information.
```erb
<%= link_to 'Click here to apply!'.html_safe, questionnaires_path %>
```

2. Once you have at least one user in the system, you can promote them to an admin to access the management interface. Open up a console session with `bin/rails console`:
```ruby
>> User.last.update_attribute(:admin, true)
=> true
```

3. You can then access the management interface from `http://your-site/manage`

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'hackathon_manager'
```

And then execute:
```bash
$ bundle
```

Now, add our database migrations:
```bash
$ bin/rails railties:install:migrations
```

And finally, create the a `config/hackathon.yml` with the contents from [test/dummy/config/hackathon.yml](test/dummy/config/hackathon.yml). Be sure to make any necessary customizations!

### Customization

* **Emails**: The default email templates are located at [`/app/views/mailer`](https://github.com/codeRIT/brickhack.io/tree/develop/app/views/mailer). You can override these templates by copying the specific template(s) to the same `/app/views/mailer` in your Rails app and making the changes you need.
* **Styling**: The style for management, application, and RSVP pages can be customized by modifying your Rails app's `/app/assets/stylesheets/variable-overrides.sass` file. You can see the defaults in the hackathon_manager [`varaibles.sass`](https://github.com/codeRIT/hackathon_manager/blob/master/app/assets/stylesheets/variables.sass). The style for all other pages is controlled by your own stylesheets - hackathon_manager does not control those.

## Deployment

Deployment to Heroku and Dokku is supported out of the box, though anything that operates on Heroku's buildpacks should work too.

See [BrickHack's production setup](https://github.com/codeRIT/brickhack.io/wiki/Production-Environment-Setup) for detailed notes.

## Contributing

GitHub issues and pull requests welcome!

## License
The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).


# IMPORTANT

* Set a `root to:` (root path)
* Add `HackathonManager::Engine.load_seed` to your app's `db/seeds.rb`, then run `rails db:seed`
