<template>
  <div>
    <div class="mx-auto w-full flex justify-center">
      <div
        class="
          flex
          justify-center
          items-center
          overflow-visible
          w-0
          h-0
          flipped
        "
      ></div>
      <div
        class="flex flex-col md:flex-row justify-between md:items-end pt-8"
      ></div>
    </div>
  </div>
</template>

<script>
export default {
  components: {},

  computed: {},
}
</script>

<style lang="css" scoped>
.flipped {
  transform: rotate(-180deg);
}
</style>
