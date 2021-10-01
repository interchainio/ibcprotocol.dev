<template>
  <div>
    <!-- Uncomment to use banner -->
    <!-- <a
      v-if="banner"
      :href="banner.link"
      class="relative block py-4 leading-tight text-center uppercase border-b lg:text-xl border-theme"
      target="_blank"
      v-html="banner.title"
    >
    </a> -->
    <div>
      <div class="relative max-w-6xl px-4 mx-auto md:px-12">
        <Logo class="w-full md:my-12 md:w-auto" />
        <div class="relative">
          <h1 class="mb-16 heading mb:mb-32">
            <div class="leading-normal md:leading-tight"></div>
            <div class="flex flex-col my-16 md:flex-row"></div>
            <div
              class="inline-block leading-normal text-gradient md:leading-tight"
            >
              Inter&#8209;Blockchain<br />
              Communication Protocol
            </div>
          </h1>
          <!-- prettier-ignore-attribute -->
          <img
            src="~/assets/images/illu-1.svg"
            class="absolute top-0 right-0 mt-48 opacity-25  md:mt-32 md:opacity-100"
          />
        </div>

        <nuxt-content
          class="max-w-2xl leading-relaxed f-serif text-md md:text-xl"
          :document="page"
        />
        <div class="flex flex-col my-16 md:flex-row"></div>
      </div>
    </div>

    <div class="relative max-w-6xl px-8 mx-auto mt-16 md:px-12">
      <img src="~/assets/images/illu-2.svg" class="w-full" />
    </div>

    <Organizations :content="organizations" />

    <div class="relative max-w-6xl px-8 py-24 mx-auto md:px-12">
      <img src="~/assets/images/illu-3.svg" class="w-full" />
    </div>

    <div class="relative max-w-6xl mx-auto">
      <Join :content="community" />
    </div>
  </div>
</template>

<script>
import Organizations from '~/components/ContentSections/Organizations'
import Join from '~/components/ContentSections/Join'

export default {
  components: { Organizations, Join },

  async asyncData({ $content }) {
    const banner = await $content('index/banner').fetch()
    const page = await $content('index/intro').fetch()
    const organizations = await $content('index/organizations').fetch()
    const community = await $content('community/content').fetch()

    const news = await $content('news')
      .only(['title', 'description', 'link'])
      .limit(4)
      .sortBy('date', 'desc')
      .fetch()

    return { banner, page, news, community, organizations }
  },
}
</script>
