<template>
  <div class="mt-16">
    <div class="mx-auto px-8 md:px-12 max-w-6xl">
      <h1 class="text-lg md:text-3xl uppercase mb-8">
        IBC is developed by a<br />diverse group of institutions
      </h1>
    </div>
    <div class="border-t border-b border-gray">
      <ul class="mx-auto max-w-6xl flex flex-wrap">
        <li
          v-for="(institution, index) in institutions"
          :key="index"
          class="box-tall w-1/2 md:w-1/3 border-grid-2 md:border-grid-3 border-gray flex justify-center items-center"
        >
          <a
            class="text-lg md:text-2xl f-serif w-full h-full flex justify-center items-center text-center p-4"
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
}
</script>

<style scoped>
.box-tall {
  height: 220px;
}
</style>
