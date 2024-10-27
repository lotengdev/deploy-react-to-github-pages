# deploy-react-to-github-pages

Uses:

```
name: Publish Site

on:
  push:
    branches:
      - master

jobs:
  build-deploy:
    runs-on: ubuntu-latest

    steps:
      - name: Checkout Repo
        uses: actions/checkout@master
        with:
          submodules: true
      - name: Publish Site
        uses: lotengdev/deploy-react-to-github-pages@master
        with:
          githubToken: ${{ secrets.PERSONAL_TOKEN }}
```