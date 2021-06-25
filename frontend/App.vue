<template>
    <div>Hello {{ name }}!</div>

    <router-link to="/">Go to Home</router-link>
    <router-link to="/about">Go to About</router-link>

    <router-view></router-view>
</template>

<script>
export default {
    data() {
        return {
            name: "Vue",
        };
    },  
};
</script>

<style lang="scss">
// CSS reset largely copied from Tailwind CSS's Preflight: https://tailwindcss.com/docs/preflight

body {
    font-family: sans-serif;
}

body,
blockquote,
dl,
dd,
h1,
h2,
h3,
h4,
h5,
h6,
hr,
figure,
p,
pre {
  margin: 0;
}

h1,
h2,
h3,
h4,
h5,
h6 {
  font-weight: inherit;
}

ol,
ul {
  list-style: none;
  margin: 0;
  padding: 0;
}

img,
svg,
video,
canvas,
audio,
iframe,
embed,
object {
  display: block;
  vertical-align: middle;
}
</style>