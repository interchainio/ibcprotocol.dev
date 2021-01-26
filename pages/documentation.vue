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
        >
          <Title-Line :index="index" />
          <h2 class="text-lg md:text-2xl mb-3">{{ item.title }}</h2>
          <p class="f-serif">{{ item.description }}</p>
          <a :href="item.link"
            ><span class="badge text-base inline-block mt-6 bg-light text-dark">
              {{ item.button }}
            </span></a
          >
        </div>
      </div>

      <h1 class="heading-sm mb-6">IBC Implementations</h1>
      <div
        v-for="(item, index) in page.ibcImplementations"
        :key="index"
        class="w-full flex flex-col md:flex-row justify-start items-start py-3 border-t border-theme border-opacity-20 f-serif relative"
      >
        <div class="m-3 badge bg-yellow text-dark absolute right-0 top-0">
          {{ item.status }}
        </div>

        <div
          class="block flex flex-col items-start mb-2 md:mx-3 md:flex-row md:items-center"
        >
          <div class="w-48 text-xxs uppercase">Framework</div>
          <div>{{ item.framework }}</div>
        </div>

        <div class="block mx-3 flex items-center">
          <div class="w-48 text-xs uppercase">Language</div>
          <div>{{ item.language }}</div>
        </div>

        <div class="block mx-3 flex items-center">
          <div class="w-48 text-xs uppercase">Supported Light Clients</div>
          <div>{{ item['supported-light-clients'] }}</div>
        </div>

        <div class="block mx-3 flex items-center">
          <div class="w-48 text-xs uppercase">Implementer</div>
          <div>{{ item.implementer }}</div>
        </div>
      </div>

      <h1 class="heading-sm mb-6">Relayer Implementations</h1>
      <div class="flex flex-wrap">
        <div
          v-for="(item, index) in page.relayerImplementations"
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

      <h1 class="heading-sm mb-6">Cosmos SDK Guides</h1>
      <div class="flex flex-wrap">
        <div
          v-for="(item, index) in page.guides"
          :key="item.slug"
          class="w-full md:w-1/2 pr-0 md:pr-16 mb-12 md:mb-0"
        >
          <Title-Line :index="index" />
          <h2 class="text-2xl mb-3">{{ item.title }}</h2>
          <p class="f-serif">{{ item.description }}</p>
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
