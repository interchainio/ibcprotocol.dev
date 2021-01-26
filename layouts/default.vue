<template>
  <div id="app" :class="{ darkmode: darkMode }">
    <Ticker />
    <Nav />
    <Nuxt />
    <Footer class="mt-48" />
  </div>
</template>

<script>
import Nav from '~/components/Nav'
import Ticker from '~/components/Ticker'
import Footer from '~/components/Footer'

export default {
  name: 'Default',
  components: { Nav, Ticker, Footer },
  data() {
    return {
      darkMode:
        (window.localStorage.getItem('dark-mode') === null ||
          window.localStorage.getItem('dark-mode') === 'true') &&
        window.matchMedia('(prefers-color-scheme: dark)'),
    }
  },
  computed: {
    isHome() {
      return this.$route.path === '/'
    },
  },
  created() {
    this.$nuxt.$on('toggle-dark-mode', () => {
      this.darkMode = !this.darkMode
      this.setDarkModeToken()
    })
  },
  methods: {
    setDarkModeToken() {
      window.localStorage.setItem('dark-mode', this.darkMode)
    },
  },
  async mounted() {
    const meta = await this.$content('meta').fetch()
    this.$store.commit('setMeta', meta)
  },
}
</script>
