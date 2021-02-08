<template>
  <div class="title-line mb-4" :class="classes"></div>
</template>
<script>
export default {
  props: {
    index: {
      type: Number,
      default: 0,
    },
  },
  computed: {
    classes() {
      if (this.$props.index % 4 === 0 || this.$props.index % 4 === 3) {
        return 'bg-gradientRed'
      } else if (this.$props.index % 2 === 0) {
        return 'bg-gradientPurple'
      } else {
        return 'bg-gradientPurple'
      }
    },
  },
}
</script>

<style lang="css" scoped>
.title-line {
  width: 90px;
  height: 1px;
}
</style>
