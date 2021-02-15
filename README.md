# ibc

## Build Setup

```bash
# install dependencies
$ yarn install

# serve with hot reload at localhost:3000
$ yarn dev

# build for production and launch server
$ yarn build
$ yarn start

# generate static project
$ yarn generate
```

## Content Structure

### News
- News items are added in the `/content/news` subfolder
- News items are sorted by the `date` frontmatter

### Documentation
- The `/content/documentation/content.md` file contains corresponding items for the documentation page.
- As the documentation grows, it may make sense to break each piece into separate files

### FAQ
- Each question is a corresponding markdown file in `/content/faq`
- FAQ items are ordered by the `order` frontmatter
- The TOC for the FAQ is automatically generated

For detailed explanation on how things work, check out [Nuxt.js docs](https://nuxtjs.org).
