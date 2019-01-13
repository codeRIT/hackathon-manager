**Please note 0.x releases are development releases and there will be breaking changes until we hit 1.0. For more information, see [semver](http://semver.org/#how-should-i-deal-with-revisions-in-the-0yz-initial-development-phase).**

# 0.11.1 - 2019-01-13

* Improvement: Add buttons to quickly build bus list, school messages
* Improvement: Filter events list by user or band ID
* Cleanup: Remove "invite to slack" feature
* Cleanup: Remove carpool link env variable

# 0.11.0 - 2019-01-09

**Note:** Be sure to run `rails railties:install:migrations` and `rails db:migrate` after upgrading.

* Feature: Trackable tags + events! Coupled with the JSON API and a mobile app, this makes it easy to collect RFID tagging over time.

# 0.10.2 - 2019-01-06

* Fix: Redirect after merging two schools
* Feature: Add mobile nav
* Improvement: Add GUI for editing message body markdown w/fullscreen support
* Improvement: Make key information stand out in messages table
* Improvement: Re-order 18-year-old compliance check to top of list
* Improvement: Better dashboard chart logic for incomplete data states
* Improvement: Separate "MLH Info" table into two "applied" and "checked in" tables

# 0.10.1 - 2019-01-04

* Improvement: Add support for JSON APIs on management controllers

# 0.10.0 - 2019-01-02

**Note:** Be sure to run `rails railties:install:migrations` and `rails db:migrate` after upgrading.

* Feature: Support OAuth2 integrations for API-level access to hackathon manager routes, powered by [doorkeeper](https://github.com/doorkeeper-gem/doorkeeper)

# 0.9.2 - 2018-11-26

* Fix: Left-align text in emails instead of justify

# 0.9.1 - 2018-11-25

* Fix: Send application confirmation email to new applicants

# 0.9.0 - 2018-11-25

**Note:** Be sure to run `rails railties:install:migrations` and `rails db:migrate` after upgrading.

* Feature: Add graduation year, race/ethnicity questions to questionnaire
* Improvement: Increase email preview & textarea heights
* Improvement: Bold titles in admin tables for better readability

# 0.8.2 - 2018-11-25

* Improvement: Update MLH policy disclaimer

# 0.8.1 - 2018-10-26

* Fix: Default mailer template

# 0.8.0 - 2018-10-25

**Critical Breaking Change**

Old templates in `app/views/mailers` **must** be manually migrated into the new management UI. The existing automated emails will no longer function.

For each of these templates, create a new "Automated" message at `https://your-website.com/manage/messages`, set the appropriate trigger event, and copy their content over. Be sure to convert any Ruby/ERB code to static HTML as it is no longer supported.

* app/views/mailer/application_confirmation_email.html.erb
* app/views/mailer/denied_email.html.erb
* app/views/mailer/rsvp_confirmation_email.html.erb
* app/views/mailer/accepted_email.html.erb

Release notes:

**Note:** Be sure to run `rails railties:install:migrations` and `rails db:migrate` after upgrading.

* Feature: Consolidated most automated emails into the management UI
* Feature: Show side-by-side preview of message when editing
* Feature: Provide real default email template ([leemunroe/responsive-html-email-template](https://github.com/leemunroe/responsive-html-email-template))
* Improvement: Cleaned up how automated & bulk emails are explained in the UI
* Improvement: Improve nav & layout for mobile
* Improvement: Better flag applicants w/dietary or special needs
* Improvement: Add dietary & special needs to questionnaires table
* Maintenance: Upgrade to Ruby 2.5.2, update gems

# 0.7.1 - 2018-07-29

* Fix: Support Rails 5.1+ migrations

# 0.7.0 - 2018-07-29

**Note:** Be sure to run `rails railties:install:migrations` and `rails db:migrate` after upgrading.

* Feature: New management UI based on Bootstrap (public UI remains the same)
* Feature: Add optional `favicon_asset` configuration option to `hackathon.yml`
* Improvement: Support omniauth lookup by email instead of UID
* Improvement: Update gems & Ruby support
* Fix: Require bus list capacity to be set
* Fix: FIPS code fetching
* Fix: Remove email column from questionnaires table

# 0.6.6 - 2018-02-02

* Feature: Send email to recipients from Blazer query
* Improvement: Copy MLH dropdown defaults for gender & level of study questions

# 0.6.5 - 2018-01-31

* Improvement: Set transactional SparkPost option on select emails
* Fix: Don't retry SparkPost generation rejections

# 0.6.4 - 2018-01-30

* Improvement: Include resume & school name in sponsor info export

# 0.6.3 - 2018-01-26

**Note:** Be sure to run `rails railties:install:migrations` and `rails db:migrate` after upgrading.

* Feature: Allow bus captains to mark who boards a bus
* Feature: Add optional columns to questionnaire datatable
* Feature: Show duplicate name mappings on school detail page
* Fix: Fix admin form for questionnaires

# 0.6.2 - 2018-01-25

* Feature: Notice when updating individual acceptance status
* Feature: Add school name to MLH info
* Fix: Fix sending of triggered emails to correct recipient

# 0.6.1 - 2018-01-22

**Note:** Be sure to add `event_start_date` to hackathon.yml

* Feature: Display notice for applicants under 18 years old
* Fix: Allow entry of birth dates up to 5 years ago
* Fix: Support viewing of messages with invalid recipients

# 0.6.0 - 2018-01-17

**Note:** Be sure to run `rails railties:install:migrations` and `rails db:migrate` after upgrading.

* **Major refactor to bulk email messaging**
* Feature: Automatically send emails upon triggered events
* Feature: Support message recipients from any school and bus list
* Feature: Display what acceptance statuses cause automatic emails
* Fix: Raise error upon reaching unknown recipient query

# 0.5.11 - 2018-01-15

**Note:** Be sure to run `rails railties:install:migrations` and `rails db:migrate` after upgrading.

* Consolidate display of email events
* Make acceptance status searchable in questionnaire table
* Improve error message for agreement checkboxes
* Improve descriptin of how Slack invitations work
* Add delivery date to message table
* Set default questionnaire_count on schools

# 0.5.10 - 2018-01-13

**Note:** Be sure to migrate environment variable `INVITE_TO_SLACK_WHEN_ACCEPTED` to `INVITE_TO_SLACK_UPON_RSVP` if in use.

* Give visual feedback to RSVP updates
* Display recipient count on message overview page
* Don't send Slack invite until user has RSVP'd
* Fix query for non-checked-in, accepted or RSVP’d recipients
* Fix display of denied status
* Fix duplicate display of notice banners

# 0.5.9 - 2018-01-10

* Provide config for post-RSVP confirmation message
* Make why_attend question optional
* Match radio inputs to form styles

# 0.5.8 - 2018-01-08

* Support html in `flash[:notice]`
* Don't send application reminder email to admins
* Queue incomplete reminder email more reliably
* Add support for variable slack subdomain
* Enable Devise :timeoutable for user
* Fix unexpected mail job errors

# 0.5.7 - 2018-01-06

* Use consistent flash support on all pages ([#59](https://github.com/codeRIT/hackathon_manager/pull/59))
* Improve email layout with respect to mobile clients ([#60](https://github.com/codeRIT/hackathon_manager/pull/60))
* Add configuration overview to manage backend ([#61](https://github.com/codeRIT/hackathon_manager/pull/61))

# 0.5.6 - 2017-12-23

* Update button style in emails
* Add sass variable for account header background

## 0.5.5 - 2017-12-22

* Fix test factory inclusion from 0.5.4

## 0.5.4 - 2017-12-22

* Include test factories with gem

## 0.5.3 - 2017-12-22

**Note:** Be sure to run `rails railties:install:migrations` and `rails db:migrate` after upgrading.

* Add "Why attend?" question to questionnaire ([#56](https://github.com/codeRIT/hackathon_manager/pull/56))
* Style improvement to checkbox inputs

## 0.5.2 - 2017-12-18

* Minor style and layout improvements

## 0.5.1 - 2017-12-17

* Fix manage dashboard graph colors

## 0.5.0 - 2017-12-14

* Complete redesign of account pages ([#51](https://github.com/codeRIT/hackathon_manager/pull/53))
* Move many CSS constants to easily-configurable variables
* Add missing page titles (`<title>`)
* Make raw page titles available via `content_for :page_title`

## 0.4.4 - 2017-12-12

* Remove unused `config/initializers/static_data.rb`

## 0.4.3 - 2017-12-12

* Add config for bus captain notes ([#53](https://github.com/codeRIT/hackathon_manager/pull/53))
* Fix remaining email_from usage ([#52](https://github.com/codeRIT/hackathon_manager/pull/52))
* Fix fonts on user-facing pages
* Reload config upon hackathon.yml changes ([#49](https://github.com/codeRIT/hackathon_manager/pull/49))

## 0.4.2 - 2017-12-04

* Remove management assets from public-facing pages
* Include public/ in gem distribution (fixes management map)

## 0.4.1 - 2017-12-01

* Link school seeds into `rails db:seed`
* Utilize SASS variables for email template & fix links

## 0.4.0 - 2017-12-01

* Two new configuration options: disclaimer and thank-you message
* Improved form formatting on mobile
* Fixed missing dropdown icons
* Misc improvements

## 0.3.3 - 2017-11-21

* Relax some dependency specs
* Remove unnecessary MLH badge style

## 0.3.2 - 2017-11-16

* Restrict aws-sdk gem to 2.x for proper Paperclip support

## 0.3.1 - 2017-10-28

* Fix dashboard activity map ([#42](https://github.com/codeRIT/hackathon_manager/pull/42))

## 0.3.0 - 2017-10-18

* Use "continue" wording for MyMLH buttons ([#35](https://github.com/codeRIT/hackathon_manager/pull/35))
* Generalize standard email templates ([#38](https://github.com/codeRIT/hackathon_manager/pull/38))
    * **Breaking change:** You must implement your own `app/views/mailer/denied_email.html.erb` template for denial emails to go out. [See an example](https://github.com/codeRIT/hackathon_manager/blob/master/app/views/mailer/denied_email.html.erb).
* Replace hackathon-specific text with configuration ([#40](https://github.com/codeRIT/hackathon_manager/pull/40))
    * **Breaking change:** Be sure to update `app/config/hackathon.yml` with the new variables (see the example [hackathon.yml](https://github.com/codeRIT/hackathon_manager/blob/master/test/dummy/config/hackathon.yml))
* Small wording tweaks & dependency updates

## 0.2.0 - 2017-07-23

* Add ability to login without My MLH

## 0.1.0 - 2017-06-03

* Copied over all application logic, routes, tests, etc from BrickHack repo
* Added `logo` configuration option to `hackathon.yml`
