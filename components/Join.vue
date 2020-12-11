<template>
  <div class="mx-auto max-w-6xl">
    <h1 class="text-lg md:text-3xl text-center uppercase mb-24">
      Join the community
    </h1>
    <div
      class="flex flex-col md:flex-row justify-center mx-auto max-w-5xl px-8 md:px-12"
    >
      <div
        v-for="(c, index) in community"
        :key="index"
        class="w-full md:w-1/3"
        :class="{
          'pt-16 md:pt-16': index === 1,
          'pt-16 md:pt-32': index === 2,
        }"
      >
        <div
          class="container relative flex border border-gray justify-between w-full box-tall"
        >
          <div class="p-6">
            <div class="uppercase text-sm mb-8">{{ c.title }}</div>
            <div class="text-xs">{{ c.subtitle }}</div>
          </div>
          <div>
            <a
              class="box-link w-16 h-16 flex justify-center items-center"
              :href="c.link"
            >
              <img class="arrow" src="~/assets/images/arrow.svg" />
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

/* this CS forms the triangles */
.container:after,
.container:before {
  content: '';
  display: block;
  position: absolute;
  left: 100%;
  width: 0;
  height: 0;
  border-style: solid;
}

.container:after {
  left: 43px;
  bottom: -48px;
  border-color: #323232 transparent transparent #323232;
  border-width: 24px;
}

.container:before {
  left: 42px;
  bottom: -50px;
  border-color: #fff1f1 transparent transparent #fff1f1;
  border-width: 25px;
}

.box-link {
  @apply bg-white;
}

@media (prefers-color-scheme: light) {
  .box-link {
    @apply bg-dark;
  }

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
}
</style>
