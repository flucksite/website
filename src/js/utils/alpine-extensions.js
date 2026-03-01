import Alpine from 'alpinejs'

/**
 * Registers Alpine.js extensions from a glob object.
 * @param {string} type - Alpine method (data, store, etc.)
 * @param {object} modules - Object of {path: component}
 * @param {function} transform - Function to modify path.
 * @returns {void}
 */
export const registerAlpineExtensions = (type, modules, transform = s => s) => {
  for (const [path, component] of Object.entries(modules))
    Alpine[type](pathToAlpineComponentName(path, transform), component)
}

/**
 * Converts a file path to a camelCased component name.
 * @param {string} path - File path.
 * @param {function} transform - Function to modify path.
 * @returns {string}
 */
const pathToAlpineComponentName = (path, transform) =>
  transform(path)
    .replace(/_|\//g, '-')
    .replace(/-([a-z])/g, (_, letter) => letter.toUpperCase())
