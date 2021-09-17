<template>
  <div class="mt-32">
    <h1 class="text-lg md:text-3xl uppercase mb-4">Light Clients</h1>
    <ul class="flex flex-wrap">
      <li
        v-for="(article, index) in articles"
        :key="index"
        class="w-full md:w-1/2 pr-0 md:pr-16"
      >
        <a
          v-if="article.link"
          :href="article.link"
          target="_blank"
          class="block"
        >
          <Title-Line :index="index" />
          <h2
            class="text-md md:text-2xl leading-tight mb-4"
            v-html="article.title"
          />
          <p class="text-base f-serif mb-16" v-text="article.description" />
        </a>
        <div v-else>
          <Title-Line :index="index" />
          <h2
            class="text-md md:text-2xl leading-tight mb-4"
            v-html="article.title"
          />
          <p class="text-base f-serif mb-16" v-text="article.description" />
        </div>
      </li>
    </ul>
  </div>
</template>

<script>
import TitleLine from '~/components/TitleLine'
export default {
  components: { TitleLine },
  props: {
    articles: {
      type: Array,
      required: true,
    },
  },
}
</script>
