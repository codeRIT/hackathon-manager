---
id: deployment-okd
title: OKD Deployment
---

Three deployments should be made:

- HackathonManager (seen below)
- MySQL
- Redis

Each should share a common secret, containing all relevant environment variables:

- `RAILS_ENV=production`
- `DATABASE_URL=mysql2://username:password@mysql:3306/database`
- `REDIS_URL=redis://:password@redis:6379/`
- All remaining environment variables from [Environment Variables](deployment-environment-variables.md)

## MySQL Deployment

1. Set up a MySQL deployment from the standard OpenShift catalog.
2. Copy the username/password/port/host/database name to the relevant parts of `DATABSE_URL` in the shared secret config
3. Open a terminal in the MySQL pod container and run the following command:

```bash
mysql_tzinfo_to_sql /usr/share/zoneinfo | mysql -u root mysql
```

## Redis Deployment

1. Set up a Redis deployment from the standard OpenShift catalog.
2. Copy the password/port/host to the relevant parts of `REDIS_URL` in the shared secret config

## HackathonManager Deployment

This consists of a pod with two containers: `web` and `sidekiq`. Both use the same built image; sidekiq runs with a custom command.

```yaml
apiVersion: apps.openshift.io/v1
kind: DeploymentConfig
metadata:
  annotations:
    openshift.io/generated-by: OpenShiftWebConsole
  creationTimestamp: '2019-04-17T18:41:01Z'
  generation: 14
  labels:
    app: hackathon-manager-demo
  name: hackathon-manager-demo
  namespace: hackathon-manager-demo
  resourceVersion: '25003711'
  selfLink: >-
    /apis/apps.openshift.io/v1/namespaces/hackathon-manager-demo/deploymentconfigs/hackathon-manager-demo
  uid: 5987d6b5-6140-11e9-b0f8-1a373a0e2f7f
spec:
  replicas: 1
  selector:
    deploymentconfig: hackathon-manager-demo
  strategy:
    activeDeadlineSeconds: 21600
    resources: {}
    rollingParams:
      intervalSeconds: 1
      maxSurge: 25%
      maxUnavailable: 25%
      timeoutSeconds: 600
      updatePeriodSeconds: 1
    type: Rolling
  template:
    metadata:
      creationTimestamp: null
      labels:
        app: hackathon-manager-demo
        deploymentconfig: hackathon-manager-demo
    spec:
      containers:
        - envFrom:
            - secretRef:
                name: hackathon-manager-demo
          image: >-
            docker-registry.default.svc:5000/hackathon-manager-demo/hackathon-manager-demo@sha256:66933712fc8cbb42ed553e5f07dd278bb12f2a1a964af8c635028f84d9149f49
          imagePullPolicy: Always
          name: web
          ports:
            - containerPort: 8080
              protocol: TCP
          readinessProbe:
            failureThreshold: 3
            httpGet:
              path: /
              port: 8080
              scheme: HTTP
            periodSeconds: 10
            successThreshold: 1
            timeoutSeconds: 1
          resources: {}
          terminationMessagePath: /dev/termination-log
          terminationMessagePolicy: File
        - command:
            - bash
            - '-c'
            - bundle exec sidekiq
          envFrom:
            - secretRef:
                name: hackathon-manager-demo
          image: >-
            docker-registry.default.svc:5000/hackathon-manager-demo/hackathon-manager-demo@sha256:66933712fc8cbb42ed553e5f07dd278bb12f2a1a964af8c635028f84d9149f49
          imagePullPolicy: Always
          name: sidekiq
          resources: {}
          terminationMessagePath: /dev/termination-log
          terminationMessagePolicy: File
      dnsPolicy: ClusterFirst
      restartPolicy: Always
      schedulerName: default-scheduler
      securityContext: {}
      terminationGracePeriodSeconds: 30
  test: false
  triggers:
    - imageChangeParams:
        automatic: true
        containerNames:
          - web
          - sidekiq
        from:
          kind: ImageStreamTag
          name: 'hackathon-manager-demo:latest'
          namespace: hackathon-manager-demo
        lastTriggeredImage: >-
          docker-registry.default.svc:5000/hackathon-manager-demo/hackathon-manager-demo@sha256:66933712fc8cbb42ed553e5f07dd278bb12f2a1a964af8c635028f84d9149f49
      type: ImageChange
    - type: ConfigChange
```
