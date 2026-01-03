export default () => ({
  show() {
    this.$el.dataset.state = 'visible'
  },

  hide() {
    delete this.$el.dataset.state
  }
})
