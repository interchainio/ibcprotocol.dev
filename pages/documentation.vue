<template>
  <div class="max-w-6xl mx-auto px-4 md:px-8">
    <img class="ml-auto" src="~/assets/images/illu-4.svg" />
    <div class="-mt-16 md:-mt-32">
      <h1 class="heading-sm mb-6">Resources</h1>
      <div class="flex flex-wrap">
        <div
          v-for="(item, index) in page.resources"
          :key="item.slug"
          class="w-full md:w-1/2 pr-0 md:pr-16 mb-12 md:mb-0"
          :class="{ 'opacity-25': item.value === null }"
        >
          <Title-Line :index="index" />
          <h2 class="text-lg md:text-2xl mb-3">{{ item.title }}</h2>
          <p v-if="item.description" class="f-serif">{{ item.description }}</p>
          <a :href="item.link"
            ><span class="badge text-base inline-block mt-6 bg-light text-dark">
              {{ item.button }}
            </span></a
          >
        </div>
      </div>

      <h1 class="heading-sm mb-6">IBC Implementations</h1>
      <div class="flex flex-wrap md:-mx-4">
        <Card
          v-for="(item, idx) in page.ibcImplementations"
          :key="idx"
          :item="item"
        />
      </div>

      <h1 class="heading-sm mb-6">Relayer Implementations</h1>
      <div class="flex flex-wrap md:-mx-4">
        <Card
          v-for="(item, idx) in page.relayerImplementations"
          :key="idx"
          :item="item"
        />
      </div>

      <h1 class="heading-sm mb-6">IBC Applications</h1>
      <div class="flex flex-wrap md:-mx-4">
        <Card
          v-for="(item, idx) in page.ibcApplications"
          :key="idx"
          :item="item"
        />
      </div>

      <h1 class="heading-sm mb-6">Cosmos SDK Guides</h1>
      <div class="flex flex-wrap">
        <div
          v-for="(item, index) in page.guides"
          :key="item.slug"
          class="w-full md:w-1/2 pr-0 md:pr-16 mb-12 md:mb-0"
        >
          <Title-Line :index="index" />
          <h2 class="text-xl mb-4">{{ item.title }}</h2>
          <p v-if="item.description" class="f-serif">{{ item.description }}</p>
          <a :href="item.link" target="_blank"
            ><span
              class="inline-block text-xs mt-6 bg-light text-dark badge text-base"
            >
              {{ item.button }}
            </span></a
          >
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
    const page = await $content('documentation/content').fetch()

    return { page }
  },
}
</script>
