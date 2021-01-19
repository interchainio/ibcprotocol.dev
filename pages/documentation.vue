<template>
  <div class="max-w-6xl mx-auto">
    <h1 class="heading">Resources</h1>
    <div class="flex flex-wrap">
      <div
        v-for="resource in resources"
        :key="resource.slug"
        class="w-full md:w-1/2 pr-0 md:pr-16"
      >
        <!-- <title-line /> -->
        <h2 class="text-2xl">{{ resource.title }}</h2>
        <p>{{ resource.description }}</p>
      </div>
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
