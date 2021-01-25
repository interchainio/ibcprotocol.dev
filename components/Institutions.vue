<template>
  <div class="mt-16">
    <div class="mx-auto px-8 md:px-12 text-center leading-tight">
      <h1 class="text-lg md:text-3xl uppercase mb-8">
        IBC is developed by a diverse group of institutions
      </h1>
    </div>
    <div class="border-t border-gray">
      <ul class="mx-auto flex flex-wrap">
        <li
          v-for="(institution, index) in institutions"
          :key="index"
          class="institution w-1/2 md:w-1/3 flex justify-center items-center"
          :class="{ 'institution-borders': hasBorders(index) }"
        >
          <a
            class="text-lg md:text-2xl w-full h-full flex justify-center items-center text-center p-4"
            target="_blank"
            :href="institution.link"
            >{{ institution.name }}</a
          >
        </li>
      </ul>
    </div>
  </div>
</template>

<script>
export default {
  props: {
    institutions: {
      type: Array,
      required: true,
    },
  },

  computed: {
    isNarrow() {
      return window.innerWidth < 768
    },

    tickerText() {
      return this.$store.state.meta.ticker.text
    },

    tickerDuration() {
      return this.$store.state.meta.ticker.duration
    },
  },

  methods: {
    hasBorders(index) {
      return (Math.floor(index / 3) + index) % 2 !== 0
    },
  },
}
</script>

<style scoped>
.institution {
  @apply border-b;
  height: 220px;

  &:nth-child(2n) {
    @apply border-l;
  }

  @screen md {
    border-left: none;
  }

  &.institution-borders {
    @screen md {
      border-left: 1px solid !important;
      border-right: 1px solid !important;
    }
  }
}
</style>
