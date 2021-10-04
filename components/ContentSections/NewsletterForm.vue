<template>
  <div
    class="
      fixed
      top-0
      left-0
      right-0
      bottom-0
      flex
      items-center
      justify-center
      bg-theme
      z-40
    "
  >
    <div
      class="fixed top-0 left-0 m-6 uppercase cursor-pointer hover:text-red"
      @click="$emit('close')"
    >
      Close
    </div>
    <div class="tm-section-container section-container bottom">
      <div class="container">
        <transition name="fade" mode="out-in">
          <div
            v-if="state === 'success'"
            key="success"
            class="bottom__state tm-rf0 tm-lh-copy"
          >
            <div class="bottom__get-notified">Almost there&hellip;</div>
            <div class="bottom__state__success">
              Check your inbox and confirm your email address
            </div>
          </div>
          <div
            v-else-if="state === 'error'"
            key="error"
            class="bottom__state tm-rf0 tm-lh-copy"
          >
            <div class="bottom__get-notified">Something went wrong</div>
            <div class="bottom__state__error">
              Uh oh! Refresh the page and try again.
            </div>
          </div>
          <div v-else key="default" class="bottom__form">
            <label
              class="bottom__get-notified tm-rf1 tm-bold tm-lh-copy"
              for="field-email"
            >
              Get Cosmos updates
            </label>
            <form
              :action="url"
              method="POST"
              target="_blank"
              rel="noreferrer noopener"
              @submit.prevent="actionSubmitEmail"
            >
              <div class="bottom__form__input">
                <input
                  id="field-email"
                  ref="email"
                  v-model="email"
                  name="fields[email]"
                  class="
                    bottom__form__input__input
                    w-64
                    bg-theme
                    text-theme
                    border-theme
                  "
                  type="email"
                  placeholder="Your email"
                  required="required"
                />
                <button
                  type="submit"
                  class="text-theme border border-theme p-3 border-l-0"
                >
                  OK
                </button>
              </div>
            </form>
            <p class="bottom__footnote tm-measure tm-rf-1 tm-lh-copy">
              Zero spam.
              <a href="https://cosmos.network/privacy">Privacy policy</a>
            </p>
          </div>
        </transition>
      </div>
    </div>
  </div>
</template>

<script>
import querystring from 'querystring'

export default {
  data() {
    return {
      email: null,
      state: 'default',
      url: 'https://app.mailerlite.com/webforms/submit/y2i9q3',
      formData: {
        callback: 'jQuery183003200065485233239_1594158714190',
        'ml-submit': '1',
        ajax: '1',
        guid: '6ca22b31-4124-e926-cf4f-272ff9f44ec3',
        _: '1594856022563',
      },
    }
  },
  mounted() {
    this.$nextTick(() => {
      this.$refs.email.focus()
    })
  },
  methods: {
    actionSubmitEmail() {
      const options = {
        method: 'POST',
        mode: 'no-cors',
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: querystring.stringify({
          'fields[email]': this.email,
          ...this.formData,
        }),
      }
      fetch(this.url, options)
        .then(() => {
          this.state = 'success'
        })
        .catch(() => {
          this.state = 'error'
        })
    },
  },
}
</script>

<style lang="css" scoped>
.bottom {
  .container {
    display: flex;
    justify-content: center;
  }

  &__get-notified {
    display: block;
    margin-bottom: var(--spacing-6);
    color: var(--white);
    text-align: center;
  }

  &__state {
    margin: var(--spacing-7) auto;

    &__success {
      color: var(--gray-600);
    }

    &__error {
      color: #ff4c52;
    }
  }

  &__form {
    margin: var(--spacing-7) auto;
    max-width: $max-width[ '7' ];
    width: 100%;

    &__input {
      display: flex;
      position: relative;
      align-items: center;
      justify-content: center;

      &__button {
        position: absolute;
        right: 0;
        width: 4rem;
        appearance: none;
        background: none;
        border: none;
        padding: var(--spacing-5);
        border-radius: $border-radius-3;
        cursor: pointer;
        outline: none;

        &:hover,
        &:focus {
          .bottom__form__input__icon {
            fill: var(--white);
            transform: scale(1.05);
          }
        }
      }

      &__icon {
        display: block;
        height: 2rem;
        fill: var(--gray-600);
        transition: fill 0.15s ease-out, transform 0.15s ease-out;
      }

      &__input {
        @apply border-light border p-3 my-2;
        outline: none;
        transition: color 0.15s ease-out, background 0.15s ease-out;

        &::placeholder {
          color: var(--gray-600);
          transition: color 0.15s ease-out;
        }
      }
    }
  }

  &__footnote {
    color: var(--gray-600);
    text-align: center;
    margin-top: var(--spacing-5);
  }
}

@media screen and (max-width: 576px) {
  .bottom {
    &__form {
      &__input {
        &__icon {
          height: 1.5rem;
        }
      }
    }
  }
}
</style>
