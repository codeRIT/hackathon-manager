<template>
    <div>
        <h1>{{ $t("pages.manage.message.title") }}</h1>
        <hr>
        <TextInput :placeholder="$t('pages.manage.message.subject')"></TextInput>
        <Dropdown>
            <option selected>Bee</option>
            <option>2</option>
        </Dropdown>
        <br>
        <TextArea></TextArea>
        <br>
        <Button :content="$t('pages.manage.message.send')"></Button>
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
