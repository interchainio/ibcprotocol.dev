<template>
  <div class="max-w-6xl mx-auto px-4 md:px-8">
    <div class="flex flex-col my-16 md:flex-row"></div>
    <div class="flex flex-col my-16 md:flex-row"></div>
    <div class="-mt-16 md:-mt-32">
      <div class="flex flex-wrap">
        <div
          v-for="(item, index) in page.public"
          :key="item.slug"
          class="w-full md:w-1/2 pr-0 md:pr-16 mb-12 md:mb-0"
          :class="{ 'opacity-25': item.value === null }"
        >
          <Title-Line :index="index" />
          <a
            :href="item.link"
            target="_blank"
            class="relative flex w-full justify-between"
          >
            <h2 class="text-lg md:text-2xl mb-3">{{ item.title }}</h2>
          </a>
          <p v-if="item.description" class="f-serif">{{ item.description }}</p>
          <br />
          <br />
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import TitleLine from '~/components/TitleLine'
export default {
  components: { TitleLine },
  async asyncData({ $content }) {
    const page = await $content('implementations/relayers').fetch()

    return { page }
  },
}
</script>
