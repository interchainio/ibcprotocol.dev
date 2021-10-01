<template>
  <div>
    <div class="mx-auto w-full flex justify-center">
      <div
        class="
          flex
          justify-center
          items-center
          overflow-visible
          w-0
          h-0
          flipped
        "
      >
        <div class="w-screen border-t border-b border-gray">
          <Ticker />
        </div>
      </div>
      <div
        class="flex flex-col md:flex-row justify-between md:items-end pt-8"
      ></div>
    </div>
  </div>
</template>

<script>
import Ticker from '~/components/Ticker'

export default {
  components: { Ticker },

  computed: {
    tickerText() {
      return this.$store.state.meta.ticker.text
    },

    tickerDuration() {
      return this.$store.state.meta.ticker.duration
    },
  },
}
</script>

<style lang="css" scoped>
.flipped {
  transform: rotate(-180deg);
}
</style>
