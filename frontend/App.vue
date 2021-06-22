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
body {
    margin: 0;
}

h1, h2, h3, h4, h5, h6, p {
    margin: 0;
}
</style>