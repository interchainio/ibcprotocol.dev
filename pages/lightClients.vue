<template>
  <div class="max-w-6xl mx-auto px-4 md:px-8">
    <div class="flex flex-col my-16 md:flex-row"></div>
    <div class="-mt-16 md:-mt-32">
      <h3 class="heading-sm mb-6">Light Clients</h3>
      IBC Clients are light clients (identified by a unique client-id) that
      track the consensus states of other blockchains, along with the proof spec
      necessary to properly verify proofs against the client's consensus state.
      A client may be associated with any number of connections to multiple
      chains. Supported IBC clients are:
      <div class="flex flex-col my-4 md:flex-row"></div>
      <div class="flex flex-wrap">
        <div class="flex flex-wrap md:-mx-4">
          <Card v-for="(item, idx) in page.public" :key="idx" :item="item" />
        </div>
      </div>

      <h3 class="heading-sm mb-6">Enterprise</h3>
      <div class="flex flex-wrap">
        <div class="flex flex-wrap md:-mx-4">
          <Card
            v-for="(item, idx) in page.enterprise"
            :key="idx"
            :item="item"
          />
        </div>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  components: {},
  async asyncData({ $content }) {
    const page = await $content('implementations/lightClients').fetch()

    return { page }
  },
}
</script>
