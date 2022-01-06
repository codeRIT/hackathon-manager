<template>
    <div>
        <div class="space-between">
            <h1>{{ applicant }}</h1>
            <h3>{{ $t("pages.manage.questionnaire.editApplicant.title") }}</h3>
        </div>
        <hr>
        <h2>Check in Compliance</h2>
        <TextArea></TextArea>
    </div>
</template>

<script>
import TextArea from "../../../components/base/TextArea.vue";

export default {
    name: 'EditApplicant',
    components: {
        TextArea,
    },
    data() {
        return {
            applicant: "Claire Gallup",
        }
    },
};
</script>
