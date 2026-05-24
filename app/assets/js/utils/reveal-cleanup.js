// Reset reveal-once states before Turbo caches the page so animations replay on revisit.
document.addEventListener('turbo:before-cache', () => {
  document.querySelectorAll('.reveal[data-state="visible"]').forEach(el => {
    delete el.dataset.state
  })
})
