<template>
  <div id="app" :class="{ darkmode: darkMode }">
    <Ticker />
    <div v-if="isHome" class="border-gray border-t px-8 md:px-12">
      <Logo class="mx-auto w-full my-12" />
    </div>
    <Nav />
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
