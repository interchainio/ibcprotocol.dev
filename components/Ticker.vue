<template>
  <div class="marquee text-xs flex">
    <div class="marquee__iner">
      <marquee-text :duration="1000">
        <span
          v-for="n in 100"
          :key="n"
          class="uppercase flex-grow whitespace-nowrap mr-1"
          >Inter-Blockchain Communication</span
        >
      </marquee-text>
    </div>
  </div>
</template>

<script>
import MarqueeText from 'vue-marquee-text-component'

export default {
  name: 'Ticker',

  components: { MarqueeText },
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

.marquee__inner {
  width: fit-content;
  display: flex;
  position: relative;
  transform: translate3d(var(--move-initial), 0, 0);
  animation: marquee 5s linear infinite;
  animation-play-state: running;
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
