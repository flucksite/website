## Unreleased

### Added

- Newsletter section backed by Marquery, with the first issue published.
- Blog with index page, tag filtering, pagination, individual post pages, and
  an RSS feed (anchor links excluded).
- Heading anchors and styling for blog posts, plus blog backgrounds.
- Linkable people on the about page.
- Blog link in the main and footer menus.
- Flow specs covering all actions and a basic HTTP test suite.

### Changed

- Reworked honeypot-protected forms to use the new `lucky_honeypot` API.
- Switched markdown handling and queries to Marquery.
- Updated to the latest Lucky and Crystal dependencies.

### Fixed

- Ethical Move badge stays light on error pages.
- Plausible script only renders in production.
- CSS globs use the correct `.css` extension.

## v0.6.1 - 2026-03-10

### Changed

- Use seasons for the timeline.

## v0.6.0 - 2026-03-01

### Added

- New plugin system for Lucky Bun.

## v0.5.1 - 2026-02-08

### Added

- Root alias for CSS assets.

## v0.5.0 - 2026-02-08

### Changed

- Replaced Vite with Bun for the frontend build, including an updated
  Dockerfile.

## v0.4.0 - 2026-02-06

### Added

- Honeypot signals implementation on top of `lucky_honeypot`.

### Changed

- Replaced the simple honeypot with the `lucky_honeypot` shard.

### Fixed

- Adjusted deadlines.
- Clipped horizontal overflow.
- Theme resilience under forced color modes and Samsung Internet (darkreader
  lock, `supported-color-schemes` meta, disabled CSS filters on background
  colours).

### Added (later in cycle)

- Reveal-on-scroll using Alpine and CSS, applied to the timeline and home page,
  with a configurable reveal speed enum.

## v0.3.8 - 2025-11-06

### Fixed

- Cutout display.

## v0.3.7 - 2025-11-06

### Changed

- Moved the theme switcher to the utility menu.
- Improved accessibility in the header menu.

## v0.3.6 - 2025-11-06

### Added

- Ethical Move badge.
- Error trace in development output.

## v0.3.5 - 2025-10-30

### Changed

- Cleaned up CSP.

## v0.3.4 - 2025-10-30

### Added

- Pre-connect to the asset host.

### Changed

- Updated Raven and Lucky Vite dependencies (Raven pinned to 1.9.4).

## v0.3.3 - 2025-10-29

### Added

- Asset host (Bunny) configuration and CSP entry.

### Fixed

- Label on the theme switcher.

## v0.3.2 - 2025-10-28

### Fixed

- Replaced straight apostrophes with curly quotes.

## v0.3.1 - 2025-10-27

### Fixed

- Security header for Plausible.

## v0.3.0 - 2025-10-27

### Added

- Theme switcher with themeable backgrounds.
- Privacy policy, terms of service, and code of conduct pages, plus sitemap
  entries.
- Sitemap builder, canonical link, skip link, OG and Twitter card tags.
- Healthcheck endpoint and CapRover staging/production deployment workflows.
- Waitlist page and action.
- About page.
- Plausible analytics script.
- New Plausible script and preloaded background images.
- Honeypot and rate limiting on subscription forms.
- Newsletter subscription component with translations and disclaimer.
- Footer menus and styling, code of conduct page, and home page content.
- Vertical logo for smaller screens, `aria-current` on menu items.
- Site header, favicon, and initial frontend setup with Alpine, Turbo, and
  Rosetta i18n.
- Mailinglist and subscription operations via Avram.

### Changed

- Replaced htmx with Turbo and enabled morphing and view transitions.
- Reworked header structure and simplified styling.
- Moved security headers into a mixin.
- Switched from Vite-only to a configurable asset host setup.

### Fixed

- Accessibility issues in the signup form and menu icons.
- Responsive issues on the about page.
- Various CSS theme inconsistencies.
