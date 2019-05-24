---
id: deployment-heroku
title: Heroku Deployment
---

Heroku deployment is pretty straightforward thanks to Heroku's one-click deploys.

Click the button below to start. You'll be prompted to fill out a few questions and environment variables.

**See [Environment Variables](deployment-environment-variables.md) for all required environment variables**

[![Deploy](https://www.herokucdn.com/deploy/button.svg)](https://heroku.com/deploy?template=https://github.com/codeRIT/hackathon-manager)

### Validating initial deploy

- Website should be accessible
- Should be able to submit an application on the website & receive an immediate confirmation email

### Promote account to admin

1. Open a Heroku shell with `bin/rails c` (short for `bin/rails console`)

2. Once the Rails shell opens, run the following:

```bash
User.find_by(email: "your-email@example.com").update_attribute(:role, :admin)
exit
```
