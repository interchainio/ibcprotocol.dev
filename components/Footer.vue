<template>
  <div>
    <div class="mx-auto w-full flex justify-center">
      <div
        class="flex justify-center items-center overflow-visible w-0 h-0 flipped"
      >
        <div class="w-screen border-t border-b border-gray">
          <Ticker />
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
          <span class="mx-2"
            ><NuxtLink to="/documentation">Documentation</NuxtLink></span
          >
          <span class="mr-2"><NuxtLink to="/faq">faq</NuxtLink></span>
          <span class="mr-2"
            ><a
              href="https://forum.cosmos.network/t/welcome-to-cosmos-forum-read-this-to-get-started/29"
              >forum</a
            ></span
          >
          <span><a href="https://discord.gg/vcExX9T">discord</a></span>
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
.flipped {
  transform: rotate(-180deg);
}
</style>
