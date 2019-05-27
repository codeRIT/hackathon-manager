# [1.3.0](https://github.com/codeRIT/hackathon-manager/compare/v1.2.0...v1.3.0) (2019-05-27)


### Code Refactoring

* Mailer -> UserMailer ([a77aa96](https://github.com/codeRIT/hackathon-manager/commit/a77aa96))


### Features

* Implement weekly email report ([c4df212](https://github.com/codeRIT/hackathon-manager/commit/c4df212)), closes [#80](https://github.com/codeRIT/hackathon-manager/issues/80)


### Tests

* Improve MessageTemplateTest reliability ([a3fcb88](https://github.com/codeRIT/hackathon-manager/commit/a3fcb88))

# [1.2.0](https://github.com/codeRIT/hackathon-manager/compare/v1.1.0...v1.2.0) (2019-05-25)


### Deployment

* Upgrade Ruby from 2.6.1 to 2.6.2 ([5401144](https://github.com/codeRIT/hackathon-manager/commit/5401144))


### Documentation

* Add deploy to Heroku button on README and homepage ([4279f3f](https://github.com/codeRIT/hackathon-manager/commit/4279f3f)), closes [#158](https://github.com/codeRIT/hackathon-manager/issues/158)
* Fit project title on one line on small devices ([eff8cc5](https://github.com/codeRIT/hackathon-manager/commit/eff8cc5))
* Update links & add logo to app.json ([32f2dad](https://github.com/codeRIT/hackathon-manager/commit/32f2dad))
* **heroku:** Clarify AWS_REGION env var ([e35ca69](https://github.com/codeRIT/hackathon-manager/commit/e35ca69))
* **heroku:** Make AWS_ENDPOINT not a required env var ([b9ac1d6](https://github.com/codeRIT/hackathon-manager/commit/b9ac1d6))
* **okd:** Add post-installation steps ([ef885a7](https://github.com/codeRIT/hackathon-manager/commit/ef885a7))

## 1.1.0 (2019-05-23)

* feat: Add links to documentation on management pages ([673af0f](https://github.com/codeRIT/hackathon-manager/commit/673af0f))
* docs: Add 1.0.0 release to changelog ([efd6d20](https://github.com/codeRIT/hackathon-manager/commit/efd6d20))

# [1.0.0](https://github.com/codeRIT/hackathon-manager/compare/v0.14.1...v1.0.0) (2019-05-23)


### Breaking Changes

* 1.0 standalone app release ([5c081ce](https://github.com/codeRIT/hackathon-manager/commit/5c081ce))


### Bug Fixes

* Display login error messages ([978d6d3](https://github.com/codeRIT/hackathon-manager/commit/978d6d3)), closes [#28](https://github.com/codeRIT/hackathon-manager/issues/28)
* Fall back to DATABASE_URL if BLAZER_ isn't set ([b93763e](https://github.com/codeRIT/hackathon-manager/commit/b93763e))
* Fix message form UI controls ([4ea9e09](https://github.com/codeRIT/hackathon-manager/commit/4ea9e09)), closes [#146](https://github.com/codeRIT/hackathon-manager/issues/146)
* Hide empty disclaimer message on register page ([b176891](https://github.com/codeRIT/hackathon-manager/commit/b176891))
* Include admins in everyone message recipient ([8ac979f](https://github.com/codeRIT/hackathon-manager/commit/8ac979f)), closes [#145](https://github.com/codeRIT/hackathon-manager/issues/145)
* Only use S3 storage when AWS_ACCESS_KEY_ID is present ([7d40baa](https://github.com/codeRIT/hackathon-manager/commit/7d40baa))
* Remove hard-coded debug flashes ([faf2a9a](https://github.com/codeRIT/hackathon-manager/commit/faf2a9a))
* Restore ajax calls with CSRF protection ([b42cfea](https://github.com/codeRIT/hackathon-manager/commit/b42cfea))
* Selectize style on message form ([a869445](https://github.com/codeRIT/hackathon-manager/commit/a869445))
* Usage of HackathonConfig values in initializers ([c0f5403](https://github.com/codeRIT/hackathon-manager/commit/c0f5403))


### Code Refactoring

* Migrate from Paperclip to ActiveStorage ([#152](https://github.com/codeRIT/hackathon-manager/issues/152)) ([6a956aa](https://github.com/codeRIT/hackathon-manager/commit/6a956aa))
* Migrate from Sidekiq workers to ActiveJob jobs ([#153](https://github.com/codeRIT/hackathon-manager/issues/153)) ([cb0aa16](https://github.com/codeRIT/hackathon-manager/commit/cb0aa16)), closes [#26](https://github.com/codeRIT/hackathon-manager/issues/26)
* Standardize on flash[:alert] instead of flash[:error] ([6231f6b](https://github.com/codeRIT/hackathon-manager/commit/6231f6b))


### Deployment

* **dokku:** Add CHECKS file ([8366716](https://github.com/codeRIT/hackathon-manager/commit/8366716))
* **dokku:** Scale worker process from 0 -> 1 ([3941567](https://github.com/codeRIT/hackathon-manager/commit/3941567))
* **dokku:** Tweak checks schedule ([88f4bca](https://github.com/codeRIT/hackathon-manager/commit/88f4bca))
* **heroku:** Add db:migrate step to release phase ([d22f9aa](https://github.com/codeRIT/hackathon-manager/commit/d22f9aa))


### Documentation

* Add documentation section ([c9419f6](https://github.com/codeRIT/hackathon-manager/commit/c9419f6))
* Add notes on usage + deployment platforms ([2da8d33](https://github.com/codeRIT/hackathon-manager/commit/2da8d33))
* Move to dedicated documentation site ([#155](https://github.com/codeRIT/hackathon-manager/issues/155)) ([fa45732](https://github.com/codeRIT/hackathon-manager/commit/fa45732))
* Rename hackathon_manager to hackathon-manager ([4ddbe56](https://github.com/codeRIT/hackathon-manager/commit/4ddbe56))


### Features

* Add ability to deactivate accounts ([bd934a5](https://github.com/codeRIT/hackathon-manager/commit/bd934a5)), closes [#129](https://github.com/codeRIT/hackathon-manager/issues/129)
* Configure remaining automated emails from UI ([#148](https://github.com/codeRIT/hackathon-manager/issues/148)) ([c79b76d](https://github.com/codeRIT/hackathon-manager/commit/c79b76d))
* Enable template variables in messages ([#143](https://github.com/codeRIT/hackathon-manager/issues/143)) ([a3927dc](https://github.com/codeRIT/hackathon-manager/commit/a3927dc)), closes [#139](https://github.com/codeRIT/hackathon-manager/issues/139)
* Enable UI-customizable message layout ([#156](https://github.com/codeRIT/hackathon-manager/issues/156)) ([3c760d0](https://github.com/codeRIT/hackathon-manager/commit/3c760d0)), closes [#140](https://github.com/codeRIT/hackathon-manager/issues/140)
* Support third-party S3 providers ([61b9f83](https://github.com/codeRIT/hackathon-manager/commit/61b9f83)), closes [#151](https://github.com/codeRIT/hackathon-manager/issues/151)


### Improvements

* Add button style for emails ([88a70ee](https://github.com/codeRIT/hackathon-manager/commit/88a70ee))
* Add image preview, links to config page ([c0dce7b](https://github.com/codeRIT/hackathon-manager/commit/c0dce7b))
* Add remaining environment variables to config screen ([3dddf96](https://github.com/codeRIT/hackathon-manager/commit/3dddf96))
* Better listing display of environment var config ([#150](https://github.com/codeRIT/hackathon-manager/issues/150)) ([42a9250](https://github.com/codeRIT/hackathon-manager/commit/42a9250))
* Separate info from error flash notices ([#149](https://github.com/codeRIT/hackathon-manager/issues/149)) ([d00dc28](https://github.com/codeRIT/hackathon-manager/commit/d00dc28))


# 0.14.1 - 2019-03-03

- Fix: Date of birth parsing with new config

# 0.14.0 - 2019-03-03

**Breaking change:** Be sure to manually migrate existing configuration from `hackathon.yml` to the config UI at `https://your-app.com/manage/configs`

- Feature: Move configuration from `hackathon.yml` to web UI

# 0.13.12 - 2019-03-03

- Improvement: Reformat manage questionnaire form
- Improvement: Add boarded_bus param to manage questionnaire form
- Improvement: Add checked in count to school detail page

# 0.13.11 - 2019-02-16

- Improvement: Show check-in & boarded numbers on bus list page
- Improvement: Show check-in & bus boarding activity on dashboard

# 0.13.10 - 2019-02-15

- Improvement: RSVP confirmation messages
- Fix: Captains spelling

# 0.13.9 - 2019-02-15

- Improvement: Add charts to school page
- Improvement: Sort trackable tags alphabeticaly
- Fix: Graph columns on dashboard

# 0.13.8 - 2019-02-15

- Fix: Delete trackable events when a tag is destroyed

# 0.13.6 - 2019-02-13

**Note:** Be sure to run `rails railties:install:migrations` and `rails db:migrate` after upgrading.

- Feature: Add ability to block tag events with duplicate band IDs
- Feature: Add checkins page

# 0.13.5 - 2019-02-11

- Fix: Ability to get off a bus
- Improvement: Sort bus captains to top of passenger list & visually separate them

# 0.13.4 - 2019-01-29

- Fix: Improve bus list sign-up logic
- Improvement: Label bus list as full on RSVP page when necessary
- Improvement: Clean up questionnaires when they RSVP
- Improvement: Enable OAuth refresh tokens

# 0.13.3 - 2019-01-29

- Improve stats display for schools on a bus list

# 0.13.2 - 2019-01-24

**Note:** Be sure to run `rails railties:install:migrations` and `rails db:migrate` after upgrading.

- Prompt for confirmation when applying bulk questionnaire action
- Enable creating questionnaires for existing users, improve uniqueness validation
- Set maximum character length on dietary & special needs inputs
- Convert questionnaire dietary/special needs to text

# 0.13.1 - 2019-01-22

- Improvement: Enable event tracking users read access to trackable tags
- Improvement: Enable event tracking users to view dashboard

# 0.13.0 - 2019-01-18

**Note:** Be sure to run `rails railties:install:migrations` and `rails db:migrate` after upgrading.

- Feature: Add "event tracking" role
- Improvement: Filter TrackableEvents by trackable_event_id
- Improvement: Add registered date to admin datatable
- Improvement: Hide map until it's fixed

# 0.12.2 - 2019-01-16

- Improvement: Show boarded bus count on bus list

# 0.12.1 - 2019-01-16

- Improvement: Note bus attendance + captain status in questionnaire table
- Improvement: Bus info for questionnaire management
- Fix: Bus list stats

# 0.12.0 - 2019-01-16

**Note:** Be sure to run `rails railties:install:migrations` and `rails db:migrate` after upgrading.

- Improvement: Enable anyone to sign up for any bus

# 0.11.2 - 2019-01-14

- Improvement: Render JSON errors on validation failure

# 0.11.1 - 2019-01-13

- Improvement: Add buttons to quickly build bus list, school messages
- Improvement: Filter events list by user or band ID
- Cleanup: Remove "invite to slack" feature
- Cleanup: Remove carpool link env variable

# 0.11.0 - 2019-01-09

**Note:** Be sure to run `rails railties:install:migrations` and `rails db:migrate` after upgrading.

- Feature: Trackable tags + events! Coupled with the JSON API and a mobile app, this makes it easy to collect RFID tagging over time.

# 0.10.2 - 2019-01-06

- Fix: Redirect after merging two schools
- Feature: Add mobile nav
- Improvement: Add GUI for editing message body markdown w/fullscreen support
- Improvement: Make key information stand out in messages table
- Improvement: Re-order 18-year-old compliance check to top of list
- Improvement: Better dashboard chart logic for incomplete data states
- Improvement: Separate "MLH Info" table into two "applied" and "checked in" tables

# 0.10.1 - 2019-01-04

- Improvement: Add support for JSON APIs on management controllers

# 0.10.0 - 2019-01-02

**Note:** Be sure to run `rails railties:install:migrations` and `rails db:migrate` after upgrading.

- Feature: Support OAuth2 integrations for API-level access to hackathon manager routes, powered by [doorkeeper](https://github.com/doorkeeper-gem/doorkeeper)

# 0.9.2 - 2018-11-26

- Fix: Left-align text in emails instead of justify

# 0.9.1 - 2018-11-25

- Fix: Send application confirmation email to new applicants

# 0.9.0 - 2018-11-25

**Note:** Be sure to run `rails railties:install:migrations` and `rails db:migrate` after upgrading.

- Feature: Add graduation year, race/ethnicity questions to questionnaire
- Improvement: Increase email preview & textarea heights
- Improvement: Bold titles in admin tables for better readability

# 0.8.2 - 2018-11-25

- Improvement: Update MLH policy disclaimer

# 0.8.1 - 2018-10-26

- Fix: Default mailer template

# 0.8.0 - 2018-10-25

**Critical Breaking Change**

Old templates in `app/views/mailers` **must** be manually migrated into the new management UI. The existing automated emails will no longer function.

For each of these templates, create a new "Automated" message at `https://your-website.com/manage/messages`, set the appropriate trigger event, and copy their content over. Be sure to convert any Ruby/ERB code to static HTML as it is no longer supported.

- app/views/mailer/application_confirmation_email.html.erb
- app/views/mailer/denied_email.html.erb
- app/views/mailer/rsvp_confirmation_email.html.erb
- app/views/mailer/accepted_email.html.erb

Release notes:

**Note:** Be sure to run `rails railties:install:migrations` and `rails db:migrate` after upgrading.

- Feature: Consolidated most automated emails into the management UI
- Feature: Show side-by-side preview of message when editing
- Feature: Provide real default email template ([leemunroe/responsive-html-email-template](https://github.com/leemunroe/responsive-html-email-template))
- Improvement: Cleaned up how automated & bulk emails are explained in the UI
- Improvement: Improve nav & layout for mobile
- Improvement: Better flag applicants w/dietary or special needs
- Improvement: Add dietary & special needs to questionnaires table
- Maintenance: Upgrade to Ruby 2.5.2, update gems

# 0.7.1 - 2018-07-29

- Fix: Support Rails 5.1+ migrations

# 0.7.0 - 2018-07-29

**Note:** Be sure to run `rails railties:install:migrations` and `rails db:migrate` after upgrading.

- Feature: New management UI based on Bootstrap (public UI remains the same)
- Feature: Add optional `favicon_asset` configuration option to `hackathon.yml`
- Improvement: Support omniauth lookup by email instead of UID
- Improvement: Update gems & Ruby support
- Fix: Require bus list capacity to be set
- Fix: FIPS code fetching
- Fix: Remove email column from questionnaires table

# 0.6.6 - 2018-02-02

- Feature: Send email to recipients from Blazer query
- Improvement: Copy MLH dropdown defaults for gender & level of study questions

# 0.6.5 - 2018-01-31

- Improvement: Set transactional SparkPost option on select emails
- Fix: Don't retry SparkPost generation rejections

# 0.6.4 - 2018-01-30

- Improvement: Include resume & school name in sponsor info export

# 0.6.3 - 2018-01-26

**Note:** Be sure to run `rails railties:install:migrations` and `rails db:migrate` after upgrading.

- Feature: Allow bus captains to mark who boards a bus
- Feature: Add optional columns to questionnaire datatable
- Feature: Show duplicate name mappings on school detail page
- Fix: Fix admin form for questionnaires

# 0.6.2 - 2018-01-25

- Feature: Notice when updating individual acceptance status
- Feature: Add school name to MLH info
- Fix: Fix sending of triggered emails to correct recipient

# 0.6.1 - 2018-01-22

**Note:** Be sure to add `event_start_date` to hackathon.yml

- Feature: Display notice for applicants under 18 years old
- Fix: Allow entry of birth dates up to 5 years ago
- Fix: Support viewing of messages with invalid recipients

# 0.6.0 - 2018-01-17

**Note:** Be sure to run `rails railties:install:migrations` and `rails db:migrate` after upgrading.

- **Major refactor to bulk email messaging**
- Feature: Automatically send emails upon triggered events
- Feature: Support message recipients from any school and bus list
- Feature: Display what acceptance statuses cause automatic emails
- Fix: Raise error upon reaching unknown recipient query

# 0.5.11 - 2018-01-15

**Note:** Be sure to run `rails railties:install:migrations` and `rails db:migrate` after upgrading.

- Consolidate display of email events
- Make acceptance status searchable in questionnaire table
- Improve error message for agreement checkboxes
- Improve descriptin of how Slack invitations work
- Add delivery date to message table
- Set default questionnaire_count on schools

# 0.5.10 - 2018-01-13

**Note:** Be sure to migrate environment variable `INVITE_TO_SLACK_WHEN_ACCEPTED` to `INVITE_TO_SLACK_UPON_RSVP` if in use.

- Give visual feedback to RSVP updates
- Display recipient count on message overview page
- Don't send Slack invite until user has RSVP'd
- Fix query for non-checked-in, accepted or RSVP’d recipients
- Fix display of denied status
- Fix duplicate display of notice banners

# 0.5.9 - 2018-01-10

- Provide config for post-RSVP confirmation message
- Make why_attend question optional
- Match radio inputs to form styles

# 0.5.8 - 2018-01-08

- Support html in `flash[:notice]`
- Don't send application reminder email to admins
- Queue incomplete reminder email more reliably
- Add support for variable slack subdomain
- Enable Devise :timeoutable for user
- Fix unexpected mail job errors

# 0.5.7 - 2018-01-06

- Use consistent flash support on all pages ([#59](https://github.com/codeRIT/hackathon_manager/pull/59))
- Improve email layout with respect to mobile clients ([#60](https://github.com/codeRIT/hackathon_manager/pull/60))
- Add configuration overview to manage backend ([#61](https://github.com/codeRIT/hackathon_manager/pull/61))

# 0.5.6 - 2017-12-23

- Update button style in emails
- Add sass variable for account header background

## 0.5.5 - 2017-12-22

- Fix test factory inclusion from 0.5.4

## 0.5.4 - 2017-12-22

- Include test factories with gem

## 0.5.3 - 2017-12-22

**Note:** Be sure to run `rails railties:install:migrations` and `rails db:migrate` after upgrading.

- Add "Why attend?" question to questionnaire ([#56](https://github.com/codeRIT/hackathon_manager/pull/56))
- Style improvement to checkbox inputs

## 0.5.2 - 2017-12-18

- Minor style and layout improvements

## 0.5.1 - 2017-12-17

- Fix manage dashboard graph colors

## 0.5.0 - 2017-12-14

- Complete redesign of account pages ([#51](https://github.com/codeRIT/hackathon_manager/pull/53))
- Move many CSS constants to easily-configurable variables
- Add missing page titles (`<title>`)
- Make raw page titles available via `content_for :page_title`

## 0.4.4 - 2017-12-12

- Remove unused `config/initializers/static_data.rb`

## 0.4.3 - 2017-12-12

- Add config for bus captain notes ([#53](https://github.com/codeRIT/hackathon_manager/pull/53))
- Fix remaining email_from usage ([#52](https://github.com/codeRIT/hackathon_manager/pull/52))
- Fix fonts on user-facing pages
- Reload config upon hackathon.yml changes ([#49](https://github.com/codeRIT/hackathon_manager/pull/49))

## 0.4.2 - 2017-12-04

- Remove management assets from public-facing pages
- Include public/ in gem distribution (fixes management map)

## 0.4.1 - 2017-12-01

- Link school seeds into `rails db:seed`
- Utilize SASS variables for email template & fix links

## 0.4.0 - 2017-12-01

- Two new configuration options: disclaimer and thank-you message
- Improved form formatting on mobile
- Fixed missing dropdown icons
- Misc improvements

## 0.3.3 - 2017-11-21

- Relax some dependency specs
- Remove unnecessary MLH badge style

## 0.3.2 - 2017-11-16

- Restrict aws-sdk gem to 2.x for proper Paperclip support

## 0.3.1 - 2017-10-28

- Fix dashboard activity map ([#42](https://github.com/codeRIT/hackathon_manager/pull/42))

## 0.3.0 - 2017-10-18

- Use "continue" wording for MyMLH buttons ([#35](https://github.com/codeRIT/hackathon_manager/pull/35))
- Generalize standard email templates ([#38](https://github.com/codeRIT/hackathon_manager/pull/38))
  - **Breaking change:** You must implement your own `app/views/mailer/denied_email.html.erb` template for denial emails to go out. [See an example](https://github.com/codeRIT/hackathon_manager/blob/master/app/views/mailer/denied_email.html.erb).
- Replace hackathon-specific text with configuration ([#40](https://github.com/codeRIT/hackathon_manager/pull/40))
  - **Breaking change:** Be sure to update `app/config/hackathon.yml` with the new variables (see the example [hackathon.yml](https://github.com/codeRIT/hackathon_manager/blob/master/test/dummy/config/hackathon.yml))
- Small wording tweaks & dependency updates

## 0.2.0 - 2017-07-23

- Add ability to login without My MLH

## 0.1.0 - 2017-06-03

- Copied over all application logic, routes, tests, etc from BrickHack repo
- Added `logo` configuration option to `hackathon.yml`
