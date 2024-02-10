## Description

Qiita hackthon 2024.

## Installation

```bash
cp .env.example .env
yarn install
```

### Setup CloudSQL Auth Proxy

1. Download auth proxy from [document](https://cloud.google.com/sql/docs/postgres/connect-auth-proxy?hl=ja#install)
1. Setup application default credential.
```sh
gcloud auth application-default login
```
1. Run proxy
```sh
./cloud-sql-proxy --port 5432 vocal-circle-387923:asia-northeast1:qiita-hackthon-2024
```

## Running the app

```bash
# development
$ yarn run start

# watch mode
$ yarn run start:dev

# production mode
$ yarn run start:prod
```

## Test

```bash
# unit tests
$ yarn run test

# e2e tests
$ yarn run test:e2e

# test coverage
$ yarn run test:cov
```

## Swagger UI

http://localhost:3000/swagger

## GAE

### Deploy

1. `cp .env.production .env`
1. `yarn build`
1. `gcloud app deploy`

### Links 

- https://vocal-circle-387923.an.r.appspot.com/
- https://vocal-circle-387923.an.r.appspot.com/swagger
