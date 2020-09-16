---
id: deployment-environment-variables
title: Environment Variables
---

Various services require environment variables to operate. While they may appear overwhelming, this setup guide aims to alleviate some of the concern. 

> Stuck on an environment variable? codeRIT is here to help! [Send us an email](mailto:engineering@coderit.org) with any questions.

## Required
**The following environment variables are required for HackathonManager to function.**

### Secret keys

```bash
SECRET_KEY_BASE="<randomly generated string>"
DEVISE_SECRET_KEY="<randomly generated string>"
```

You can generate secrets via `bundle exec rake secret`. This "secret" is a 64-byte hexadecimal string (128 characters). You could also generate this with `head -c 64 /dev/urandom | xxd -ps -c 128` if you are on a standard Linux distribution.

### Mailer domain

```bash
HM_DOMAIN_NAME=""
HM_DOMAIN_PROTOCOL=""  # optional, https by default
```

This is needed to allow HackathonManager to send email on behalf of your hackathon's domain.

### Amazon S3 and Resumes

```bash
AWS_BUCKET=""
AWS_ACCESS_KEY_ID=""
AWS_SECRET_ACCESS_KEY=""
AWS_REGION=""
```

Resumes for hackers are stored on [Amazon S3](https://aws.amazon.com/s3/).

### Other providers
If you're using a third-party S3 provider, such as [Minio](https://min.io), also specify the custom endpoint.

```bash
AWS_ENDPOINT="https://your-provider.com"
```

If your provider only works with path-style buckets (`https://your-provider.com/bucket` instead of `https://bucket.your-provider.com`), enforce path-style usage:

```bash
S3_FORCE_PATH_STYLE=true
```

### E-mail

Emails can be sent using [SendGrid](https://sendgrid.com) or traditional SMTP.

#### SendGrid

```bash
SENDGRID_API_KEY=""
```

[SendGrid](https://sendgrid.com) is the recommended email provider, and provides a free plan suitable for most hackathons.

Create a SendGrid API key to get started. During the setup process you will be asked to authenticate your sending domain with SendGrid. For guidance on this process please visit [SendGrid Domain Authentication Support](https://sendgrid.com/docs/ui/account-and-settings/how-to-set-up-domain-authentication/). If you would like to maintain your sending reputation and stay out of the spam folder, we reccomend enabling [SendGrid Link Branding](https://sendgrid.com/docs/ui/account-and-settings/how-to-set-up-link-branding/) when asked during the setup process. 


>During the verification process ensure you have replaced `hello@example.com` with your own domain in your HackathonManager config. SendGrid will deny the email as you are not authenticated to send on behalf of `example.com`.

#### SMTP

>Sending email with SMTP over a personal or school email address (such as Gmail) is **NOT** recommended. Your hackathon may easily send several hundred to a few thousand emails during months leading up to the event, which regular email accounts block and may get reported for spam.
>
>Be sure your SMTP provider is configured appropriately for mass email, and check periodically that emails are being delivered successfully.

```bash
SMTP_ADDRESS="mail.example.com"
SMTP_USER_NAME=""
SMTP_PASSWORD=""
SMTP_PORT=""           # optional, 587 by default
SMTP_AUTHENTICATION="" # optional, "plain" by default
SMTP_STARTTLS_AUTO=""  # optional, "true" by default
```

### Time Zone

>HackathonManager will crash at startup if the time zone isn't valid.
>
>To find your appropriate time zone (e.g. `America/New_York`), see "TZ database name" on [Wikipedia](https://en.wikipedia.org/wiki/List_of_tz_database_time_zones)

```bash
TIME_ZONE="America/Los_Angeles"
```

By default, charts & timestamps will be in UTC.

## Optional

### MyMLH

```bash
MLH_KEY=""
MLH_SECRET=""
```

[MyMLH](https://my.mlh.io/) makes it easy for hackers to quickly onboard themselves into HackathonManager. With MyMLH, hackers can save time by skipping fields in the questionnaire where the answer is already provided on their MyMLH profiles.

1. Create an account at https://my.mlh.io
2. Click "My Apps" in the top navbar
3. Click "Create new app"
4. Fill out the app name & logo
5. For "Redirect URI", fill in https://apply.your-hackathon.com/users/auth/mlh/callback

### Rollbar

```bash
ROLLBAR_ACCESS_TOKEN=""
```

[Rollbar](https://rollbar.com/) captures and notifies of errors in production, and requires a server-side access token.



