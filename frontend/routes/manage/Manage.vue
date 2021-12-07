<template>
    <div class="container">
        <ManageNavbar></ManageNavbar>

        <router-view></router-view>
    </div>
</template>

<script>
import ManageNavbar from '../../components/ManageNavbar.vue'

export default {
    name: 'Manage',
    components: {
        ManageNavbar
    }
}
</script>

<style lang="scss" scoped>
nav {
    padding: 3rem 0;
}
</style>
