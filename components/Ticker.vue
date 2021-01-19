<template>
  <div class="marquee text-xs flex">
    <marquee-text :duration="tickerDuration">
      <span
        v-for="n in 100"
        :key="n"
        class="marquee-item uppercase flex-grow whitespace-nowrap"
        >{{ tickerText }}</span
      >
    </marquee-text>
  </div>
</template>

<script>
import MarqueeText from 'vue-marquee-text-component'

export default {
  name: 'Ticker',

  components: { MarqueeText },

  props: {
    text: {
      type: String,
      default: '',
    },
    duration: {
      type: Number,
      default: 1000,
    },
  },
  computed: {
    tickerText() {
      return this.props?.text || this.$store.state.meta.ticker.text
    },

    tickerDuration() {
      return this.props?.duration || this.$store.state.meta.ticker.duration
    },
  },
}
</script>

<style lang="css" scoped>
.marquee {
  position: relative;
  overflow: hidden;
  --offset: 20vw;
  --move-initial: calc(-25% + var(--offset));
  --move-final: calc(-50% + var(--offset));
}

.marquee-item {
  margin-right: 7px;
}

@keyframes marquee {
  0% {
    transform: translate3d(var(--move-initial), 0, 0);
  }

  100% {
    transform: translate3d(var(--move-final), 0, 0);
  }
}
</style>
