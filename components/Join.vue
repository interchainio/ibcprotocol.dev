<template>
  <div class="mx-auto max-w-6xl mt-16">
    <h1 class="text-3xl text-center uppercase mb-24">Join the community</h1>
    <div
      class="flex flex-col md:flex-row justify-center mx-auto max-w-5xl px-12"
    >
      <div
        v-for="(c, index) in community"
        :key="index"
        class="w-full md:w-1/3"
        :class="{ 'pt-16': index === 1, 'pt-32': index === 2 }"
      >
        <div class="flex border border-white justify-between w-full box-tall">
          <div class="p-6">
            <div class="uppercase text-sm mb-8">{{ c.title }}</div>
            <div class="text-xs">{{ c.subtitle }}</div>
          </div>
          <div>
            <div class="bg-white w-16 h-16 flex justify-center items-center">
              <img src="~/assets/images/arrow.svg" />
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  props: {
    community: {
      type: Array,
      required: true,
    },
  },

  computed: {
    isNarrow() {
      return window.innerWidth < 768
    },
  },
}
</script>

<style scoped>
.box-tall {
  height: 180px;
}
</style>
