<template>
    <div>
        <h1>Send a message</h1>
        <hr>
        <TextInput placeholder="Subject"></TextInput>
        <Dropdown name="Recipient dropdown">
            <option selected>Bee</option>
            <option>2</option>
        </Dropdown>
        <br>
        <TextArea></TextArea>
        <br>
        <Button content="Send"></Button>
    </div>
</template>

<script>
import Button    from "../../../components/base/Button.vue";
import Dropdown  from "../../../components/base/Dropdown.vue";
import TextArea from "../../../components/base/TextArea.vue";
import TextInput from "../../../components/base/TextInput.vue";

export default {
    components: {
        Button,
        Dropdown,
        TextArea,
        TextInput,
    },
};
</script>
