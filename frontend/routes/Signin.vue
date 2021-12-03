<template>
    <FormLayout>
        <Card>
            <form>
                <h1>Sign in to {{name}}</h1>
                <TextInput id="email" placeholder="Email" type="email" required />
                <TextInput id="password" placeholder="Password" type="password" required/>
                <Checkbox id="remember" class="checkbox" content="Remember me" name="checkbox-test" value="remember"></Checkbox>
                <Button class="center" content="Sign in" type="submit"></Button>
            </form>
        </Card>
        <Card>
            <h2>Other sign-in options</h2>
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