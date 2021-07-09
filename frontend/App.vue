<template>
    <router-view></router-view>
</template>

<script>
import API from "./services/api"

export default {
    data() {
        return {
            name: "Vue",
        };
    },

    provide() {
        return {
            "api": new API()
        }
    }
};
</script>

<style lang="scss">
@import './assets/scss/style.scss'
</style>