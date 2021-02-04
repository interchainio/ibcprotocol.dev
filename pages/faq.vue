<template>
  <div class="max-w-6xl mx-auto px-4 md:px-8">
    <img class="ml-auto mt-12" src="~/assets/images/illu-5.svg" />
    <div class="content -mt-24 max-w-xl mx-6 lg:mx-0">
      <div v-for="(item, idx) in items" :key="idx">
        <span :id="item.slug" class="section-marker"></span>
        <h1 class="heading-sm">{{ item.title }}</h1>
        <TitleLine :index="idx" class="mt-6" />
        <nuxt-content class="f-serif max-w-prose" :document="item" />
      </div>
      <span id="bottom"></span>
    </div>

    <transition name="fade">
      <div
        v-if="showTOC"
        class="hidden lg:block toc fixed right-0 bottom-0 mb-8 mr-8 text-sm uppercase w-56"
      >
        <ul>
          <li
            v-for="(item, idx) in items"
            :key="idx"
            class="mb-3 leading-tight"
          >
            <a
              v-scroll-to="{ el: `#${item.slug}`, offset: -150, duration: 300 }"
              :href="`#${item.slug}`"
              :class="{
                'text-red': activeItem === item.slug || activeItem === idx,
              }"
              >{{ item.title }}</a
            >
          </li>
        </ul>
      </div>
    </transition>
  </div>
</template>

<script>
import { throttle } from 'lodash'
import TitleLine from '~/components/TitleLine'

export default {
  components: { TitleLine },
  async asyncData({ $content }) {
    const items = await $content('faq').sortBy('order').fetch()

    return { items }
  },
  data() {
    return {
      showTOC: true,
      activeItem: 0,
      TOCListener: null,
    }
  },
  watch: {
    items() {
      this.activeItem = this.items[0].slug
    },
  },
  mounted() {
    window.addEventListener('scroll', this.onScroll)
  },
  destroyed() {
    window.removeEventListener('scroll', this.onScroll)
  },
  methods: {
    bottom() {
      const rect = document.getElementById('bottom').getBoundingClientRect()
      return (
        rect.top < (window.innerHeight || document.documentElement.clientHeight)
      )
    },
    throttleOnScroll() {
      throttle(this.onScroll, 100)
    },
    onScroll() {
      if (document.scrollTop < 300) {
        this.activeItem = 0
      } else {
        Array.from(document.querySelectorAll('.section-marker')).map((el) => {
          if (this.elInView(el)) {
            this.activeItem = el.getAttribute('id')
          }
        })

        if (this.bottom()) {
          this.showTOC = false
        } else {
          this.showTOC = true
        }
      }
    },
    elInView(el) {
      const rect = el.getBoundingClientRect()
      return (
        rect.top <=
        (window.innerHeight / 3 || document.documentElement.clientHeight / 3)
      )
    },
  },
}
</script>

<style lang="css" scoped>
.content {
  >>> a {
    text-decoration: underline !important;
  }

  >>> ol,
  >>> ul {
    @apply mb-3;
  }

  >>> li {
    @apply mb-3;
  }
}

.toc {
  li:last-child {
    @apply mb-0;
  }
}
</style>
