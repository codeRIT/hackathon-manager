<template>
    <h1>Component Test</h1>

    <Card content="Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod
    tempor incididunt ut labore et dolore magna aliqua."></Card>

    <br><br><br>

    <Button content="Button"></Button>
    <Button content="Button"></Button>
    <Button content="Button"></Button>

    <br><br><br>

    <input type="text" class="input-text" placeholder="Password please"/>

    <Checkbox content="Hello"></Checkbox>

    <Radio content="Hello"></Radio>
    <Radio content="Hello"></Radio>
</template>

<script>
    import Card from "../components/Card.vue";
    import Button from "../components/Button.vue";
    import Checkbox from "../components/Checkbox.vue";
    import Radio from "../components/Radio.vue";

    export default {
        components: {
            Card,
            Button,
            Checkbox,
            Radio
        },
        data() {
            return {
                name: "Home",
            };
        },
    };
</script>

<style lang="scss" scoped>

@use "sass:math";

.input-text {
    border-radius: var(--border-radius);
    border: var(--border-size) solid var(--dark-color);
    padding: 6px;

    &:focus {
        @extend .input-text-focus;
    }
}

.input-text-focus {
    @extend .input-text;
    border-color: var(--orange);
}
</style>
