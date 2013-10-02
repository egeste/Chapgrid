# Main Chapgrid object. All components get attached to this.

Chapgrid =
  get: (component) -> @[component]
  construct: (component, args...) -> new @[component] args...

module.exports = Chapgrid
