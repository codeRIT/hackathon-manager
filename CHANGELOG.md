## [2.0.1](https://github.com/codeRIT/hackathon-manager/compare/v2.0.0...v2.0.1) (2020-10-29)


### Bug Fixes

* Updates several packages for security ([](https://github.com/codeRIT/hackathon-manager/commit/b916de0))

# [1.23.0](https://github.com/codeRIT/hackathon-manager/compare/v1.22.4...v1.23.0) (2020-09-21)


### Bug Fixes

* CodeClimate 2.0 fixes ([#374](https://github.com/codeRIT/hackathon-manager/issues/374)) ([](https://github.com/codeRIT/hackathon-manager/commit/746bbfc))
* Fixes failing test cases from [#242](https://github.com/codeRIT/hackathon-manager/issues/242) ([#364](https://github.com/codeRIT/hackathon-manager/issues/364)) ([](https://github.com/codeRIT/hackathon-manager/commit/113cd61))
* Fixes various Hound issues for 2.0 ([#370](https://github.com/codeRIT/hackathon-manager/issues/370)) ([](https://github.com/codeRIT/hackathon-manager/commit/434cfb3))
* Resolves merge conflicts with 2.0->master ([#372](https://github.com/codeRIT/hackathon-manager/issues/372)) ([](https://github.com/codeRIT/hackathon-manager/commit/eae9926)), closes [#215](https://github.com/codeRIT/hackathon-manager/issues/215) [#215](https://github.com/codeRIT/hackathon-manager/issues/215) [#207](https://github.com/codeRIT/hackathon-manager/issues/207) [#208](https://github.com/codeRIT/hackathon-manager/issues/208) [#212](https://github.com/codeRIT/hackathon-manager/issues/212) [#219](https://github.com/codeRIT/hackathon-manager/issues/219) [#221](https://github.com/codeRIT/hackathon-manager/issues/221) [#236](https://github.com/codeRIT/hackathon-manager/issues/236) [#236](https://github.com/codeRIT/hackathon-manager/issues/236) [#250](https://github.com/codeRIT/hackathon-manager/issues/250) [#268](https://github.com/codeRIT/hackathon-manager/issues/268) [#280](https://github.com/codeRIT/hackathon-manager/issues/280) [#282](https://github.com/codeRIT/hackathon-manager/issues/282) [#298](https://github.com/codeRIT/hackathon-manager/issues/298)
* **config:** Removes disable_account_registration from database ([#247](https://github.com/codeRIT/hackathon-manager/issues/247)) ([](https://github.com/codeRIT/hackathon-manager/commit/82a7ff4))
* **dashboard:** Map data refactored for faster load times ([#269](https://github.com/codeRIT/hackathon-manager/issues/269)) ([](https://github.com/codeRIT/hackathon-manager/commit/03e632c))
* **dashboard:** Switches map to use different geocoder, reenables map ([#224](https://github.com/codeRIT/hackathon-manager/issues/224)) ([](https://github.com/codeRIT/hackathon-manager/commit/30e3a2f))
* **Dashboard:** Fixes missing location data in map ([#324](https://github.com/codeRIT/hackathon-manager/issues/324)) ([](https://github.com/codeRIT/hackathon-manager/commit/388c9bd))
* **deps:** Updates the locked Ruby version ([#340](https://github.com/codeRIT/hackathon-manager/issues/340)) ([](https://github.com/codeRIT/hackathon-manager/commit/e0e537c))
* **docs:** Refactors page titles and makes API pages visible again ([#320](https://github.com/codeRIT/hackathon-manager/issues/320)) ([](https://github.com/codeRIT/hackathon-manager/commit/8617981))
* **questionnaire:** added phone number requirements ([#283](https://github.com/codeRIT/hackathon-manager/issues/283)) ([](https://github.com/codeRIT/hackathon-manager/commit/09167ae))
* Hackathon names now consistently on newline, wrapping is centered ([#358](https://github.com/codeRIT/hackathon-manager/issues/358)) ([](https://github.com/codeRIT/hackathon-manager/commit/2e9379f))
* School text-box dropdown in manage/questionnaires/edit missing background  ([#296](https://github.com/codeRIT/hackathon-manager/issues/296)) ([](https://github.com/codeRIT/hackathon-manager/commit/c9d6658))
* Text centering on application page  ([#361](https://github.com/codeRIT/hackathon-manager/issues/361)) ([](https://github.com/codeRIT/hackathon-manager/commit/0237965))
* **bus_captain:** Alerts admins if a bus captain is removed ([#270](https://github.com/codeRIT/hackathon-manager/issues/270)) ([](https://github.com/codeRIT/hackathon-manager/commit/28913f7))
* Shows manage button for admin_limited_access ([#331](https://github.com/codeRIT/hackathon-manager/issues/331)) ([](https://github.com/codeRIT/hackathon-manager/commit/cb16869))
* **login:** Removes always visible login error ([#263](https://github.com/codeRIT/hackathon-manager/issues/263)) ([](https://github.com/codeRIT/hackathon-manager/commit/513e1c2))
* **questionnaire:** Fixes error when trying to view a questionnaire modified by a deleted admin ([#238](https://github.com/codeRIT/hackathon-manager/issues/238)) ([](https://github.com/codeRIT/hackathon-manager/commit/f07ec28)), closes [#215](https://github.com/codeRIT/hackathon-manager/issues/215) [#215](https://github.com/codeRIT/hackathon-manager/issues/215) [#207](https://github.com/codeRIT/hackathon-manager/issues/207) [#208](https://github.com/codeRIT/hackathon-manager/issues/208) [#212](https://github.com/codeRIT/hackathon-manager/issues/212) [#219](https://github.com/codeRIT/hackathon-manager/issues/219) [#221](https://github.com/codeRIT/hackathon-manager/issues/221)
* **questionnaire:** School autocomplete matches form field width ([#278](https://github.com/codeRIT/hackathon-manager/issues/278)) ([](https://github.com/codeRIT/hackathon-manager/commit/e4169a7))


### Code Refactoring

* `first_name` and `last_name` move from `questionnaire` to `user` ([#241](https://github.com/codeRIT/hackathon-manager/issues/241)) ([](https://github.com/codeRIT/hackathon-manager/commit/6266f5a)), closes [#244](https://github.com/codeRIT/hackathon-manager/issues/244) [#downwith2](https://github.com/codeRIT/hackathon-manager/issues/downwith2) [#222](https://github.com/codeRIT/hackathon-manager/issues/222) [#273](https://github.com/codeRIT/hackathon-manager/issues/273) [#215](https://github.com/codeRIT/hackathon-manager/issues/215) [#215](https://github.com/codeRIT/hackathon-manager/issues/215) [#207](https://github.com/codeRIT/hackathon-manager/issues/207) [#208](https://github.com/codeRIT/hackathon-manager/issues/208) [#212](https://github.com/codeRIT/hackathon-manager/issues/212) [#219](https://github.com/codeRIT/hackathon-manager/issues/219) [#221](https://github.com/codeRIT/hackathon-manager/issues/221) [#236](https://github.com/codeRIT/hackathon-manager/issues/236) [#236](https://github.com/codeRIT/hackathon-manager/issues/236) [#250](https://github.com/codeRIT/hackathon-manager/issues/250) [#268](https://github.com/codeRIT/hackathon-manager/issues/268) [#263](https://github.com/codeRIT/hackathon-manager/issues/263) [#275](https://github.com/codeRIT/hackathon-manager/issues/275) [#235](https://github.com/codeRIT/hackathon-manager/issues/235) [#247](https://github.com/codeRIT/hackathon-manager/issues/247) [#238](https://github.com/codeRIT/hackathon-manager/issues/238) [#215](https://github.com/codeRIT/hackathon-manager/issues/215) [#215](https://github.com/codeRIT/hackathon-manager/issues/215) [#207](https://github.com/codeRIT/hackathon-manager/issues/207) [#208](https://github.com/codeRIT/hackathon-manager/issues/208) [#212](https://github.com/codeRIT/hackathon-manager/issues/212) [#219](https://github.com/codeRIT/hackathon-manager/issues/219) [#221](https://github.com/codeRIT/hackathon-manager/issues/221) [#329](https://github.com/codeRIT/hackathon-manager/issues/329) [#326](https://github.com/codeRIT/hackathon-manager/issues/326) [#324](https://github.com/codeRIT/hackathon-manager/issues/324) [#291](https://github.com/codeRIT/hackathon-manager/issues/291) [#272](https://github.com/codeRIT/hackathon-manager/issues/272) [#278](https://github.com/codeRIT/hackathon-manager/issues/278)
* Adds GSDP info, cleans Dokku docs ([#356](https://github.com/codeRIT/hackathon-manager/issues/356)) ([](https://github.com/codeRIT/hackathon-manager/commit/54d2cea))
* Changes "Applications" to "Questionnaires" in map ([#326](https://github.com/codeRIT/hackathon-manager/issues/326)) ([](https://github.com/codeRIT/hackathon-manager/commit/675b3f6))
* Cleans Questionnaire for MyMLH V3 ([#338](https://github.com/codeRIT/hackathon-manager/issues/338)) ([](https://github.com/codeRIT/hackathon-manager/commit/31b418d))
* Cleans update method in rsvps_controller ([#305](https://github.com/codeRIT/hackathon-manager/issues/305)) ([](https://github.com/codeRIT/hackathon-manager/commit/fe66870))
* Redesigns password reset pages ([#308](https://github.com/codeRIT/hackathon-manager/issues/308)) ([](https://github.com/codeRIT/hackathon-manager/commit/69e8d6e))
* Renames "Guides" to "Docs" ([#353](https://github.com/codeRIT/hackathon-manager/issues/353)) ([](https://github.com/codeRIT/hackathon-manager/commit/12cc746))
* Renames user roles, improves security ([](https://github.com/codeRIT/hackathon-manager/commit/58b5849))
* **config:** Adjusts registration verbiage to always allow user registration ([#232](https://github.com/codeRIT/hackathon-manager/issues/232)) ([](https://github.com/codeRIT/hackathon-manager/commit/1a31861))
* **docs:** Updates Environment Variable docs ([#300](https://github.com/codeRIT/hackathon-manager/issues/300)) ([](https://github.com/codeRIT/hackathon-manager/commit/1599fe1))
* Updates 24hr reminder to remove MyMLH reference ([#302](https://github.com/codeRIT/hackathon-manager/issues/302)) ([](https://github.com/codeRIT/hackathon-manager/commit/9e6fe39))
* **docs:** Updates Messages and customization instructions ([#321](https://github.com/codeRIT/hackathon-manager/issues/321)) ([](https://github.com/codeRIT/hackathon-manager/commit/a767446))
* **questionnaire:** No longer deletes user with questionnaire ([#287](https://github.com/codeRIT/hackathon-manager/issues/287)) ([](https://github.com/codeRIT/hackathon-manager/commit/ac720d9))
* **skylight:** Removes Skylight ([#249](https://github.com/codeRIT/hackathon-manager/issues/249)) ([](https://github.com/codeRIT/hackathon-manager/commit/2808058))


### Documentation

* Add guide for local API setup, update api-usage slightly ([#235](https://github.com/codeRIT/hackathon-manager/issues/235)) ([](https://github.com/codeRIT/hackathon-manager/commit/d1a01f8))
* Migration guide for 2.0 ([#368](https://github.com/codeRIT/hackathon-manager/issues/368)) ([](https://github.com/codeRIT/hackathon-manager/commit/3745d9c)), closes [#283](https://github.com/codeRIT/hackathon-manager/issues/283) [#296](https://github.com/codeRIT/hackathon-manager/issues/296) [#242](https://github.com/codeRIT/hackathon-manager/issues/242) [#364](https://github.com/codeRIT/hackathon-manager/issues/364) [#361](https://github.com/codeRIT/hackathon-manager/issues/361) [#270](https://github.com/codeRIT/hackathon-manager/issues/270) [#175](https://github.com/codeRIT/hackathon-manager/issues/175) [#215](https://github.com/codeRIT/hackathon-manager/issues/215) [#215](https://github.com/codeRIT/hackathon-manager/issues/215) [#207](https://github.com/codeRIT/hackathon-manager/issues/207) [#208](https://github.com/codeRIT/hackathon-manager/issues/208) [#212](https://github.com/codeRIT/hackathon-manager/issues/212) [#358](https://github.com/codeRIT/hackathon-manager/issues/358)


### Features

* Automatically remind people to RSVP ([#175](https://github.com/codeRIT/hackathon-manager/issues/175)) ([](https://github.com/codeRIT/hackathon-manager/commit/d87269d)), closes [#215](https://github.com/codeRIT/hackathon-manager/issues/215) [#215](https://github.com/codeRIT/hackathon-manager/issues/215) [#207](https://github.com/codeRIT/hackathon-manager/issues/207) [#208](https://github.com/codeRIT/hackathon-manager/issues/208) [#212](https://github.com/codeRIT/hackathon-manager/issues/212)
* Creates /user.json get route ([#367](https://github.com/codeRIT/hackathon-manager/issues/367)) ([](https://github.com/codeRIT/hackathon-manager/commit/a9e14f5))
* Updates HackathonManager to 2.0 ([](https://github.com/codeRIT/hackathon-manager/commit/0070cd4))
* **Dashboard:** Redesigns sidebar with category labels ([#290](https://github.com/codeRIT/hackathon-manager/issues/290)) ([](https://github.com/codeRIT/hackathon-manager/commit/abcf634))
* **docs:** Adds new Resources page ([#318](https://github.com/codeRIT/hackathon-manager/issues/318)) ([](https://github.com/codeRIT/hackathon-manager/commit/9c61d1f))
* **docs:** Initial documentation for 2.0 ([#291](https://github.com/codeRIT/hackathon-manager/issues/291)) ([](https://github.com/codeRIT/hackathon-manager/commit/a062140))
* **messages:** Adds a confirmation modal to send messages ([#272](https://github.com/codeRIT/hackathon-manager/issues/272)) ([](https://github.com/codeRIT/hackathon-manager/commit/79831f6))
* **messages:** Transitions from SparkPost to SendGrid ([#285](https://github.com/codeRIT/hackathon-manager/issues/285)) ([](https://github.com/codeRIT/hackathon-manager/commit/5e96a9c))
* **questionnaires:** Allows directors to block new questionnaires ([#279](https://github.com/codeRIT/hackathon-manager/issues/279)) ([](https://github.com/codeRIT/hackathon-manager/commit/5e03082))
* Updates MyMLH to V3 ([#329](https://github.com/codeRIT/hackathon-manager/issues/329)) ([](https://github.com/codeRIT/hackathon-manager/commit/ede300f))
* **users:** Adds ability to view all users and admins ([#216](https://github.com/codeRIT/hackathon-manager/issues/216)) ([](https://github.com/codeRIT/hackathon-manager/commit/c119c9a))

## [1.22.4](https://github.com/codeRIT/hackathon-manager/compare/v1.22.3...v1.22.4) (2020-05-26)

### Bug Fixes

* **questionnaire:** Fixes error when trying to view a questionnaire modified by a deleted admin ([#236](https://github.com/codeRIT/hackathon-manager/issues/236)) ([](https://github.com/codeRIT/hackathon-manager/commit/2ffe116))

## [1.22.3](https://github.com/codeRIT/hackathon-manager/compare/v1.22.2...v1.22.3) (2020-05-16)


### Bug Fixes

* **dashboard:** Fixes security vulnerability that allowed event_tracking role to access Dashboard ([#215](https://github.com/codeRIT/hackathon-manager/issues/215)) ([](https://github.com/codeRIT/hackathon-manager/commit/74a40ad))


### Styles

* **check-in:** Changes table header to be more descriptive ([#207](https://github.com/codeRIT/hackathon-manager/issues/207)) ([](https://github.com/codeRIT/hackathon-manager/commit/889fbd0))
* **config:** Removes unused event_is_over flag ([#208](https://github.com/codeRIT/hackathon-manager/issues/208)) ([](https://github.com/codeRIT/hackathon-manager/commit/0c73e66))

## [1.22.2](https://github.com/codeRIT/hackathon-manager/compare/v1.22.1...v1.22.2) (2020-03-29)


### Bug Fixes

* Fixes label mismatch with dietary restrictions ([#206](https://github.com/codeRIT/hackathon-manager/issues/206)) ([](https://github.com/codeRIT/hackathon-manager/commit/70fdf73))

## [1.22.1](https://github.com/codeRIT/hackathon-manager/compare/v1.22.0...v1.22.1) (2020-02-05)


### Bug Fixes

* **exports:** Ensure enqueue works ([](https://github.com/codeRIT/hackathon-manager/commit/ad2e667))

# [1.22.0](https://github.com/codeRIT/hackathon-manager/compare/v1.21.1...v1.22.0) (2020-02-05)


### Features

* **exports:** Add ability to generate data exports for sponsors ([#199](https://github.com/codeRIT/hackathon-manager/issues/199)) ([](https://github.com/codeRIT/hackathon-manager/commit/70b1336)), closes [#133](https://github.com/codeRIT/hackathon-manager/issues/133)

## [1.21.1](https://github.com/codeRIT/hackathon-manager/compare/v1.21.0...v1.21.1) (2020-02-05)


### Bug Fixes

* **sidekiq:** Upgrade rack to fix Sidekiq admin page error ([](https://github.com/codeRIT/hackathon-manager/commit/958d908))

# [1.21.0](https://github.com/codeRIT/hackathon-manager/compare/v1.20.1...v1.21.0) (2020-01-28)


### Bug Fixes

* **messages:** Side-by-side preview ([](https://github.com/codeRIT/hackathon-manager/commit/0889f67))


### Features

* **messages:** Improve message composing hint for preview ([](https://github.com/codeRIT/hackathon-manager/commit/b19e403))

## [1.20.1](https://github.com/codeRIT/hackathon-manager/compare/v1.20.0...v1.20.1) (2020-01-19)


### Bug Fixes

* Correct timeline in today's activity chart ([](https://github.com/codeRIT/hackathon-manager/commit/e83c423))

# [1.20.0](https://github.com/codeRIT/hackathon-manager/compare/v1.19.3...v1.20.0) (2020-01-19)


### Features

* Add TIME_ZONE environment variable ([](https://github.com/codeRIT/hackathon-manager/commit/5332ba5))

## [1.19.3](https://github.com/codeRIT/hackathon-manager/compare/v1.19.2...v1.19.3) (2019-12-09)


### Bug Fixes

* **rollbar:** Enable error reporting to Rollbar ([](https://github.com/codeRIT/hackathon-manager/commit/11d5750))


### Documentation

* **dokku:** Add notes for updating an existing deployment ([](https://github.com/codeRIT/hackathon-manager/commit/114ce4c))

## [1.19.2](https://github.com/codeRIT/hackathon-manager/compare/v1.19.1...v1.19.2) (2019-10-07)


### Bug Fixes

*  update the gem rubyzip due to security issue reported by Hakiri ([#188](https://github.com/codeRIT/hackathon-manager/issues/188)) ([4fc9057](https://github.com/codeRIT/hackathon-manager/commit/4fc9057))

## [1.19.1](https://github.com/codeRIT/hackathon-manager/compare/v1.19.0...v1.19.1) (2019-10-07)


### Bug Fixes

* position of favicon to be centered for better UX in datatables ([#186](https://github.com/codeRIT/hackathon-manager/issues/186)) ([6e881ba](https://github.com/codeRIT/hackathon-manager/commit/6e881ba))

# [1.19.0](https://github.com/codeRIT/hackathon-manager/compare/v1.18.0...v1.19.0) (2019-10-05)


### Features

* Add ability to close registration completely ([#176](https://github.com/codeRIT/hackathon-manager/issues/176)) ([457781d](https://github.com/codeRIT/hackathon-manager/commit/457781d)), closes [#172](https://github.com/codeRIT/hackathon-manager/issues/172)


### Maintenance

* Code reformat ([123eafc](https://github.com/codeRIT/hackathon-manager/commit/123eafc))


### Tests

* Fix _asset config test ([63f49ec](https://github.com/codeRIT/hackathon-manager/commit/63f49ec))

# [1.18.0](https://github.com/codeRIT/hackathon-manager/compare/v1.17.2...v1.18.0) (2019-08-18)


### Features

* alert if user is redirected when arriving to rsvp ([3b6260a](https://github.com/codeRIT/hackathon-manager/commit/3b6260a))


### Maintenance

* Update gems ([#179](https://github.com/codeRIT/hackathon-manager/issues/179)) ([dc1b039](https://github.com/codeRIT/hackathon-manager/commit/dc1b039))

## [1.17.2](https://github.com/codeRIT/hackathon-manager/compare/v1.17.1...v1.17.2) (2019-07-17)


### Bug Fixes

* Corrects typo in the Bus Captain Notes config description ([#173](https://github.com/codeRIT/hackathon-manager/issues/173)) ([6e4f871](https://github.com/codeRIT/hackathon-manager/commit/6e4f871))

## [1.17.1](https://github.com/codeRIT/hackathon-manager/compare/v1.17.0...v1.17.1) (2019-07-15)


### Bug Fixes

* Correct user_name usage for SMTP mail ([b8e2d2e](https://github.com/codeRIT/hackathon-manager/commit/b8e2d2e))
* Set SMTP username & password as secret ([2b30306](https://github.com/codeRIT/hackathon-manager/commit/2b30306))

# [1.17.0](https://github.com/codeRIT/hackathon-manager/compare/v1.16.0...v1.17.0) (2019-07-14)


### Features

* Support SMTP as an alternative email provider to Sparkpost ([#172](https://github.com/codeRIT/hackathon-manager/issues/172)) ([5904384](https://github.com/codeRIT/hackathon-manager/commit/5904384))

# [1.16.0](https://github.com/codeRIT/hackathon-manager/compare/v1.15.1...v1.16.0) (2019-07-13)


### Bug Fixes

* Capitalization of URL and RSVP config variable names ([4561412](https://github.com/codeRIT/hackathon-manager/commit/4561412))
* Consistent bottom margin on all manage pages ([324d820](https://github.com/codeRIT/hackathon-manager/commit/324d820))
* Don’t load message events when SparkPost API key is blank ([a989d02](https://github.com/codeRIT/hackathon-manager/commit/a989d02))
* Show “not set” for nil config values ([7bb8d4a](https://github.com/codeRIT/hackathon-manager/commit/7bb8d4a))


### Features

* Add link to docs, changelog, bug report on all manage pages ([0429eee](https://github.com/codeRIT/hackathon-manager/commit/0429eee))
* Improve editor for disabled_fields configuration ([9206718](https://github.com/codeRIT/hackathon-manager/commit/9206718))
* Note sensitive config values as hidden when set in UI ([271b49e](https://github.com/codeRIT/hackathon-manager/commit/271b49e))

## [1.15.1](https://github.com/codeRIT/hackathon-manager/compare/v1.15.0...v1.15.1) (2019-06-21)


### Bug Fixes

* MessageTemplate cache expiration ([6d74b53](https://github.com/codeRIT/hackathon-manager/commit/6d74b53))


### Documentation

* **okd:** Add init container for running db:migrate ([484c1c0](https://github.com/codeRIT/hackathon-manager/commit/484c1c0))
* **okd:** Fix consistent sha256 hash example ([0e2d1f1](https://github.com/codeRIT/hackathon-manager/commit/0e2d1f1))
* **readme:** Rename development -> local development ([ceb91f0](https://github.com/codeRIT/hackathon-manager/commit/ceb91f0))

# [1.15.0](https://github.com/codeRIT/hackathon-manager/compare/v1.14.0...v1.15.0) (2019-06-18)


### Deployment

* Upgrade from Ruby 2.6.2 to 2.6.3 ([7448c1d](https://github.com/codeRIT/hackathon-manager/commit/7448c1d))


### Documentation

* **readme:** Improve first step of setting up Ruby + MySQL ([66a9675](https://github.com/codeRIT/hackathon-manager/commit/66a9675))

# [1.14.0](https://github.com/codeRIT/hackathon-manager/compare/v1.13.1...v1.14.0) (2019-06-18)


### Documentation

* **dokku:** Clarify .conf files to create ([1745f00](https://github.com/codeRIT/hackathon-manager/commit/1745f00))
* **dokku:** Clarify steps to edit Nginx files + sudo ([8057801](https://github.com/codeRIT/hackathon-manager/commit/8057801))
* **dokku:** Clear up nginx setup description ([4b20eab](https://github.com/codeRIT/hackathon-manager/commit/4b20eab))


### Features

* Hide MyMLH button if MLH_KEY env var is not set ([#167](https://github.com/codeRIT/hackathon-manager/issues/167)) ([9b81034](https://github.com/codeRIT/hackathon-manager/commit/9b81034))
* Link "home" button to marketing site ([#166](https://github.com/codeRIT/hackathon-manager/issues/166)) ([d65416d](https://github.com/codeRIT/hackathon-manager/commit/d65416d))

## [1.13.1](https://github.com/codeRIT/hackathon-manager/compare/v1.13.0...v1.13.1) (2019-06-05)


### Bug Fixes

* Update gems to include Chartkick security patch ([d0a4796](https://github.com/codeRIT/hackathon-manager/commit/d0a4796))

# [1.13.0](https://github.com/codeRIT/hackathon-manager/compare/v1.12.1...v1.13.0) (2019-06-05)


### Documentation

* **dokku:** Clarify env var setting, nginx conf paths ([ddb8d90](https://github.com/codeRIT/hackathon-manager/commit/ddb8d90))
* Add page on message usage ([0559573](https://github.com/codeRIT/hackathon-manager/commit/0559573))
* Note email & CSS customization options ([56cc11b](https://github.com/codeRIT/hackathon-manager/commit/56cc11b))


### Features

* Add message documentation link ([1e89d3e](https://github.com/codeRIT/hackathon-manager/commit/1e89d3e))

## [1.12.1](https://github.com/codeRIT/hackathon-manager/compare/v1.12.0...v1.12.1) (2019-06-04)


### Bug Fixes

* Patch CSRF vulnerability with omniauth authorization ([80ec947](https://github.com/codeRIT/hackathon-manager/commit/80ec947))

# [1.12.0](https://github.com/codeRIT/hackathon-manager/compare/v1.11.0...v1.12.0) (2019-05-30)


### Code Refactoring

* Consolidate CSS variable usage ([d4e8b70](https://github.com/codeRIT/hackathon-manager/commit/d4e8b70))


### Features

* Interactively customize CSS variables ([#163](https://github.com/codeRIT/hackathon-manager/issues/163)) ([e1da59b](https://github.com/codeRIT/hackathon-manager/commit/e1da59b))

# [1.11.0](https://github.com/codeRIT/hackathon-manager/compare/v1.10.0...v1.11.0) (2019-05-30)


### Features

* Support custom CSS for public pages ([158a996](https://github.com/codeRIT/hackathon-manager/commit/158a996)), closes [#162](https://github.com/codeRIT/hackathon-manager/issues/162)
* Support rich text editing for config variables ([a5b002a](https://github.com/codeRIT/hackathon-manager/commit/a5b002a))

# [1.10.0](https://github.com/codeRIT/hackathon-manager/compare/v1.9.0...v1.10.0) (2019-05-30)


### Documentation

* Add recommendation notes to deployment platform list ([6f732e7](https://github.com/codeRIT/hackathon-manager/commit/6f732e7))
* Clarify prerequisites to deploying on Dokku ([3240c4b](https://github.com/codeRIT/hackathon-manager/commit/3240c4b))


### Features

* Use CSS variables instead of SASS variables ([c6c01f5](https://github.com/codeRIT/hackathon-manager/commit/c6c01f5)), closes [#142](https://github.com/codeRIT/hackathon-manager/issues/142)

# [1.9.0](https://github.com/codeRIT/hackathon-manager/compare/v1.8.0...v1.9.0) (2019-05-30)


### Features

* Better wording for sign-in alert ([1b96e6d](https://github.com/codeRIT/hackathon-manager/commit/1b96e6d))
* Improve My MLH sign-in button ([c914d34](https://github.com/codeRIT/hackathon-manager/commit/c914d34))

# [1.8.0](https://github.com/codeRIT/hackathon-manager/compare/v1.7.0...v1.8.0) (2019-05-29)


### Features

* Alert confirmation after promoting/removing a bus captain ([abc034d](https://github.com/codeRIT/hackathon-manager/commit/abc034d))
* Clean up datatables ([6c062c5](https://github.com/codeRIT/hackathon-manager/commit/6c062c5))


### Performance Improvements

* Speed up questionnaire datatable ([14643c0](https://github.com/codeRIT/hackathon-manager/commit/14643c0))

# [1.7.0](https://github.com/codeRIT/hackathon-manager/compare/v1.6.0...v1.7.0) (2019-05-29)


### Features

* Add ability to mark a school as a home school ([86cad60](https://github.com/codeRIT/hackathon-manager/commit/86cad60)), closes [#157](https://github.com/codeRIT/hackathon-manager/issues/157)
* Always show interested bus captains table ([e0142d9](https://github.com/codeRIT/hackathon-manager/commit/e0142d9))
* Rename RIT/non-RIT to Home/Away ([3d1d1c1](https://github.com/codeRIT/hackathon-manager/commit/3d1d1c1)), closes [#157](https://github.com/codeRIT/hackathon-manager/issues/157)
* Use interactive table on bus list passengers ([90f3b7b](https://github.com/codeRIT/hackathon-manager/commit/90f3b7b))
* Use interactive table on school questionnaires list ([7364223](https://github.com/codeRIT/hackathon-manager/commit/7364223))


### Maintenance

* Remove unused coffeescript gem ([556ac98](https://github.com/codeRIT/hackathon-manager/commit/556ac98))
* Update gems ([342dce7](https://github.com/codeRIT/hackathon-manager/commit/342dce7))
* Upgrade to ajax-datatables-rails 1.x ([3c2d6d3](https://github.com/codeRIT/hackathon-manager/commit/3c2d6d3))

# [1.6.0](https://github.com/codeRIT/hackathon-manager/compare/v1.5.0...v1.6.0) (2019-05-29)


### Features

* Enable per-column filtering ([f1008e7](https://github.com/codeRIT/hackathon-manager/commit/f1008e7)), closes [#109](https://github.com/codeRIT/hackathon-manager/issues/109)

# [1.5.0](https://github.com/codeRIT/hackathon-manager/compare/v1.4.0...v1.5.0) (2019-05-29)


### Features

* Track history of model changes ([#161](https://github.com/codeRIT/hackathon-manager/issues/161)) ([4c62bd3](https://github.com/codeRIT/hackathon-manager/commit/4c62bd3))

# [1.4.0](https://github.com/codeRIT/hackathon-manager/compare/v1.3.0...v1.4.0) (2019-05-29)


### Bug Fixes

* Close <small> tag in datetime helper ([456b26a](https://github.com/codeRIT/hackathon-manager/commit/456b26a))


### Features

* Use email as fallback for User.full_name ([80e06eb](https://github.com/codeRIT/hackathon-manager/commit/80e06eb))


### Tests

* Add watch test/helpers/ dir for Guard ([a50e9db](https://github.com/codeRIT/hackathon-manager/commit/a50e9db))
* Remove unused helper tests ([87ba1d2](https://github.com/codeRIT/hackathon-manager/commit/87ba1d2))

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
