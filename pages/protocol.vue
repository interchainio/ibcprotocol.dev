<template>
  <div class="max-w-6xl mx-auto px-4 md:px-8">
    <div class="flex flex-col my-16 md:flex-row"></div>
    <div class="-mt-16 md:-mt-32">
      <h3 class="heading-sm mb-6">Core Logic</h3>
      IBC handles the creation of a handshake based connection and the
      authentication, transport, and ordering (TAO) of opaque data packets
      relayed between modules on separate ledgers. Ledgers can be run on solo
      machines, replicated by many nodes running a consensus algorithm, or
      constructed by any process whose state can be verified. The protocol is
      designed for safe simultaneous use between any number of modules on any
      number of ledgers connected in arbitrary topologies. The following are
      implementations of this core IBC logic:
      <div class="flex flex-col my-5 md:flex-row"></div>
      <div class="flex flex-wrap">
        <div class="flex flex-wrap md:-mx-4">
          <Card v-for="(item, idx) in page.public" :key="idx" :item="item" />
        </div>
      </div>
      <h3 class="heading-sm mb-6">Enterprise</h3>
      <div class="flex flex-wrap md:-mx-4">
        <Card v-for="(item, idx) in page.enterprise" :key="idx" :item="item" />
      </div>
    </div>
  </div>
</template>

<script>
export default {
  components: {},
  async asyncData({ $content }) {
    const page = await $content('implementations/protocol').fetch()

    return { page }
  },
}
</script>
