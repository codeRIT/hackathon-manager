---
id: deployment
title: Deployment
---

HackathonManager is a standalone web app separate from your regular marketing website/public homepage.

A typical setup would be:

- **brickhack.io** — Marketing site with event info, schedule, sponsors, etc and a button to apply
- **apply.brickhack.io** — HackathonManager deployment to accept hacker applications + host management dashboard

This allows your public marketing site to operate however you want it (e.g. GitHub pages) while HackathonManager lives in an isolated, consistent environment.

To get started, deploy HackathonManager onto one of three supported platforms:

## Heroku

Easiest & quickest way that requires little server knowledge, however isn't cheap (free tier not recommended)

[Get Started with Heroku &raquo;](deployment-heroku.md)

## Dokku

A free alternative to Heroku, runs on your own virtual machine

[Get Started with Heroku &raquo;](deployment-dokku.md)

## OKD/OpenShift

"Enterprise Kubernetes for Developers" packaged with a useful management UI + tooling

[Get Started with OKD &raquo;](deployment-okd.md)

### Other methods

HackathonManager can also be deployed the same as any other Rails app, however this is **not** natively supported and will require you to fork this repo to integrate code changes.
