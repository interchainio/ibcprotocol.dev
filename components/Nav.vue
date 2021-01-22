<template>
  <div
    class="nav border-gray border-t border-b overflow-hidden sticky top-0 z-40"
  >
    <div class="uppercase flex items-center justify-between">
<<<<<<< Updated upstream
      <ul class="flex -mx-2 items-center">
        <li class="px-8 py-3 border-r flex items-center">
          <NuxtLink to="/" class="font-bold text-light:important">IBC</NuxtLink>
        </li>
        <li class="mx-2 py-2">
          <NuxtLink to="/documentation" class="mx-2">Documentation</NuxtLink>
        </li>
        <li class="mx-2 py-2">
          <NuxtLink to="/faq" class="mx-2">FAQ</NuxtLink>
=======
      <ul class="flex items-center">
        <li class="px-10 py-4 border-r flex items-center">
          <NuxtLink to="/" class="font-bold">IBC</NuxtLink>
        </li>
        <li class="mx-8 py-4">
          <NuxtLink to="/documentation">Documentation</NuxtLink>
        </li>
        <li class="py-4">
          <NuxtLink to="/faq">FAQ</NuxtLink>
>>>>>>> Stashed changes
        </li>
      </ul>
      <div class="flex items-center">
        <svg
          class="mx-8 cursor-pointer"
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
      </div>
    </div>
  </div>
</template>
