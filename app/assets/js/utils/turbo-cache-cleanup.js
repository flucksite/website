// Strip transient flash and field errors before Turbo snapshots the page.
document.addEventListener('turbo:before-cache', () => {
  document.querySelectorAll('.flash, .field__error').forEach(el => el.remove())
})
