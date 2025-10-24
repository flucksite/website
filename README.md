# FLUCK Website

This is the repo for the [https://fluck.site](https://fluck.site) website.

> [!NOTE]: The original repo is hosted at
> [https://codeberg.org/fluck/website](https://codeberg.org/fluck/website). The
> GitHub repo is just a mirror.

## Introduction

This project is built with [Lucky Framework](https://luckyframework.org/), a
web framework for the [Crystal Language](https://crystal-lang.org/). It's a
database-less Lucky app, and blog posts are static markdown files in the repo.
Essentially it's like a static site, but it's compiled into a single binary,
and it runs as a dynamic website.

## Setting up the project

1. Run `crystal script/setup.cr`
1. Run `lucky dev` to start the app
