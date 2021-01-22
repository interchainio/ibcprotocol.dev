<template>
  <div id="app" :class="{ darkmode: darkMode }">
    <Ticker />
    <Nav />
    <div v-if="isHome" class="border-gray px-8 md:px-12">
      <Logo class="w-full my-12" />
    </div>
    <Nuxt />
    <div class="mt-48">
      <Footer />
    </div>
  </div>
</template>

<script>
import Nav from '~/components/Nav'
import Ticker from '~/components/Ticker'
import Footer from '~/components/Footer'

export default {
  name: 'Default',
  components: { Nav, Ticker, Footer },
  created() {
    this.$nuxt.$on('toggle-dark-mode', () => {
      this.darkMode = !this.darkMode
    })
  },
  data() {
    return {
      darkMode: window.matchMedia('(prefers-color-scheme: dark)'),
    }
  },
  computed: {
    isHome() {
      return this.$route.path === '/'
    },
  },
  async mounted() {
    const meta = await this.$content('meta').fetch()
    this.$store.commit('setMeta', meta)
  },
}
</script>
