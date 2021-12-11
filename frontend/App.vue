<template>
    <router-view></router-view>
</template>

<script>
import API from "./api.js"

export default {
    data() {
        return {
            name: "Vue",
        };
    },
    provide() {
        return {
            api: new API()  // TODO: pull JWT token from cookies
            // Other pages/components can now inject the API object: `inject: ['api']`
        }
    }
}
</script>
