<template>
  <div>
    <div class="mx-auto w-full flex justify-center">
      <div
        class="flex justify-center items-center overflow-visible w-0 h-0 rotated"
      >
        <div class="w-screen border-t border-b border-white">
          <Ticker />
        </div>
      </div>
    </div>
    <div
      class="flex flex-col md:flex-row justify-between md:items-end pt-16 lg:pt-8"
    >
      <img
        class="p-12 w-2/3 md:w-1/3 xl:w-1/2"
        src="~/assets/images/footer-logo.svg"
      />
      <div class="p-12 uppercase text-xs md:text-sm text-right">
        <div>INTER-BLOCKCHAIN COMMUNICATION</div>
        <div>
          <span class="mr-4">Documentation</span>
          <span class="mr-4">faq</span>
          <span class="mr-4">forum</span>
          <span>discord</span>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import Ticker from '~/components/Ticker'

export default {
  components: { Ticker },
}
</script>

<style scoped>
.rotated {
  transform: rotate(-174.65deg);
}
</style>
