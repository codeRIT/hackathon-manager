<template>
    <FormLayout>
        <Card>
            <h1>Create an account</h1>
            <TextInput id="fname" placeholder="First name" />
            <TextInput id="lname" placeholder="Last name" />
            <TextInput id="email" placeholder="Email" />
            <TextInput id="password" placeholder="Password" />
            <TextInput id="confirm" placeholder="Confirm password" />
            <Button class="center" content="Register"></Button>
        </Card>
        <br />
        <Card class="stack">
            <h1>Other registration options</h1>
            <Button content="Continue with MyMLH"></Button>
            <Button content="Continue with Google"></Button>
        </Card>
    </FormLayout>
</template>

<script>
    import FormLayout from "../components/FormLayout.vue"
    import Card      from "../components/base/Card.vue";
    import Button    from "../components/base/Button.vue";
    import TextInput from "../components/base/TextInput.vue";
    import Checkbox from "../components/base/CheckBox.vue";

    export default {
        components: {
            FormLayout,
            Card,
            Button,
            TextInput,
            Checkbox,
        },
        data() {
            return {
                name: "<HackathonName>",
            }
        },
    };
</script>

<style lang="scss" scoped>
</style>