---
id: deployment
title: Getting Started
---

HackathonManager is a standalone web app separate from your regular marketing website/public homepage.

A typical setup would be:

- **brickhack.io** — Marketing site with event info, schedule, sponsors, etc and a button to apply
- **apply.brickhack.io** — HackathonManager deployment to accept hacker applications + host management dashboard

This allows your public marketing site to operate however you want it (e.g. GitHub pages) while HackathonManager lives in an isolated, consistent environment.

To get started, deploy HackathonManager onto one of three supported platforms:

## Heroku

Easiest & quickest way that requires little server knowledge.

Recommended if you aren't familiar with running a Linux virtual machine and can spend ~$17/month.

> **Student Developer?** You can get a free [Hobby dyno](https://devcenter.heroku.com/articles/dyno-types) for up two 2 years with the [GitHub Student Developer Pack](https://education.github.com/pack). [More info...](https://www.heroku.com/github-students)

[Get Started with Heroku &raquo;](deployment-heroku.md)

## Dokku

A free alternative to Heroku, runs on your own virtual machine.

Recommended if you're on a budget and can set up Dokku on a Linux virtual machine, usually $5-10/month with services like Amazon Web Services, Google Cloud, and others. This method is free if running on premises with an always on virtual machine. 

[Get Started with Dokku &raquo;](deployment-dokku.md)

## OKD/OpenShift

"Enterprise Kubernetes for Developers" packaged with a useful management UI + tooling.

Recommended if you already have an existing, reliable OKD/Kubernetes cluster.

[Get Started with OKD &raquo;](deployment-okd.md)

### Other methods

HackathonManager can also be deployed the same as any other Rails app, however this is **not** natively supported and will require you to fork this repo to integrate & maintain code changes.
