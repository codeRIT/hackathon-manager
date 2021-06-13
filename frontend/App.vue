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