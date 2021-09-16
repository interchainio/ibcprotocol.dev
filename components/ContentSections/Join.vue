<template>
  <div class="mx-auto max-w-7xl">
    <h1 class="text-lg md:text-3xl text-center uppercase mb-24">
      Join the community
    </h1>
    <div
      class="flex flex-col md:flex-row justify-center mx-auto max-w-7xl px-8 md:px-12"
    >
      <div
        v-for="(c, index) in content.community"
        :key="index"
        class="w-full md:w-1/3 speech-bubble"
        :class="{
          'pt-16 md:pt-16': index === 1,
          'pt-16 md:pt-32': index === 2,
        }"
      >
        <div class="container border border-gray box-tall">
          <a
            :href="c.link"
            target="_blank"
            class="relative flex w-full justify-between"
          >
            <div class="p-6">
              <div class="uppercase leading-tight mb-8 text-xl">
                {{ c.title }}
              </div>
              <div class="f-serif">{{ c.subtitle }}</div>
            </div>
            <div>
              <span
                class="box-link w-16 h-16 flex justify-center items-center bg-contrast"
              >
                <Arrow />
                <!-- <img :src="c.icon" class="w-2/3" /> -->
              </span>
            </div>
          </a>
        </div>
      </div>
      <div class="w-full md:w-1/3 speech-bubble pt-16 md:pt-32">
        <div
          class="container border border-gray box-tall relative cursor-pointer"
        >
          <div class="p-6 hover:text-red" @click="showForm = true">
            <div class="uppercase leading-tight mb-8 text-xl">Get Updates</div>
            <div class="f-serif">Sign up to the newsletter</div>
          </div>
          <div class="absolute top-0 right-0">
            <span
              class="box-link w-16 h-16 flex justify-center items-center bg-contrast"
            >
              <Arrow />
            </span>
          </div>
        </div>
      </div>
    </div>
    <transition name="fade">
      <NewsletterForm v-if="showForm" @close="showForm = false" />
    </transition>
  </div>
</template>

<script>
import NewsletterForm from '~/components/ContentSections/NewsletterForm'

export default {
  components: { NewsletterForm },

  props: {
    content: {
      type: Object,
      required: true,
    },
  },

  data() {
    return {
      showForm: false,
    }
  },

  computed: {
    isNarrow() {
      return window.innerWidth < 768
    },
  },
}
</script>

<style scoped>
.box-tall {
  height: 180px;
}

.speech-bubble {
  &:not(:first-child) {
    margin-left: -1px;
  }
}

.box-link {
  @apply bg-white;
}

#app {
  .arrow {
    -webkit-filter: invert(1);
    filter: invert(1);
  }

  .container:after {
    border-color: #fff1f1 transparent transparent #fff1f1;
  }

  .container:before {
    border-color: #323232 transparent transparent #323232;
  }

  &.darkmode {
    .container:after {
      border-color: #323232 transparent transparent #323232;
    }

    .container:before {
      border-color: #fff1f1 transparent transparent #fff1f1;
    }
  }
}
</style>
