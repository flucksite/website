import {getCookie, setCookie, eraseCookie} from '../utils/cookies'

export default theme => ({
  allowedThemes: /dark|light/,
  cookieName: '_fluck_preferred_theme',
  theme: null,

  init() {
    this.theme ||= theme || this.chosenTheme() || this.preferredTheme()
  },

  toggleTheme() {
    this.setTheme(this.theme == 'light' ? 'dark' : 'light')
  },

  setTheme(theme) {
    if (!this.allowedThemes.test(theme)) return

    if (theme == this.preferredTheme()) eraseCookie(this.cookieName)
    else setCookie(this.cookieName, theme, 365)

    this.theme = theme
    Turbo.cache.clear()
  },

  chosenTheme() {
    const theme = getCookie(this.cookieName)
    if (this.allowedThemes.test(theme)) return theme
  },

  preferredTheme() {
    return window.matchMedia('(prefers-color-scheme: light)').matches
      ? 'light'
      : 'dark'
  }
})
