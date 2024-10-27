# deploy-react-to-github-pages

Uses:

```yml
name: Publish Site

on:
  push:
    branches:
      - main

jobs:
  build-deploy:
    runs-on: ubuntu-latest

    steps:
      - name: Checkout Repo
        uses: actions/checkout@main
        with:
          submodules: true
      - name: Publish Site
        uses: lotengdev/deploy-react-to-github-pages@main
        with:
          githubToken: ${{ secrets.PERSONAL_TOKEN }}
```