<template>
    <div>
        <div class="space-between">
            <h1>Responses</h1>
            <div>
                <router-link to="./message"><Button content="Message"></Button></router-link>
                <TextInput placeholder="Search bar..."></TextInput>
            </div>
        </div>
        <Table :rows="tableRows" :shownColumns="tableColumns"></Table>
        <div class="space-between">
            <Dropdown name="Show n rows">
                <option selected>5</option>
                <option>20</option>
            </Dropdown>
        </div>
        <br>
        <div class="space-between">
            <h1>Questions</h1>
            <p>(un)lock</p>
        </div>
        <hr>
        <br>
        <p>Warning: this affects all hackers...</p>
        <br>
        <h2>Default questions</h2>
        <TextArea placeholder="Bee"></TextArea>
        <br>
        <h2>Optional questions</h2>
        <TextArea placeholder="Bee"></TextArea>
    </div>
</template>

<script>
    import Button    from "../../components/base/Button.vue";
    import Dropdown  from "../../components/base/Dropdown.vue";
    import TextArea  from "../../components/base/TextArea.vue";
    import TextInput from "../../components/base/TextInput.vue";
    import Table     from "../../components/base/Table.vue";

    export default {
        components: {
            Button,
            Dropdown,
            TextArea,
            TextInput,
            Table
        },
        data() {
            return {
                name: "Questionnaire",
                tableRows: [
                    {
                        id: 1,
                        title: "lorem ipsum",
                        description: "dolor sit amet"
                    },
                    {
                        id: 2,
                        title: "lorem ipsum",
                        description: "dolor sit amet"
                    },
                    {
                        id: 3,
                        title: "lorem ipsum",
                        description: "dolor sit amet"
                    },
                    {
                        id: 4,
                        title: "lorem ipsum",
                        description: "dolor sit amet"
                    },
                    {
                        id: 5,
                        title: "lorem ipsum",
                        description: "dolor sit amet"
                    }
                ],
                tableColumns: {
                    description: "Description",
                    title: "Title"
                }
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