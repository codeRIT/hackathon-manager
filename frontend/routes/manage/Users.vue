<template>
    <div>
        <div id="title-bar">
            <h1>Users and Staff</h1>
            <Button content="Add User"></Button>
            <TextInput placeholder="Search..."></TextInput>
        </div>
        <Table :rows="tableRows"></Table>
    </div>
</template>

<script>
import Table        from '../../components/base/Table.vue'
import ManageNavbar from '../../components/ManageNavbar.vue'
import Button       from '../../components/base/Button.vue';

export default {
    name: 'Users',
    components: {
        ManageNavbar,
        Button,
        Table
    },
    props: {
        rows: Array,
        editLink: String,
        paginated: Boolean,
        pageSize: Number
    },
    data () {
        return {
            pageNumber: 0,
            tableRows: [
                    {
                        "first_name"   : "lorem ipsum",
                        "last_name"    : "lorem ipsum",
                        "email"        : "lorem ipsum",
                        "role"         : "lorem ipsum",
                        "login_access" : "lorem ipsum",
                        "created_on"   : "lorem ipsum"
                    },
                    {
                        "first_name"   : "lorem ipsum",
                        "last_name"    : "lorem ipsum",
                        "email"        : "lorem ipsum",
                        "role"         : "lorem ipsum",
                        "login_access" : "lorem ipsum",
                        "created_on"   : "lorem ipsum"
                    }
            ]
        }
    },
}
</script>

<style lang="scss">

    #title-bar {
        display: flex;
        justify-content: space-between;
        margin-bottom: 10px;
    }

</style>
