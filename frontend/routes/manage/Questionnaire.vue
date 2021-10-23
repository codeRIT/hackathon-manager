<template>
    <div>
        <div class="space-between">
            <h1>Responses</h1>
            <div>
                <router-link to="./message"><Button content="Message"></Button></router-link>
                <TextInput placeholder="Search bar..."></TextInput>
            </div>
        </div>
        <Table :rows="tableRows" :showPagination="true" editLink="./edit"></Table>
        <br>
        <div class="space-between">
            <h1>Questions</h1>
            <p>(un)lock</p>
        </div>
        <hr>
        <br>
        <p>Warning: this affects all hackers...</p>
        <p>[big text input]</p>
    </div>
</template>

<script>
    import Button    from "../../components/base/Button.vue";
    import TextInput from "../../components/base/TextInput.vue";
    import Table     from "../../components/base/Table.vue";

    export default {
        components: {
            Button,
            TextInput,
            Table
        },
        data() {
            return {
                name: "Questionnaire",
                tableRows: [
                    {
                        "First Name": "Claire",
                        "Last Name": "Gallup",
                        "Email": "claire.j.gallup@gmail.com",
                        "Status": "Confirmed",
                        "Checked In?": "Yes",
                        "Applied On": "7/5/21",
                    },
                    {
                        "First Name": "Claire",
                        "Last Name": "Gallup",
                        "Email": "claire.j.gallup@gmail.com",
                        "Status": "Confirmed",
                        "Checked In?": "Yes",
                        "Applied On": "7/5/21",
                    },
                    {
                        "First Name": "Claire",
                        "Last Name": "Gallup",
                        "Email": "claire.j.gallup@gmail.com",
                        "Status": "Confirmed",
                        "Checked In?": "Yes",
                        "Applied On": "7/5/21",
                    },
                    {
                        "First Name": "Claire",
                        "Last Name": "Gallup",
                        "Email": "claire.j.gallup@gmail.com",
                        "Status": "Confirmed",
                        "Checked In?": "Yes",
                        "Applied On": "7/5/21",
                    },
                    {
                        "First Name": "Claire",
                        "Last Name": "Gallup",
                        "Email": "claire.j.gallup@gmail.com",
                        "Status": "Confirmed",
                        "Checked In?": "Yes",
                        "Applied On": "7/5/21",
                    }
                ]
            }
        },
    };
</script>

<style lang="scss" scoped>
.space-between {
    display: flex;
    justify-content: space-between;
}
</style>