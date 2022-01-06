<template>
    <div>
        <div class="space-between">
            <h2>{{ $t("pages.manage.questionnaire.responses") }}</h2>
            <div class="row width-auto">
                <router-link to="./message"><Button :content="$t('pages.manage.questionnaire.messageButton')"></Button></router-link>
                <TextInput :placeholder="$t('pages.manage.questionnaire.searchbar')"></TextInput>
            </div>
        </div>
        <Table :rows="tableRows" :shownColumns="tableColumns" :showEditLink="true" @go-to-edit="goToEdit"></Table>
        <div class="space-between">
            <Dropdown name="rows">
                <option selected>5</option>
                <option>20</option>
            </Dropdown>
        </div>
        <br>
        <div class="space-between">
            <h1>{{ $t("pages.manage.questionnaire.questions.title") }}</h1>
            <div>
                <h2>{{ $t("pages.manage.questionnaire.questions.unlock") }}</h2>
            </div>
        </div>
        <hr>
        <p>{{ $t("pages.manage.questionnaire.questions.warning") }}</p>
        <br>
        <h2>{{ $t("pages.manage.questionnaire.questions.defaultQuestions") }}</h2>
        <TextArea placeholder="Bee"></TextArea>
        <br>
        <h2>{{ $t("pages.manage.questionnaire.questions.optionalQuestions") }}</h2>
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
    name: 'Questionnaire',
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
.width-auto {
    width: auto;
}
</style>
