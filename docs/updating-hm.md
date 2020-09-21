---
id: updating-hm
title: Updating HackathonManager
---

We made it easy to update HackathonManager while in production. It's important to always keep HackathonManager up-to-date for new features and improvements.

## Heroku

If a deployment of HackathonManager already exists on Heroku, follow these steps to update it.

> Ensure [Heroku CLI](https://devcenter.heroku.com/articles/heroku-cli) is installed locally and is [authenticated](https://devcenter.heroku.com/articles/heroku-cli#getting-started) with an account permitted to push to the Heroku instance before continuing.

```bash
# cd into the directory where hackathon-manager is cloned into
cd hackathon-manager
git pull
git push heroku master
```
## Dokku

If a deployment of HackathonManager already exists on Dokku, follow these steps to update it.

* If HackathonManager is **already** cloned locally:
```bash
# cd into the directory where hackathon-manager is cloned into
cd hackathon-manager
git pull
# Skip to "git push" if remote is already added
git remote add dokku dokku@your-host.example.com:hm
git push dokku master
```

* If HackathonManager is **not yet** cloned locally:
```bash
git clone git@github.com:codeRIT/hackathon-manager
cd hackathon-manager
git remote add dokku dokku@your-host.example.com:hm
git push dokku master
```
