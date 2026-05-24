// Registers Alpine extensions from a glob; Alpine is passed in to avoid a hard dep.
export const registerAlpineExtensions = (
  alpine,
  type,
  modules,
  transform = s => s
) => {
  for (const [path, component] of Object.entries(modules))
    alpine[type](pathToAlpineComponentName(path, transform), component)
}

const pathToAlpineComponentName = (path, transform) =>
  transform(path)
    .replace(/_|\//g, '-')
    .replace(/-([a-z])/g, (_, letter) => letter.toUpperCase())
