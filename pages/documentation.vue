<template>
  <div class="max-w-6xl mx-auto">
    <img class="ml-auto" src="~/assets/images/illu-4.svg" />
    <div class="-mt-32">
      <h1 class="heading-sm mb-6">Resources</h1>
      <div class="flex flex-wrap">
        <div
          v-for="(resource, index) in page.resources"
          :key="resource.slug"
          class="w-full md:w-1/2 pr-0 md:pr-16"
        >
          <Title-Line :index="index" />
          <h2 class="text-xl mb-4">{{ resource.title }}</h2>
          <p class="f-serif">{{ resource.description }}</p>
          <span class="inline-block text-xs mt-4 badge">
            {{ resource.filetype }} {{ resource.filesize }}
          </span>
        </div>
      </div>

      <h1 class="heading-sm mb-6">IBC Implementations</h1>
      <div class="flex flex-wrap">
        <div
          v-for="(item, index) in page.ibcImplementations"
          :key="index"
          class="w-full flex items-center -mx-3 py-3 border-t border-theme border-opacity-20 f-serif"
        >
          <span class="mx-3 badge bg-yellow text-dark">{{ item.status }}</span>
          <span class="mx-3">{{ item.framework }}</span>
          <span class="mx-3">{{ item.language }}</span>
          <span class="mx-3">{{ item['supported-light-clients'] }}</span>
          <span class="mx-3">{{ item.implementer }}</span>
        </div>
      </div>

      <h1 class="heading-sm mb-6">Relayer Implementations</h1>
      <div class="flex flex-wrap">
        <div
          v-for="(item, index) in page.relayerImplementations"
          :key="index"
          class="w-full flex items-center -mx-3 py-3 border-t border-theme border-opacity-20 f-serif"
        >
          <span class="mx-3 badge bg-yellow">{{ item.status }}</span>
          <span class="mx-3">{{ item.framework }}</span>
          <span class="mx-3">{{ item.language }}</span>
          <span class="mx-3">{{ item['supported-light-clients'] }}</span>
          <span class="mx-3">{{ item.implementer }}</span>
        </div>
      </div>

      <h1 class="heading-sm mb-6">Cosmos SDK Guides</h1>
      <div class="flex flex-wrap">
        <div
          v-for="(item, index) in page.guides"
          :key="item.slug"
          class="w-full md:w-1/2 pr-0 md:pr-16"
        >
          <Title-Line :index="index" />
          <h2 class="text-xl mb-4">{{ item.title }}</h2>
          <p class="f-serif">{{ item.description }}</p>
          <span class="inline-block text-xs mt-4 bg-light text-dark badge">
            {{ item.filetype }} {{ item.filesize }}
          </span>
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
