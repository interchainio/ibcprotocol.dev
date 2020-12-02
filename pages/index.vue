<template>
  <div>
    <div class="border-gray border-t">
      <Logo class="mx-auto my-12" />
    </div>

    <div class="border-gray border-t border-b">
      <div
        class="max-w-6xl mx-auto uppercase flex items-center justify-between"
      >
        <ul class="flex -mx-2">
          <li class="mx-2">Documentation</li>
          <li class="mx-2">FAQ</li>
          <li class="mx-2">Forum</li>
          <li class="mx-2">Discord</li>
        </ul>
        <div class="flex">
          <svg
            width="16"
            height="16"
            viewBox="0 0 16 16"
            fill="none"
            xmlns="http://www.w3.org/2000/svg"
          >
            <circle cx="8" cy="8" r="7.5" stroke="#FFF1F1" />
            <path
              d="M15.5 8C15.5 11.9741 12.409 15.2263 8.5 15.4836V0.516402C12.409 0.773695 15.5 4.02588 15.5 8Z"
              fill="#FFF1F1"
              stroke="#FFF1F1"
            />
          </svg>
          <div class="border-l border-gray px-8 py-2">EN</div>
        </div>
      </div>
    </div>
    <nuxt-content :document="page" />
  </div>
</template>

<script>
export default {
  async asyncData({ $content }) {
    const page = await $content('index').fetch()
    return { page }
  },
}
</script>
