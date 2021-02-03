<template>
  <div class="max-w-6xl mx-auto px-4 md:px-8">
    <img class="ml-auto mt-12" src="~/assets/images/illu-5.svg" />
    <div class="-mt-24 max-w-xl mx-6 lg:mx-0">
      <div v-for="(item, idx) in items" :key="idx">
        <h1 :id="item.slug" class="pt-16 heading-sm">{{ item.title }}</h1>
        <TitleLine :index="idx" class="mt-6" />
        <nuxt-content class="f-serif max-w-prose" :document="item" />
      </div>
    </div>

    <div class="fixed right-0 top-0 toc">
      <ul>
        <li v-for="(item, idx) in items" :key="idx">
          <a :href="`#${item.slug}`">{{ item.title }}</a>
        </li>
      </ul>
    </div>
  </div>
</template>

<script>
import TitleLine from '~/components/TitleLine'
export default {
  components: { TitleLine },
  async asyncData({ $content }) {
    const items = await $content('faq').sortBy('order').fetch()

    return { items }
  },
}
</script>

<style lang="css" scoped>
.toc {
  top: 120px;
  margin-right: 50px;
}

.content {
  a {
    text-decoration: underline !important;
  }
}
</style>
