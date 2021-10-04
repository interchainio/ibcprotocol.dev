<template>
  <div class="mx-auto max-w-7xl">
    <div
      class="
        flex flex-col
        md:flex-row
        justify-center
        items-center
        mx-auto
        max-w-7xl
        px-12
      "
    >
      <div
        v-for="(c, index) in content.implementations"
        :key="index"
        class="w-full speech-bubble"
        :class="{
          //   'pt-16 md:pt-16': index === 1,
          //   'pt-16 md:pt-32': index === 2,
          //   'pt-16 md:pt-32': index === 3,
        }"
      >
        <div class="container border border-gray box-tall">
          <a :href="c.link" class="relative flex w-full justify-between">
            <div class="p-6">
              <div class="uppercase leading-tight mb-8 text-xl">
                {{ c.title }}
              </div>
              <div class="f-serif">{{ c.subtitle }}</div>
            </div>
            <div>
              <span
                class="
                  box-link
                  w-16
                  h-16
                  flex
                  justify-center
                  items-center
                  bg-contrast
                "
              >
                <Arrow />
              </span>
            </div>
          </a>
        </div>
      </div>
      <div class="w-full md:w-1/3 speech-bubble pt-16 md:pt-32"></div>
    </div>
  </div>
</template>

<script>
export default {
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
