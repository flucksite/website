// Add this line to the beginning of every entry script
import 'vite/modulepreload-polyfill'

// Add static assets to the manifest (optional)
import.meta.glob([
  // '@images/**', // <- alias to src/images
  // '@fonts/**',  // <- alias to src/fonts
])

// Point to src/css/main.css
import '@css/main.css'

console.log('🚀️ Lucky Vite!')
