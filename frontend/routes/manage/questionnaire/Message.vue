<template>
    <div>
        <h1>{{ $t("pages.manage.questionnaire.message.title") }}</h1>
        <hr>
        <TextInput :placeholder="$t('pages.manage.questionnaire.message.subject')"></TextInput>
        <div class="row">
            <div class="col-12">
                <Dropdown>
                    <option selected>Bee</option>
                    <option>2</option>
                </Dropdown>
                <TextArea></TextArea>
                <Button :content="$t('pages.manage.questionnaire.message.send')"></Button>
            </div>
        </div>
    </div>
</template>

<script>
import Button    from "../../../components/base/Button.vue";
import Dropdown  from "../../../components/base/Dropdown.vue";
import TextArea from "../../../components/base/TextArea.vue";
import TextInput from "../../../components/base/TextInput.vue";

export default {
    name: 'Message',
    components: {
        Button,
        Dropdown,
        TextArea,
        TextInput,
    },
};
</script>
