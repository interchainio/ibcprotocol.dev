<template>
  <div>
    <h1>Hello</h1>
    <nuxt-content :document="page" />
  </div>
</template>

<script>
export default {
  async asyncData({ $content }) {
    const page = await $content('index').fetch()
    return { page }
  },
}
</script>
