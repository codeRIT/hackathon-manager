<template>
    <div class="container">
        <Card class="stack">
            <h1>Sign in to {{name}}</h1>
            <TextInput id="email" placeholder="Email" />
            <TextInput id="password" placeholder="Password" />
            <Checkbox class="checkbox" content="Hello" name="checkbox-test" value="test"></Checkbox>
            <Button class="signin" content="Sign in"></Button>
        </Card>
        <br />
        <Card class="stack">
            <h1>Other sign-in options</h1>
            <Button content="Sign in with MyMLH"></Button>
            <Button content="Sign in with Google"></Button>
        </Card>
    </div>
</template>

<script>
    import Card      from "../components/base/Card.vue";
    import Button    from "../components/base/Button.vue";
    import TextInput from "../components/base/TextInput.vue";
    import Checkbox from "../components/base/CheckBox.vue";

    export default {
        components: {
            Card,
            Button,
            TextInput,
            Checkbox,
        },
        data() {
            return {
                name: "VeryLongHackathonName",
            }
        },
    };
</script>

<style lang="scss" scoped>
.container {
    display: flex;
    flex-direction: column;
    align-items: center;

    .stack {
        display: flex;
        flex-direction: column;
        gap: 20px;
        width: 400px;
        /* my brain is too small to figure out how to match the oauth stack
        with the form stack
        */

        h1 {
            text-align: center;
        }
        .checkbox {
            margin: 0;
        }
        .signin {
            align-self: center; // disable fullwidth behavior
            align-self: flex-start;
        }
    }
}
</style>