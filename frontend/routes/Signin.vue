<template>
    <FormLayout>
        <Card>
            <h1>Sign in to {{name}}</h1>
            <TextInput id="email" placeholder="Email" />
            <TextInput id="password" placeholder="Password" />
            <Checkbox class="checkbox" content="Hello" name="checkbox-test" value="test"></Checkbox>
            <Button class="center" content="Sign in"></Button>
        </Card>
        <br />
        <Card class="stack">
            <h1>Other sign-in options</h1>
            <Button content="Sign in with MyMLH"></Button>
            <Button content="Sign in with Google"></Button>
        </Card>
    </FormLayout>
</template>

<script>
    import FormLayout from "../components/FormLayout.vue"
    import Card      from "../components/base/Card.vue";
    import Button    from "../components/base/Button.vue";
    import TextInput from "../components/base/TextInput.vue";
    import Checkbox from "../components/base/Checkbox.vue";

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