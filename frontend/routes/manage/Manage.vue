<template>
    <div>
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
