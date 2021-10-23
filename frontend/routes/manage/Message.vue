<template>
    <div>
        <h1>Send a message</h1>
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
    import Button    from "../../components/base/Button.vue";
    import TextInput from "../../components/base/TextInput.vue";

    export default {
        components: {
            Button,
            TextInput,
        },
    };
</script>