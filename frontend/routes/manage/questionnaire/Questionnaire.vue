<template>
    <div>
        <div class="space-between">
            <h2>Responses</h2>
            <div>
                <router-link to="./message"><Button content="Message"></Button></router-link>
                <TextInput placeholder="Search bar..."></TextInput>
            </div>
        </div>
        <Table :rows="tableRows" :shownColumns="tableColumns" :showEditLink="true" @go-to-edit="goToEdit"></Table>
        <div class="space-between">
            <Dropdown name="Show n rows">
                <option selected>5</option>
                <option>20</option>
            </Dropdown>
        </div>
        <br>
        <div class="space-between">
            <h1>Questions</h1>
            <h2>(un)lock</h2>
        </div>
        <hr>
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
import Button    from "../../../components/base/Button.vue";
import Dropdown  from "../../../components/base/Dropdown.vue";
import TextArea  from "../../../components/base/TextArea.vue";
import TextInput from "../../../components/base/TextInput.vue";
import Table     from "../../../components/base/Table.vue";

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
                    firstName: "Claire",
                    lastName: "Gallup",
                    email: "claire.j.gallup@gmail.com",
                    status: "Confirmed",
                    checkedIn: "Yes",
                    appliedOn: "7/5/21",
                },
                {
                    id: 2,
                    firstName: "Claire",
                    lastName: "Gallup",
                    email: "claire.j.gallup@gmail.com",
                    status: "Confirmed",
                    checkedIn: "Yes",
                    appliedOn: "7/5/21",
                },
                {
                    id: 3,
                    firstName: "Claire",
                    lastName: "Gallup",
                    email: "claire.j.gallup@gmail.com",
                    status: "Confirmed",
                    checkedIn: "Yes",
                    appliedOn: "7/5/21",
                },
                {
                    id: 4,
                    firstName: "Claire",
                    lastName: "Gallup",
                    email: "claire.j.gallup@gmail.com",
                    status: "Confirmed",
                    checkedIn: "Yes",
                    appliedOn: "7/5/21",
                },
                {
                    id: 5,
                    firstName: "Claire",
                    lastName: "Gallup",
                    email: "claire.j.gallup@gmail.com",
                    status: "Confirmed",
                    checkedIn: "Yes",
                    appliedOn: "7/5/21",
                }
            ],
            tableColumns: {
                firstName: "First Name",
                lastName: "Last Name",
                email: "Email",
                status: "Status",
                checkedIn: "Checked In?",
                appliedOn: "Applied On",
            }
        }
    },
    methods: {
        goToEdit(event) {
            this.$router.push('/manage/questionnaire/edit/' + event.id);
        }
    }
}
</script>
<style lang="scss" scoped>
.space-between {
    display: flex;
    justify-content: space-between;
}
</style>
