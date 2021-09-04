<template>
    <h1>Component Test</h1>

    <div class="test">
        <Card content="Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod
        tempor incididunt ut labore et dolore magna aliqua."></Card>

        <Button content="Button"></Button>
        <Button content="Button"></Button>
        <Button content="Button"></Button>

        <TextInput placeholder="Give password"></TextInput>

        <Checkbox content="Hello"></Checkbox>

        <Radio content="Hello"></Radio>
        <Radio content="Hello"></Radio>
    </div>
    <div>
        <p>{{ $t("pages.home.component") }}</p>
        <p>{{ $t("pages.home.hello") }}</p>
    </div>
</template>

<script>
    import Card from "../components/Card.vue";
    import Button from "../components/Button.vue";
    import TextInput from "../components/TextInput.vue";
    import Checkbox from "../components/Checkbox.vue";
    import Radio from "../components/Radio.vue";

    export default {
        components: {
            Card,
            Button,
            Checkbox,
            Radio,
            TextInput
        },
        data() {
            return {
                name: "Home",
            }
        },
    };
</script>

<style lang="scss" scoped>
</style>
