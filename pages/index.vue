<template>
  <div>
    <!-- Uncomment to use banner -->
    <!-- <a
      v-if="banner"
      :href="banner.link"
      class="block uppercase py-4 lg:text-xl border-b border-theme text-center relative leading-tight"
      target="_blank"
      v-html="banner.title"
    >
    </a> -->
    <div>
      <div class="mx-auto px-4 md:px-12 max-w-6xl relative">
        <Logo class="md:my-12 w-full md:w-auto" />

        <div class="relative">
          <h1 class="heading mb-16 mb:mb-32">
            <div class="leading-normal md:leading-tight">
              The industry standard<br />protocol for
            </div>
            <div
              class="inline-block text-gradient leading-normal md:leading-tight"
            >
              Inter&#8209;Blockchain<br />
              Communication
            </div>
          </h1>
          <img
            class="
              absolute
              right-0
              top-0
              opacity-25
              mt-48
              md:mt-32
              md:opacity-100
            "
            src="~/assets/images/illu-1.svg"
          />
        </div>

        <nuxt-content
          class="f-serif max-w-2xl text-md md:text-xl leading-relaxed"
          :document="page"
        />

        <div class="my-16 flex flex-col md:flex-row">
          <div>
            <NuxtLink class="button mt-6 md:mt-0" to="/faq"
              >Learn More</NuxtLink
            >
          </div>
          <div>
            <NuxtLink to="/documentation" class="button mt-6 md:mt-0 md:ml-6"
              >Documentation</NuxtLink
            >
          </div>
        </div>
      </div>
    </div>

    <div class="mx-auto px-8 md:px-12 max-w-6xl relative mt-16">
      <img src="~/assets/images/illu-2.svg" class="w-full" />
    </div>

    <Organizations :content="organizations" />

    <div class="mx-auto px-8 md:px-12 max-w-6xl relative py-24">
      <img src="~/assets/images/illu-3.svg" class="w-full" />
    </div>

    <div class="mx-auto max-w-6xl relative">
      <Join :content="community" />
    </div>
  </div>
</template>

<script>
import News from '~/components/ContentSections/News'
import Organizations from '~/components/ContentSections/Organizations'
import Join from '~/components/ContentSections/Join'

export default {
  components: { News, Organizations, Join },

  async asyncData({ $content }) {
    const banner = await $content('index/banner').fetch()
    const page = await $content('index/intro').fetch()
    const organizations = await $content('index/organizations').fetch()
    const community = await $content('index/community').fetch()

    const news = await $content('news')
      .only(['title', 'description', 'link'])
      .limit(4)
      .sortBy('date', 'desc')
      .fetch()

    return { banner, page, news, community, organizations }
  },
}
</script>
