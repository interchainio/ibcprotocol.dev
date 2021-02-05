<template>
  <div class="w-full md:w-1/2 f-serif relative md:px-4 md:mb-3">
    <div
      class="flex flex-col justify-start items-start py-3 border-t border-theme border-opacity-20"
    >
      <div
        class="mt-3 lg:mr-4 badge text-dark absolute right-0 top-0"
        :class="badgeClass(item)"
      >
        {{ item.badgeLabel }}
      </div>

      <div
        v-for="(value, key) in item.content"
        :key="key"
        class="block flex flex-col items-start mb-3 md:mb-2 md:flex-row md:items-start underline-links"
      >
        <div
          class="w-48 text-xxs md:w-72 md:mr-3 md:text-xs uppercase md:mt-1 opacity-75"
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
