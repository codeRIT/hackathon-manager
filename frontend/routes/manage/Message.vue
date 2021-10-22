<template>
    <div>
        <h1>Send a Message</h1>
        <hr>
        <br>
        <TextInput placeholder="Subject"></TextInput>
        <p>[recipient dropdown]</p>
        <br>
        <p>[big text input]</p>
        <br>
        <Button content="Send"></Button>
    </div>
</template>

<script>
    import Card      from "../../components/base/Card.vue";
    import Button    from "../../components/base/Button.vue";
    import TextInput from "../../components/base/TextInput.vue";
    import Checkbox  from "../../components/base/Checkbox.vue";

    export default {
        components: {
            Card,
            Button,
            Checkbox,
            TextInput,
        },
    };
</script>