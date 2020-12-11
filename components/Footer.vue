<template>
  <div>
    <div class="mx-auto w-full flex justify-center">
      <div
        class="flex justify-center items-center overflow-visible w-0 h-0 rotated"
      >
        <div class="w-screen border-t border-b border-gray">
          <Ticker :text="tickerText" :duration="tickerDuration" />
        </div>
      </div>
    </div>
    <div
      class="flex flex-col md:flex-row justify-between md:items-end pt-16 lg:pt-8"
    >
      <LogoFooter class="p-8 md:p-12 w-full sm:w-2/3 md:w-1/3 xl:w-1/2" />
      <div
        class="p-8 md:p-12 uppercase text-xxs md:text-sm text-right leading-loose"
      >
        <div>INTER-BLOCKCHAIN COMMUNICATION</div>
        <div>
          <span class="mr-4">Documentation</span>
          <span class="mr-4">faq</span>
          <span class="mr-4">forum</span>
          <span>discord</span>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import Ticker from '~/components/Ticker'
import LogoFooter from '~/components/LogoFooter'

export default {
  components: { Ticker, LogoFooter },

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

<style scoped>
.rotated {
  transform: rotate(-174.65deg);
}
</style>
