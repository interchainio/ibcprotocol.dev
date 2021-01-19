<template>
  <div id="app" :class="{ darkmode: darkMode }">
    <Ticker />
    <div v-if="isHome" class="border-gray border-t px-8 md:px-12">
      <Logo class="mx-auto w-full my-12" />
    </div>
    <Nav />
    <Nuxt />
  </div>
</template>

<script>
import Nav from '~/components/Nav'
import Ticker from '~/components/Ticker'

export default {
  components: { Nav, Ticker },

  name: 'Default',

  data() {
    return {
      darkMode: window.matchMedia('(prefers-color-scheme: dark)'),
    }
  },

  async mounted() {
    const meta = await this.$content('meta').fetch()
    this.$store.commit('setMeta', meta)
  },

  computed: {
    isHome() {
      return this.$route.path === '/'
    },
  },
}
</script>
