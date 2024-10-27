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
          # Remember to set this as a secret (i.e. secrets.PERSONAL_TOKEN).
          # Don't forget to set the secret value in the project settings.
          #cname: lotengdev.github.io # Or anything else
          # Use if you have a custom domain for your site.
          branch: main # Or anything else
          # Use if your site is not hosted on the gh-pages branch.
          repo: lotengdev/lotengdev.github.io
          # Use if your pushing to a different repo.
          # Dont add ".git" to the end of the URL (youl'll get 404s).
```