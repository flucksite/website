// Add this line to the beginning of every entry script
import 'vite/modulepreload-polyfill'

// Add static assets to the manifest (optional)
import.meta.glob([
  '@images/**', // <- alias to src/images
  '@fonts/**' // <- alias to src/fonts
])

// Point to src/css/main.css
import '@css/main.css'

// Turbo
import * as Turbo from '@hotwired/turbo'

// Resets the reveal states before caching
document.addEventListener('turbo:before-cache', () => {
  document.querySelectorAll('.reveal[data-state="visible"]').forEach(el => {
    delete el.dataset.state
  })
})

// Set up Alpine
import 'alpine-turbo-drive-adapter'
import Alpine from 'alpinejs'
import intersect from '@alpinejs/intersect'
import {registerAlpineExtensions} from '../utils/alpine-extensions'
window.Alpine = Alpine

Alpine.plugin(intersect)

registerAlpineExtensions(
  'data',
  import.meta.glob('@js/components/**/*.js', {eager: true})
)

Alpine.start()
