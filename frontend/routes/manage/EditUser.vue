<template>
    <div>
        <div id="title-bar">
            <h1>EditUser</h1>
            <div id="right">
                <Button content="Add User"></Button>
                <TextInput placeholder="Search..."></TextInput>
            </div>
        </div>
        <Table :rows="tableRows"></Table>
    </div>
</template>

<script>
import Table        from '../../components/base/Table.vue'
import ManageNavbar from '../../components/ManageNavbar.vue'
import Button       from '../../components/base/Button.vue';
import TextInput    from '../../components/base/TextInput.vue';

export default {
    name: 'EditUser',
    components: {
        ManageNavbar,
        Button,
        Table,
        TextInput
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

    #right {
        display: flex;
        align-items: flex-start;
    }

</style>
