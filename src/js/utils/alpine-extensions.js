import Alpine from 'alpinejs'

/**
 * Register Alpine.js extensions from a module object.
 * @param {string} type - Alpine method (data, store, etc.)
 * @param {object} modules - Object of {name: component}
 */
export const registerAlpineExtensions = (type, modules) => {
  for (const [name, component] of Object.entries(modules))
    Alpine[type](toCamelCase(name), component)
}

/**
 * Converts kebab-case or snake_case to camelCase.
 * @param {string} string
 * @returns {string}
 */
const toCamelCase = string =>
  string
    .replace(/_|\//g, '-')
    .replace(/-([a-z])/g, (_, letter) => letter.toUpperCase())
