<template>
  <div>
    <div class="flex flex-col my-16 md:flex-row"></div>
    <div class="mx-auto max-w-6xl relative">
      <Implementations :content="implementations" />
    </div>
    <div class="mx-auto px-8 md:px-12 max-w-6xl relative py-24">
      <img src="~/assets/images/illu-3.svg" class="w-full" />
    </div>
  </div>
</template>

<script>
import Implementations from '~/components/ContentSections/Implementations'

export default {
  components: { Implementations },

  async asyncData({ $content }) {
    const implementations = await $content('implementations/content').fetch()

    return { implementations }
  },
}
</script>
