import Vue from 'vue'
import VueGtag from 'vue-gtag'

// Docs: https://matteo-gabriele.gitbook.io/vue-gtag/
export default ({ app }) => {
  Vue.use(
    VueGtag,
    {
      config: {
        id: 'G-HP8ZXWVLJG',
        params: {
          anonymize_ip: true,
        },
      },
    },
    app.router
  )
}
