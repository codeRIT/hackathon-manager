**Please note 0.x releases are development releases and there will be breaking changes until we hit 1.0. For more information, see [semver](http://semver.org/#how-should-i-deal-with-revisions-in-the-0yz-initial-development-phase).**

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
