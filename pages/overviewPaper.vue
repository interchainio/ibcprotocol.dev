<template>
  <div class="mx-auto px-4 md:px-12 max-w-6xl relative">
    <img class="ml-auto mt-12" src="~/assets/images/illu-5.svg" />

    <Overview-Paper class="mx-auto px-8 md:px-12 max-w-6xl relative" />
  </div>
</template>

<script>
import OverviewPaper from '~/components/ContentSections/OverviewPaper'
export default {
  components: { OverviewPaper },
  async asyncData({ $content }) {
    const page = await $content('overviewPaper/content').fetch()

    return { page }
  },
}
</script>
