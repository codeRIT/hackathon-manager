---
id: api-usage
title: API Usage
---

Almost all of the functionality exposed to users can also be accessed as an API with OAuth credentials. This includes both public- and management-facing functionality.

**Please note:** HackathonManager's primary audience is the web interface.

While functionality may co-exist for both browser and API usage, API-style support might be a little rough around some edges. If you stumble upon something that works a little different than usual (e.g. returns HTML instead of JSON), open an issue and we can figure it out.

## Endpoints

Endpoints are shared with regular page controllers for browser-style functionality. This leverages Ruby on Rails routing (for a deep dive, see [Rails Routing from the Outside In](https://guides.rubyonrails.org/routing.html)).

For example, listing bus lists:

- User-facing page: https://apply.brickhack.io/manage/bus_lists
- API endpoint: https://apply.brickhack.io/manage/bus_lists.json

Because Rails follows a standard CRUD-format, these endpoints become very REST-like.

For example:

- List all tags: `GET https://apply.brickhack.io/manage/trackable_tags.json`
- View specific tag: `GET https://apply.brickhack.io/manage/trackable_tags/1.json`
- Create tag: `POST https://apply.brickhack.io/manage/trackable_tags.json` (with a JSON body of parameters)
- Update tag: `PATCH https://apply.brickhack.io/manage/trackable_tags/1.json` (with a JSON body of parameters)
- Delete tag: `DELETE https://apply.brickhack.io/manage/trackable_tags/1.json`

For a full list of endpoints, run `bin/rails routes` locally. This utility, provided by Ruby on Rails, lists all possible paths you can route too (along with their respective HTTP method).

**Note: datatable endpoints** are highly coupled to [Datatables](https://datatables.net) functionality and are not easy to use.

Example for questionnaire management endpoints:

```
...
                                Prefix Verb     URI Pattern                                              Controller#Action
       datatable_manage_questionnaires POST     /manage/questionnaires/datatable(.:format)               manage/questionnaires#datatable
         check_in_manage_questionnaire PATCH    /manage/questionnaires/:id/check_in(.:format)            manage/questionnaires#check_in
 convert_to_admin_manage_questionnaire PATCH    /manage/questionnaires/:id/convert_to_admin(.:format)    manage/questionnaires#convert_to_admin
update_acc_status_manage_questionnaire PATCH    /manage/questionnaires/:id/update_acc_status(.:format)   manage/questionnaires#update_acc_status
      bulk_apply_manage_questionnaires PATCH    /manage/questionnaires/bulk_apply(.:format)              manage/questionnaires#bulk_apply
   message_events_manage_questionnaire GET      /manage/questionnaires/:id/message_events(.:format)      manage/questionnaires#message_events
                 manage_questionnaires GET      /manage/questionnaires(.:format)                         manage/questionnaires#index
                                       POST     /manage/questionnaires(.:format)                         manage/questionnaires#create
              new_manage_questionnaire GET      /manage/questionnaires/new(.:format)                     manage/questionnaires#new
             edit_manage_questionnaire GET      /manage/questionnaires/:id/edit(.:format)                manage/questionnaires#edit
                  manage_questionnaire GET      /manage/questionnaires/:id(.:format)                     manage/questionnaires#show
                                       PATCH    /manage/questionnaires/:id(.:format)                     manage/questionnaires#update
                                       PUT      /manage/questionnaires/:id(.:format)                     manage/questionnaires#update
                                       DELETE   /manage/questionnaires/:id(.:format)                     manage/questionnaires#destroy
             datatable_manage_checkins POST     /manage/checkins/datatable(.:format)
...
```

## Request & response

Most endpoints can operate with JSON requests & responses. Simply provide `.json` at the end of the URL to be returned JSON, and provide `Content-Type: application/json` when using POST or PATCH with a JSON body.

Note that while most endpoints support JSON responses, some do not have this support. Redirect responses are common for some actions, for which you'll receive a 302 redirect response and no JSON body.

The best way to see what's expected is to look at the controller source code, located at [`app/controllers/`](https://github.com/codeRIT/hackathon_manager/tree/master/app/controllers). Here, you'll see how each endpoint is configured; this maps to the routes listed by `bin/rails routes`. For example:

```ruby
def show
  respond_with(:manage, @questionnaire)
end
```

- This "show" endpoint is the natural mapping for something like `GET /manage/questionnaires/1.json`
- Because `respond_with` is used, it will return JSON when `.json` is used in the URL

# Authentication

Authentication is implemented with OAauth 2, provided by the [Doorkeeper](https://github.com/doorkeeper-gem/doorkeeper) gem.

An OAuth app should be created by an admin at https://apply.your-hackathon.com/oauth/applications. From there, you can implement a standard OAuth 2 flow.

For Doorkeeper endpoints + docs, see https://github.com/doorkeeper-gem/doorkeeper/wiki/API-endpoint-descriptions-and-examples

Once appropriate authentication credentials are retrieved, they should be provided on all API requests.

### Security note

For a mobile- or front-end app, or any app that has API calls running on the client, you should **not** use an authorization flow involving the application secret; otherwise, you would be distributing the secret to the public, compromising the whitelist nature of controlling which apps may pose as your users.

For most use cases, the **authorization code grant** or **implicit grant** flows should be used. Check out [this guide by Auth0](https://auth0.com/docs/api-auth/which-oauth-flow-to-use) for more info.
