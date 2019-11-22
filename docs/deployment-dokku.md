---
id: deployment-dokku
title: Dokku Deployment
---

>These docs assume you already have a virtual machine with [Dokku](http://dokku.viewdocs.io/dokku/) running on it, and can SSH into the VM. DNS should be set up as well, but isn't required for bare minimum functionality.
>
>If you need a VM, check out [DigitalOean](https://m.do.co/c/b5ee103e23c3) or [Linode](https://www.linode.com/?r=e90a6fb2a6999fb4ec7b60b1add3e288f97954bf) and the [Dokku docs](http://dokku.viewdocs.io/dokku/) to get started.

## Updating an existing deployment

If you already have a deployment of HackathonManager on Dokku, follow these steps to update it.

* If you already have the hackathon-manager repo cloned locally:
```bash
# cd into the directory you have hackathon-manager cloned
cd hackathon-manager
git pull
# Skip to "git push" if you already added the remote
git remote add dokku dokku@your-host.example.com:hm
git push dokku master
```

* If you don't have it cloned locally:
```bash
git clone git@github.com:codeRIT/hackathon-manager
cd hackathon-manager
git remote add dokku dokku@your-host.example.com:hm
git push dokku master
```

## Setting up a new deployment

Below are steps & notes to deploy HackathonManager on Dokku.

If you have any questions at all, please don't hesitate to reach out to [Stuart](https://github.com/sman591)! This doc is very much a work in progress but we want to keep it as up to date as possible.

## Dokku plugins

Currently used and required Dokku plugins (other than the defaults):

- [MySQL](https://github.com/dokku/dokku-mysql) (data storage)
- [Redis](https://github.com/dokku/dokku-redis) (background jobs + caching)
- [dokku-letsencrypt](https://github.com/dokku/dokku-letsencrypt) (Optional: free, automated SSL certificates)

### Dokku Setup Steps

**We'll be using `hm` as the app name in these steps,** as well as sharing the same `hm` name for both the app, database, and redis name. You're free to use another names.

```bash
dokku apps:create hm
dokku mysql:create hm
dokku mysql:link hm hm
dokku redis:create hm
dokku redis:link hm hm
dokku checks:disable hm worker
dokku config:set hm \ [environment variables]
```

Where `[environment-variables]` is a list of all environment variables:

```bash
# Dokku-specific environment variables
BUILDPACK_URL=https://github.com/heroku/heroku-buildpack-ruby.git \
DOKKU_DEPLOY_HOOKS_PREFIX=/app \
ENVIRONMENT="production" \
# ...remaining general environment variables...
```

_providing a `\` at the end of the line allows you to continue the command onto new lines instead of typing all of the variables in one line_

**See [Environment Variables](deployment-environment-variables.md) for all required environment variables**

Once all configuration is set, add Dokku as a remote & run an initial deploy.

### Initial deploy

First, we have to disable our `CHECKS`. Since our initial deploy won't have a working database, checks will fail and block deploys.

On the server, run:

```bash
dokku checks:disable hm web
```

Then, do a local deploy to Dokku:

```bash
# Run this on your LOCAL machine, NOT on the server
git clone git git@github.com:codeRIT/hackathon_manager
cd hackathon_manager
git remote add dokku dokku@your-host.example.com:hm
git push dokku master
```

You'll be able to easily see the progress of the build and any errors.

Once this succeeds, return back to the server to re-enable our web checks and seed the now-prepared database.

```bash
dokku checks:enable hm web
dokku run hm bin/rails db:seed
```

### Domain setup

1. Set up a new DNS record, either by:
   - CNAME record `apply.your-hackathon.com` to point to `hm.your-dokku-server.com`
   - A (and AAAA if you have IPv6) record `apply.your-hackathon.com` to point to your server's IP Address
2. Attach the domain to the app

```bash
dokku domains:add hm apply.your-hackathon.com
```

3. Setup HTTPS with Let's Encrypt

```bash
dokku config:set --no-restart hm DOKKU_LETSENCRYPT_EMAIL=your-email@example.com
dokku letsencrypt hm
```

### Validating initial deploy

- Deploy should succeed without any red flags in the build log
- Should be able to submit an application on the website & receive an immediate confirmation email

### Promote account to admin

```bash
dokku enter hm web
# Wait for a bash shell to start...
$ bin/rails c
# Wait for the Rails console to start...
User.find_by(email: "your-email@example.com").update_attribute(:role, :admin)
exit
exit
```

## Nginx Config

A few special additions must be made to Dokku's standard nginx configuration.

The two sections

1. Create the directory `/home/dokku/hm/nginx.conf.d/`
2. Add files ending in `.conf` as specified below (`proxy_buffer.conf` for sidekiq, `upload.conf` for resumes)
3. Restart nginx: `dokku nginx:build-config hm`

### Sidekiq

Sidekiq's web UI will throw a 502 Gateway error out of the box on production. To fix this, [increase the nginx buffer size](https://github.com/mperham/sidekiq/issues/3143#issuecomment-248923576).

1. Create `proxy_buffer.conf`
```bash
sudo nano /home/dokku/hm/nginx.conf.d/proxy_buffer.conf
```

2. Copy/paste or type in these contents:
```
# Fix for Sidekiq web console
proxy_buffer_size   128k;
proxy_buffers   4 256k;
proxy_busy_buffers_size   256k;
```

3. Save the file

### Resumes

Support decently-sized resumes.

1. Create `upload.conf`
```bash
sudo nano /home/dokku/hm/nginx.conf.d/upload.conf
```

2. Copy/paste or type in these contents:
```
client_max_body_size 2M;
```

3. Save the file

### Restart Nginx

```bash
dokku nginx:build-config hm
```


## MySQL

### MySQL Timezone Tables (Groupdate)

**Update: Looks like dokku-mysql has timezone information by default, so this shouldn't be necessary anymore.**

In order to support groupdate, timezone tables must be created.

```bash
mysql_tzinfo_to_sql /usr/share/zoneinfo | mysql -u $OPENSHIFT_MYSQL_DB_USERNAME -p mysql
```
