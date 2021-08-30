<template>
  <div>Home component</div>
  <p>{{ $t("message.hello") }}</p>
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