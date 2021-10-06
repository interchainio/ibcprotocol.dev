<template>
  <div class="nav border-gray border-t border-b sticky top-0 z-40">
    <div class="uppercase flex items-center justify-between">
      <ul class="flex items-center">
        <li class="px-6 md:px-12 py-4 md:py-6 border-r flex items-center">
          <NuxtLink id="logo-nav" to="/"><span>IBC</span></NuxtLink>
        </li>
        <li class="hidden md:inline-block mx-8 py-6">
          <NuxtLink to="/implementations" class="inline-flex">
            Implementations & Docs
            <svg
              class="-mr-1 ml-2 h-5 w-5"
              xmlns="http://www.w3.org/2000/svg"
              viewBox="0 0 20 20"
              fill="currentColor"
              aria-hidden="true"
            >
              <path
                fill-rule="evenodd"
                d="M5.293 7.293a1 1 0 011.414 0L10 10.586l3.293-3.293a1 1 0 111.414 1.414l-4 4a1 1 0 01-1.414 0l-4-4a1 1 0 010-1.414z"
                clip-rule="evenodd"
              />
            </svg>
          </NuxtLink>
        </li>
        <li class="hidden md:inline-block mx-8 py-6">
          <NuxtLink to="/documentation">Protocol Specs</NuxtLink>
        </li>
        <li class="hidden md:inline-block mx-8 py-6">
          <NuxtLink to="/tutorials">Tutorials</NuxtLink>
        </li>
        <li class="hidden md:inline-block mx-8 py-6">
          <NuxtLink to="/community">Community</NuxtLink>
        </li>
      </ul>
      <div class="flex items-center">
        <svg
          class="mx-3 md:mx-8 cursor-pointer"
          width="16"
          height="16"
          viewBox="0 0 16 16"
          fill="none"
          xmlns="http://www.w3.org/2000/svg"
          @click="$nuxt.$emit('toggle-dark-mode')"
        >
          <circle cx="8" cy="8" r="7.5" class="stroke" />
          <path
            d="M15.5 8C15.5 11.9741 12.409 15.2263 8.5 15.4836V0.516402C12.409 0.773695 15.5 4.02588 15.5 8Z"
            class="fill stroke"
            stroke="#FFF1F1"
          />
        </svg>
        <div
          class="md:hidden mx-4 cursor-pointer"
          @click="showMenu = !showMenu"
        >
          <Hamburger v-if="!showMenu" />
          <Close v-else class="cursor-pointer" />
        </div>
      </div>
    </div>
    <div class="relative">
      <transition name="fade">
        <div
          v-if="showMenu"
          class="
            bg-theme
            text-theme
            absolute
            border-t
            top-0
            left-0
            w-screen
            h-screen
            z-40
          "
        >
          <ul class="p-6">
            <li class="mb-3">
              <NuxtLink to="/implementations">Implementations</NuxtLink>
            </li>
            <li class="mb-3">
              <NuxtLink to="/documentation">Protocol Specs</NuxtLink>
            </li>
            <li class="mb-3">
              <NuxtLink to="/tutorials">Tutorials</NuxtLink>
            </li>
            <li class="mb-3">
              <NuxtLink to="/community">Community</NuxtLink>
            </li>
          </ul>
        </div>
      </transition>
    </div>
  </div>
</template>

<script>
import Hamburger from '~/components/Icons/Hamburger'
import Close from '~/components/Icons/Close'

export default {
  components: {
    Hamburger,
    Close,
  },
  data() {
    return {
      showMenu: false,
    }
  },
  watch: {
    $route() {
      this.showMenu = false
    },
  },
}
</script>

<style lang="css">
#app #logo-nav {
  @apply text-dark;
}

#app.darkmode #logo-nav {
  @apply text-light;
}
</style>
