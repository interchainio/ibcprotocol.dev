<template>
  <div>
    <div>
      <div class="border-gray border-t px-12">
        <Logo class="mx-auto w-full my-12" />
      </div>

      <div class="border-gray border-t border-b">
        <div class="uppercase flex items-center justify-between">
          <ul class="flex -mx-2 ml-8">
            <li class="mx-2">Documentation</li>
            <li class="mx-2">FAQ</li>
            <li class="mx-2">Forum</li>
            <li class="mx-2">Discord</li>
          </ul>
          <div class="flex items-center">
            <svg
              class="mx-8"
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
            <div class="border-l border-gray px-8 py-2">Search</div>
          </div>
        </div>
      </div>

      <div class="mx-auto px-12 max-w-6xl relative">
        <h1 class="text-5xl leading-tight uppercase my-32">
          <div>The industy standard protocol for</div>
          <div class="inline-block text-gradient">
            Inter&#8209;Blockchain<br />
            Communication
          </div>
        </h1>

        <nuxt-content
          class="f-serif max-w-2xl text-xl leading-relaxed"
          :document="page"
        />

        <div class="my-16 flex flex-col md:flex-row">
          <div><a class="button">Learn More</a></div>
          <div><a class="button mt-6 md:mt-0 md:ml-6">Documentation</a></div>
        </div>

        <img
          class="absolute right-0 top-0 mt-64"
          src="~/assets/images/illu-1.svg"
        />
      </div>
    </div>

    <News :articles="news" class="mx-auto px-12 max-w-6xl relative" />

    <div class="mx-auto px-12 max-w-6xl relative mt-16">
      <img src="~/assets/images/illu-2.svg" class="w-full" />
    </div>

    <Institutions :institutions="institutions" />

    <div class="mx-auto px-12 max-w-6xl relative py-16">
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
          subtitile: 'Forum',
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

<style scoped>
.text-gradient {
  background: -webkit-linear-gradient(
    -45deg,
    rgb(103, 115, 226),
    rgb(228, 106, 86)
  );
  -webkit-background-clip: text;
  background-clip: text;
  -webkit-text-fill-color: transparent;
}
</style>
