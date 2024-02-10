## Description

Qiita hackthon 2024.

## Installation

```bash
cp .env.example .env
yarn install
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

1. `yarn build`
1. `gcloud app deploy`

### Links 

- https://vocal-circle-387923.an.r.appspot.com/
- https://vocal-circle-387923.an.r.appspot.com/swagger
