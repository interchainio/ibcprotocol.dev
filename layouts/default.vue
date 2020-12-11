<template>
  <div>
    <Ticker :text="tickerText" :duration="tickerDuration" />
    <Nuxt />
  </div>
</template>

<script>
export default {
  computed: {
    tickerText() {
      return this.$store.state.meta.ticker.text
    },

    tickerDuration() {
      return this.$store.state.meta.ticker.duration
    },
  },

  async mounted() {
    const meta = await this.$content('meta').fetch()
    this.$store.commit('setMeta', meta)
  },
}
</script>
