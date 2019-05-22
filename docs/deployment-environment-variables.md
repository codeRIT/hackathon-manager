---
id: deployment-environment-variables
title: Environment Variables
---

Various services require environment variables to operate.

**The following environment variables should be present on all deployments.** Below is an example:

```bash
SECRET_KEY_BASE="<randomly generated string>"
DEVISE_SECRET_KEY="<randomly generated string>"
HM_DOMAIN_NAME="apply.example.com"
MLH_KEY="my-mlh-application-id"
MLH_SECRET="my-mlh-secret"
AWS_BUCKET="my-example-bucket"
AWS_ACCESS_KEY_ID="<AWS access key ID>"
AWS_SECRET_ACCESS_KEY="<AWS secret key>"
AWS_REGION="us-east-1"
ROLLBAR_ACCESS_TOKEN="<server-side rollbar token>"
SPARKPOST_API_KEY="<sparkpost api key>"
SPARKPOST_CAMPAIGN_ID="my-hackathon"
```

_Also see [app.json](https://github.com/codeRIT/hackathon_manager/blob/master/app.json)_

### Secret keys

`SECRET_KEY_BASE` and `DEVISE_SECRET_KEY` are required for the app to run. You can generate secrets via `bundle exec rake secret`. This "secret" is a 64-byte hexadecimal string (128 characters). You could also generate this with `head -c 64 /dev/urandom | xxd -ps -c 128` if you are on a standard Linux distribution.

### Mailer domain

```bash
HM_DOMAIN_NAME=""
HM_DOMAIN_PROTOCOL=""  # optional, https by default
```

### Resumes and S3

Resumes are stored locally in development and on S3 in production.

```bash
AWS_BUCKET=""
AWS_ACCESS_KEY_ID=""
AWS_SECRET_ACCESS_KEY=""
AWS_REGION=""
```

If you're using a third-party S3 provider, such as [Minio](https://min.io), also specify the custom endpoint.

```bash
AWS_ENDPOINT="https://your-provider.com"
```

If your provider only works with path-style buckets (`https://your-provider.com/bucket` instead of `https://bucket.your-provider.com`), enforce path-style usage:

```bash
S3_FORCE_PATH_STYLE=true
```

### E-mail

Currently, emails are queued via Sidekiq and then sent by Sparkpost's servers.

Create a Sparkpost API key with **Transmissions: Read/Write** and **Message Events: Read-only** permissions, limited to the production server's IP address. SMTP is _not_ required, as email is sent over the Sparkpost API rather than SMTP.

```bash
SPARKPOST_API_KEY=""
SPARKPOST_CAMPAIGN_ID=""
```

### Rollbar

Rollbar captures and notifies of errors in production, and requires a server-side access token.

```bash
ROLLBAR_ACCESS_TOKEN=""
```

### My MLH

My MLH provides us authentication & initial application information.

1. Create an account at https://my.mlh.io
2. Click "My Apps" in the top navbar
3. Click "Create new app"
4. Fill out the app name & logo
5. For "Redirect URI", fill in https://apply.your-hackathon.com/users/auth/mlh/callback

```bash
MLH_KEY=""
MLH_SECRET=""
```

### Skylight

Skylight provides detailed performance analytics for the app, if you chose to use it.

```bash
SKYLIGHT_AUTHENTICATION=""
```
