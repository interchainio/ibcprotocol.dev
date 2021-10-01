<template>
  <div class="relative w-full md:w-1/2 f-serif md:px-4 md:mb-3">
    <div
      class="
        flex flex-col
        items-start
        justify-start
        py-3
        border-t border-theme border-opacity-20
      "
    >
      <div
        class="absolute top-0 right-0 mt-3 lg:mr-4 badge text-dark"
        :class="badgeClass(item)"
      >
        {{ item.badgeLabel }}
      </div>
      <!-- prettier-ignore-attribute -->
      <div
        v-for="(value, key) in item.content"
        :key="key"
        class="flex flex-col items-start block mb-3 md:mb-2 md:flex-row md:items-start underline-links"
      >
        <!-- prettier-ignore-attribute -->
        <div
          class="w-48 uppercase opacity-75 text-xxs md:w-72 md:mr-3 md:text-xs md:mt-1"
        >
          {{ clean(key) }}
        </div>
        <div class="flex flex-grow-0" v-html="value"></div>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  props: {
    item: {
      type: Object,
      default: null,
    },
  },
  methods: {
    clean(str) {
      return str.replaceAll('-', ' ')
    },
    badgeClass(item) {
      return `bg-${item.badgeColor}`
    },
  },
}
</script>
