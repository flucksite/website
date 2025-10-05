import Alpine from 'alpinejs'

/**
 * Register Alpine.js extensions.
 * @param {object} files - Files to register.
 */
export const registerAlpineExtensions = (type, files, regex = null) => {
  for (const path in files)
    Alpine[type](camelcasedFileName(path, regex), files[path].default)
}

/**
 * Returns the camelcased file name.
 * @param {string} path - File path.
 * @returns {string} Camelcased file name.
 */
const camelcasedFileName = (path, regex) =>
  path
    .match(regex || /\/([^/]+)\.js$/)[1]
    .replace(/_|\//g, '-')
    .replace(/-([a-z])/g, (_, letter) => letter.toUpperCase())
