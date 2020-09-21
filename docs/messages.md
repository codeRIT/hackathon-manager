---
id: messages
title: Messages
sidebar_label: Messages
---

Messages (emails) are the primary method of communication with your applicants and attendees. Your organizing team can send messages directly to various segments of your applicants, in addition to automated, continuous messages in response to certain events (e.g. upon accepting or checking-in an applicant).

This takes the place of traditional email list/campaign software by integrating directly with your applicant data and admissions process.

## Types of messages

### Bulk messages

These emails are single-use, "broadcast"-style messages set out to segments (or all) of your applicants.

#### Recipient segments

Multiple recipient groups can be chosen. These include:

* **Status** &mdash; Incomplete, complete, accepted, denied, RSVP'd, etc
* **School** &mdash; Confirmed or accepted students from a given school
* **Bus-list** &mdash; Passengers signed up for a given bus
* **Custom (SQL) lists** &mdash; Custom SQL-based queries built in Blazer

The input supports auto-complete; start typing to search and select.

#### Custom SQL recipients with Blazer

If the pre-built options for recipients don't fit your needs, you can also build your own email list using SQL in the Blazer tool.

>The `user_id` column **must** present in the SQL results for emails to be sent.

1. Open Blazer (http://your-site/blazer)
2. Create a new query (with a name)

Examples:

`SELECT user_id FROM questionnaires WHERE school_id=123`

`SELECT id as user_id FROM users WHERE provider='mlh'`

(additional fields can be included, but won't be used for email purposes)

3. Click "Run" to preview your results, or "Create" to save the query
4. Go back to the message (http://your-site/manage/messages) and select the Blazer query
5. Save the message. On the message detail page, you should see the # of expected recipients.

### Automated messages

Automated emails can also be sent out upon certain events happening. All events and their descriptions are listed at http://your-site/manage/messages, which include:

* **Questionnaire status** &mdash; Upon being accepted, denied, RSVP'd, etc
* **Bust list** &mdash; Becoming a passenger or bus captain

These messages are sent immediatley upon an applicant entering the given state. For example, when a staff member marks someone as "accepted," they will immediately receive any automated messages assocaited with the "Questionnaire Status: Accepted" event.

## Message formatting

Messages support full markdown & HTML.

### Template variables

Message bodies can make use of template variables to help personalize and streamline emails. These include information such as `{{first_name}}` and `{{last_name}}`, URLs such as `{{apply_url}}` and `{{rsvp_url}}`, and logical conditions such as `{{bus_list_exists?}}`. The full list of variables, their explanations, and example values can be found at the bottom of the message edit page.

Templating is powered by [mustache](https://mustache.github.io/mustache.5.html).

Example:

```md
## RSVP Confirmation

Hey {{first_name}},

Thank you for your RSVP to {{hackathon_name}}! We can't wait to see you.

{{#bus_list_exists?}}
You've also signed up for the {{bus_list_name}} bus. Keep an eye out for more information closer to the event for pickup times & locations.
{{/bus_list_exists?}}

Let us know if you have any questions in the meantime.

\- The {{hackathon_name}} Team
```

## Message template

The overall message template is used for all outgoing emails and provides the basic structure & style for your emails. A basic template is included for you by default, but can be customized if you need it.

Visit http://your-site/manage/messages/template for more details.

