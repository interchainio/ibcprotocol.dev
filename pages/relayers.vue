<template>
  <div class="max-w-6xl mx-auto px-4 md:px-8">
    <div class="flex flex-col my-16 md:flex-row"></div>
    <div class="-mt-16 md:-mt-32">
      <h3 class="heading-sm mb-6">Relayers</h3>
      In the IBC architecture, blockchains are not directly sending messages to
      each other over networking infrastructure, but rather are creating
      messages to be sent which are then physically relayed from one ledger to
      another by monitoring “relayer processes”. These relayers continuously
      scan the state of ledgers that implement the IBC protocol and relay
      packets when these packets are present. This enables transaction execution
      on connected ledgers when outgoing packets relayed over have been
      committed. Relayers CANNOT modify IBC packets, as each IBC packet is
      verified using light-clients by the receiving chain before being
      committed. Running relayers is open to everyone, and may be rewarded with
      a small transaction fee depending on the implementation of each ledger.
      The following relayer implementations are available for usage:
      <div class="flex flex-col my-5 md:flex-row"></div>
      <div class="flex flex-wrap">
        <div
          v-for="(item, index) in page.public"
          :key="item.slug"
          class="w-full md:w-1/2 pr-0 md:pr-16 mb-12 md:mb-0"
          :class="{ 'opacity-25': item.value === null }"
        >
          <Title-Line :index="index" />
          <a
            :href="item.link"
            target="_blank"
            class="relative flex w-full justify-between"
          >
            <h2 class="text-lg md:text-2xl mb-3">{{ item.title }}</h2>
          </a>
          <p v-if="item.description">{{ item.description }}</p>
          <br />
          <br />
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import TitleLine from '~/components/TitleLine'
export default {
  components: { TitleLine },
  async asyncData({ $content }) {
    const page = await $content('implementations/relayers').fetch()

    return { page }
  },
}
</script>
