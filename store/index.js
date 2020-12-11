export const state = () => ({
  meta: {
    ticker: {
      text: ' ',
      duration: 1000,
    },
  },
})

export const mutations = {
  setMeta(state, payload) {
    state.meta = payload
  },
}
