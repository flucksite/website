# Fluck Website

This repo holds the [https://fluck.site](https://fluck.site) website.

> [!Note]
> The original repository is hosted at
> [Codeberg](https://codeberg.org/fluck/website). The [GitHub
> repo](https://github.com/flucksite/website) is just a mirror.

## Stack

A database-less [Hanami 2.3](https://hanamirb.org/) app.

- Blog posts are static markdown files loaded by [marquery](https://rubygems.org/gems/marquery)
- Forms are spam-protected by [otori](https://rubygems.org/gems/otori)
- JS and CSS are bundled by [bun_bun_bundle](https://rubygems.org/gems/bun_bun_bundle).
- Newsletter signups go to EmailOctopus via a thin HTTP client.

## Requirements

- Ruby (see `.ruby-version`)
- [Bun](https://bun.sh/) for asset bundling
- [Overmind](https://github.com/DarthSim/overmind) for the dev Procfile

## Setup

```sh
bin/setup     # bundle install + bun install
bin/dev       # web server + asset watcher on http://localhost:2300
```

Copy any secrets into `.env.local` (gitignored). See `.env` for the keys the
app reads (`SESSION_SECRET`, `EMAIL_OCTOPUS_API_KEY`, `EMAIL_OCTOPUS_LIST_ID`,
`SENTRY_DSN`, `PLAUSIBLE_DOMAIN`).

## Tests & lint

```sh
bundle exec rspec       # full spec suite
bundle exec rubocop     # style checks
```

## Deployment

Each environment (`staging`, `production`) needs these secrets configured
under **Settings → Environments**:

- `CAPROVER_SERVER`
- `APP_NAME`
- `APP_TOKEN`
