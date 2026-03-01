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
import {registerAlpineExtensions} from './utils/alpine-extensions'
import components from 'glob:./components/**/*.js'

window.Alpine = Alpine
Alpine.plugin(intersect)

registerAlpineExtensions('data', components, path =>
  path.replace(/^components\//, '')
)

Alpine.start()
