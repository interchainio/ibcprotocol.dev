<template>
  <div>
    <div>
      <div class="mx-auto px-8 md:px-12 max-w-6xl relative">
        <h1 class="heading">
          <div>The industy standard<br />protocol for</div>
          <div class="inline-block text-gradient">
            Inter&#8209;Blockchain<br />
            Communication
          </div>
        </h1>

        <nuxt-content
          class="f-serif max-w-2xl text-md md:text-xl leading-relaxed"
          :document="page"
        />

        <div class="my-16 flex flex-col md:flex-row">
          <div><a class="button">Learn More</a></div>
          <div><a class="button mt-6 md:mt-0 md:ml-6">Documentation</a></div>
        </div>

        <img
          class="absolute right-0 top-0 mt-64 opacity-25 md:opacity-100"
          src="~/assets/images/illu-1.svg"
        />
      </div>
    </div>

    <News :articles="news" class="mx-auto px-8 md:px-12 max-w-6xl relative" />

    <div class="mx-auto px-8 md:px-12 max-w-6xl relative mt-16">
      <img src="~/assets/images/illu-2.svg" class="w-full" />
    </div>

    <Institutions :institutions="institutions" />

    <div class="mx-auto px-8 md:px-12 max-w-6xl relative py-16">
      <img src="~/assets/images/illu-3.svg" class="w-full" />
    </div>

    <div class="mx-auto max-w-6xl relative">
      <Join :community="community" />
    </div>

    <div class="mt-48">
      <Footer />
    </div>
  </div>
</template>

<script>
import News from '~/components/News'
import Institutions from '~/components/Institutions'
import Join from '~/components/Join'
import Footer from '~/components/Footer'

export default {
  components: { News, Institutions, Join, Footer },

  async asyncData({ $content }) {
    const page = await $content('index/intro').fetch()

    const news = await $content('news')
      .only(['title', 'description'])
      .limit(4)
      .sortBy('date', 'desc')
      .fetch()

    return { page, news }
  },

  data() {
    return {
      institutions: [
        {
          name: 'Agoric',
          link: 'https://agoric.com/',
        },
        {
          name: 'Interchain Foundation',
          link: 'https://interchain.io/',
        },
        {
          name: 'Interchain Berlin',
          link: 'https://interchain.berlin/',
        },
        {
          name: 'Tendermint',
          link: 'https://tendermint.com/',
        },
        {
          name: 'Informal Systems',
          link: 'https://informal.systems/',
        },
        {
          name: 'iqlusion',
          link: 'https://www.iqlusion.io/',
        },
      ],

      community: [
        {
          title: 'Chat with IBC Developers',
          subtitle: 'Community Discord',
          link: '#',
        },
        {
          title: 'Discuss IBC',
          subtitle: 'Forum',
          link: '#',
        },
        {
          title: 'Enter Email for Updates',
          subtitle: 'Zero Spam. Privacy Policy',
          link: '#',
        },
      ],
    }
  },
}
</script>
