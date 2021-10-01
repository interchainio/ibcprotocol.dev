<template>
  <div class="mt-16">
    <div class="mx-auto px-8 md:px-12 text-center leading-tight">
      <h1 class="text-lg md:text-3xl uppercase mb-8">
        IBC is developed by a diverse group of organizations
      </h1>
    </div>
    <div class="border-t border-gray">
      <ul class="mx-auto flex flex-wrap">
        <li
          v-for="(organization, index) in content.organizations"
          :key="index"
          class="organization w-1/2 md:w-1/3 flex justify-center items-center"
          :class="{ 'organization-borders': hasBorders(index) }"
        >
          <a
            class="
              text-lg
              md:text-2xl
              w-full
              h-full
              flex
              justify-center
              items-center
              text-center
              p-4
            "
            target="_blank"
            :href="organization.link"
            >{{ organization.name }}</a
          >
        </li>
      </ul>
    </div>
  </div>
</template>

<script>
export default {
  props: {
    content: {
      type: Object,
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
.organization {
  @apply border-b;
  height: 220px;
  &:nth-child(2n) {
    @apply border-l;
  }

  @screen md {
    border-left: none;
  }

  &.organization-borders {
    @screen md {
      border-left: 1px solid !important;
      border-right: 1px solid !important;
    }
  }
}
</style>
