<template>
    <div>
        <nav>
            <router-link class="router-link" to="/">Home</router-link>
            <router-link class="router-link" to="/about">About</router-link>
            <router-link class="router-link" to="/profile">Profile</router-link>
            <router-link class="router-link" to="/manage">Manage</router-link>
        </nav>
        <div id="router">
            <router-view></router-view>
        </div>
    </div>
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
            api: new API()  // Other pages/components can inject this object: `inject: ['api']`
        }
    }
}
</script>

<style lang="scss">

nav {
    display: inline-block;
    padding: 30px;
    .router-link {
        border: 3px solid gray;
        border-radius: 6px;
        padding: 10px;
        margin-right: 30px;
    }
}

#router {
    padding: 0 100px;
    margin: 5%;
}

</style>
