<template>
    <FormLayout>
        <Card>
            <form>
                <h1>Create an account</h1>
                <TextInput id="fname" placeholder="First name" required />
                <TextInput id="lname" placeholder="Last name" required />
                <TextInput id="email" placeholder="Email" type="email" required />
                <TextInput id="password" placeholder="Password" type="password" required />
                <TextInput id="confirm" placeholder="Confirm password" type="password" required />
                <Button class="center" content="Register" type="submit"></Button>
            </form>
        </Card>
        <Card>
            <h2>Other registration options</h2>
            <Button content="Continue with MyMLH"></Button>
            <Button content="Continue with Google"></Button>
        </Card>
    </FormLayout>
</template>

<script>
    import FormLayout from "../components/FormLayout.vue"
    import Card       from "../components/base/Card.vue";
    import Button     from "../components/base/Button.vue";
    import TextInput  from "../components/base/TextInput.vue";
    import Checkbox   from "../components/base/Checkbox.vue";

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
