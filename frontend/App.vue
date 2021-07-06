<template>
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

a {
  color: initial;
  text-decoration: none;
}
</style>