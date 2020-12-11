<template>
  <div class="mt-32">
    <h1 class="text-3xl uppercase mb-4">News</h1>
    <ul class="flex flex-wrap">
      <li
        v-for="(article, index) in articles"
        :key="index"
        class="w-full md:w-1/2 pr-0 md:pr-16"
      >
        <div
          class="title-line mb-4"
          :class="
            index === 0 || index === 3 ? 'bg-gradientRed' : 'bg-gradientPurple'
          "
        ></div>
        <h2 class="text-xl mb-4" v-html="article.title" />
        <p class="text-base f-serif mb-16" v-html="article.description" />
      </li>
    </ul>
  </div>
</template>

<script>
export default {
  props: {
    articles: {
      type: Array,
      required: true,
    },
  },
}
</script>

<style scoped>
.title-line {
  width: 90px;
  height: 1px;
}

.red {
}
</style>
