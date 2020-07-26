---
id: updating-hm
title: Updating HackathonManager
---

We made it easy to update your HackathonManager instance while in production. It's important to always keep your instance up-to-date for new features and improvements.

## Heroku

If you already have a deployment of HackathonManager on Heroku, follow these steps to update it.

> Ensure you have [Heroku CLI](https://devcenter.heroku.com/articles/heroku-cli) installed and you are [authenticated](https://devcenter.heroku.com/articles/heroku-cli#getting-started) before continuing.

```bash
# cd into the directory you have hackathon-manager cloned
cd hackathon-manager
git pull
git push heroku master
```
## Dokku

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
