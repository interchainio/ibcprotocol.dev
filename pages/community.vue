<template>
  <div>
    <div class="mx-auto px-8 md:px-12 max-w-6xl relative py-24">
      <img src="~/assets/images/illu-3.svg" class="w-full" />
    </div>

    <div class="mx-auto max-w-6xl relative">
      <Join :content="community" />
    </div>
  </div>
</template>

<script>
import Join from '~/components/ContentSections/Join'

export default {
  components: { Join },

  async asyncData({ $content }) {
    const community = await $content('community/content').fetch()

    return { community }
  },
}
</script>
