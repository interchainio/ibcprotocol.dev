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
      <div class="flex flex-wrap md:-mx-3">
        <div
          v-for="(item, index) in page.ibcImplementations"
          :key="index"
          class="w-full md:w-1/2 f-serif relative md:px-3 md:mb-3"
        >
          <div
            class="flex flex-col justify-start items-start py-3 border-t border-theme border-opacity-20"
          >
            <div
              class="mt-3 lg:mr-3 badge bg-yellow text-dark absolute right-0 top-0"
            >
              {{ item.status }}
            </div>

            <div
              class="block flex flex-col items-start mb-3 md:mb-2 md:flex-row md:items-start"
            >
              <div
                class="w-48 text-xxs md:w-72 md:mr-3 md:text-xs uppercase md:mt-1"
              >
                Framework
              </div>
              <div>{{ item.framework }}</div>
            </div>

            <div
              class="block flex flex-col items-start mb-3 md:mb-2 md:flex-row md:items-start"
            >
              <div
                class="w-48 text-xxs md:w-72 md:mr-3 md:text-xs uppercase md:mt-1"
              >
                Language
              </div>
              <div>{{ item.language }}</div>
            </div>

            <div
              class="block flex flex-col items-start mb-3 md:mb-2 md:flex-row md:items-start"
            >
              <div
                class="w-48 text-xxs md:w-72 md:mr-3 md:text-xs uppercase md:mt-1"
              >
                Supported Light Clients
              </div>
              <div>{{ item['supported-light-clients'] }}</div>
            </div>

            <div
              class="block flex flex-col items-start mb-3 md:mb-2 md:flex-row md:items-start"
            >
              <div
                class="w-48 text-xxs md:w-72 md:mr-3 md:text-xs uppercase md:mt-1"
              >
                Implementer
              </div>
              <div>{{ item.implementer }}</div>
            </div>

            <div
              class="block flex flex-col items-start mb-3 md:mb-2 md:flex-row md:items-start"
            >
              <div
                class="w-48 text-xxs md:w-72 md:mr-3 md:text-xs uppercase md:mt-1"
              >
                Links
              </div>
              <div>
                <ul>
                  <li
                    v-for="(link, idx) in item.links"
                    :key="idx"
                    class="inline mr-3 md:mr-0 md:block"
                  >
                    <a :href="link.link">{{ link.title }}</a>
                  </li>
                </ul>
              </div>
            </div>
          </div>
        </div>
      </div>

      <h1 class="heading-sm mb-6">Relayer Implementations</h1>
      <div class="flex flex-wrap md:-mx-3">
        <div
          v-for="(item, index) in page.ibcImplementations"
          :key="index"
          class="w-full md:w-1/2 f-serif relative md:px-3 md:mb-3"
        >
          <div
            class="flex flex-col justify-start items-start py-3 border-t border-theme border-opacity-20"
          >
            <div
              class="mt-3 lg:mr-3 badge bg-yellow text-dark absolute right-0 top-0"
            >
              {{ item.status }}
            </div>

            <div
              class="block flex flex-col items-start mb-3 md:mb-2 md:flex-row md:items-start"
            >
              <div
                class="w-48 text-xxs md:w-72 md:mr-3 md:text-xs uppercase md:mt-1"
              >
                Framework
              </div>
              <div>{{ item.framework }}</div>
            </div>

            <div
              class="block flex flex-col items-start mb-3 md:mb-2 md:flex-row md:items-start"
            >
              <div
                class="w-48 text-xxs md:w-72 md:mr-3 md:text-xs uppercase md:mt-1"
              >
                Language
              </div>
              <div>{{ item.language }}</div>
            </div>

            <div
              class="block flex flex-col items-start mb-3 md:mb-2 md:flex-row md:items-start"
            >
              <div
                class="w-48 text-xxs md:w-72 md:mr-3 md:text-xs uppercase md:mt-1"
              >
                Supported Light Clients
              </div>
              <div>{{ item['supported-light-clients'] }}</div>
            </div>

            <div
              class="block flex flex-col items-start mb-3 md:mb-2 md:flex-row md:items-start"
            >
              <div
                class="w-48 text-xxs md:w-72 md:mr-3 md:text-xs uppercase md:mt-1"
              >
                Implementer
              </div>
              <div>{{ item.implementer }}</div>
            </div>

            <div
              class="block flex flex-col items-start mb-3 md:mb-2 md:flex-row md:items-start"
            >
              <div
                class="w-48 text-xxs md:w-72 md:mr-3 md:text-xs uppercase md:mt-1"
              >
                Links
              </div>
              <div>
                <ul>
                  <li
                    v-for="(link, idx) in item.links"
                    :key="idx"
                    class="inline mr-3 md:mr-0 md:block"
                  >
                    <a :href="link.link">{{ link.title }}</a>
                  </li>
                </ul>
              </div>
            </div>
          </div>
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
