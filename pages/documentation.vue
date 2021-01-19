<template>
  <div>
    <div v-for="(resource, idx) in resources" :key="idx">
      {{ resource.name }}
      {{ resource.title }}
    </div>
  </div>
</template>

<script>
export default {
  async asyncData({ $content }) {
    const resources = await $content('documentation/resources').fetch()

    return { resources }
  },
}
</script>
