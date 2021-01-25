<template>
  <div class="max-w-6xl mx-auto px-4 md:px-8">
    <img class="ml-auto mt-12" src="~/assets/images/illu-5.svg" />

    <div class="-mt-24 max-w-xl">
      <div v-for="(item, idx) in items" :key="idx">
        <h1 class="heading-sm">{{ item.title }}</h1>
        <TitleLine :index="idx" class="mt-6" />
        <nuxt-content class="f-serif max-w-prose" :document="item" />
      </div>
    </div>
  </div>
</template>

<script>
import TitleLine from '~/components/TitleLine'
export default {
  components: { TitleLine },
  async asyncData({ $content }) {
    const items = await $content('faq').fetch()

    return { items }
  },
}
</script>
