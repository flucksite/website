// App-level JS entry; boots Turbo and Alpine, registers component extensions via glob.

import * as Turbo from '@hotwired/turbo'
import 'alpine-turbo-drive-adapter'
import Alpine from 'alpinejs'
import intersect from '@alpinejs/intersect'

import './utils/turbo-cache-cleanup'
import './utils/reveal-cleanup'
import {registerAlpineExtensions} from './utils/alpine-extensions'

import components from 'glob:./components/**/*.js'

window.Alpine = Alpine
Alpine.plugin(intersect)

registerAlpineExtensions(Alpine, 'data', components, path =>
  path.replace(/^components\//, '').replace(/\.js$/, '')
)

Alpine.start()
