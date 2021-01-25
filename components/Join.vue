<template>
  <div class="mx-auto max-w-7xl">
    <h1 class="text-lg md:text-3xl text-center uppercase mb-24">
      Join the community
    </h1>
    <div
      class="flex flex-col md:flex-row justify-center mx-auto max-w-7xl px-8 md:px-12"
    >
      <div
        v-for="(c, index) in community"
        :key="index"
        class="w-full md:w-1/3 speech-bubble"
        :class="{
          'pt-16 md:pt-16': index === 1,
          'pt-16 md:pt-32': index === 2,
        }"
      >
        <div
          class="container relative flex border border-gray justify-between w-full box-tall"
        >
          <div class="p-6">
            <div class="uppercase leading-tight mb-8 text-xl">
              {{ c.title }}
            </div>
            <div class="f-serif">{{ c.subtitle }}</div>
          </div>
          <div>
            <a
              class="box-link w-16 h-16 flex justify-center items-center bg-theme"
              :href="c.link"
            >
              <Arrow />
            </a>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  props: {
    community: {
      type: Array,
      required: true,
    },
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
