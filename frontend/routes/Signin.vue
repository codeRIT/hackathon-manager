<template>
    <div class="centerer">
        <Card class="form">
            <h1>Sign in to {{name}}</h1>
            <TextInput class="input" placeholder="Email" />
            <TextInput class="input" placeholder="Password" />
            <Checkbox class="checkbox" content="Hello" name="checkbox-test" value="test"></Checkbox>
            <Button class="button" content="Sign in"></Button>
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
                name: "BrickHack 7",
            }
        },
    };
</script>

<style lang="scss" scoped>
.centerer {
    display: flex;
    align-content: center;
    justify-content: center;
    width: 100%;
}
.form {
    display: flex;
    flex-direction: column;
    align-items: center;
    gap: 20px;
}
.input {
    width: 95%;
}
.checkbox {
    align-self: flex-start;
    margin: 0;
}
</style>