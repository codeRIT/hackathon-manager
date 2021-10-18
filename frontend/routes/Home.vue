<template>
    <div>
        <h1>Component Test</h1>

        <div class="test">
            <Card content="Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod
            tempor incididunt ut labore et dolore magna aliqua."></Card>

            <Button content="Button"></Button>
            <Button content="Button"></Button>
            <Button content="Button"></Button>

            <TextInput placeholder="Give password"></TextInput>

            <Checkbox content="Hello" name="checkbox-test" value="test"></Checkbox>

            <Radio content="Hello" name="radio-test" value="asdf"></Radio>
            <Radio content="Hello" name="radio-test" value="1234"></Radio>

            <Table :rows="tableRows" :showPagination="true" editLink="/test"></Table>
        </div>

        <div>
            <p>{{ $t("pages.home.component") }}</p>
            <p>{{ $t("pages.home.hello") }}</p>
        </div>
    </div>
</template>

<script>
    import Card      from "../components/Card.vue";
    import Button    from "../components/Button.vue";
    import TextInput from "../components/TextInput.vue";
    import Checkbox  from "../components/Checkbox.vue";
    import Radio     from "../components/Radio.vue";
    import Table     from "../components/Table.vue";

    export default {
        components: {
            Card,
            Button,
            Checkbox,
            Radio,
            TextInput,
            Table
        },
        data() {
            return {
                name: "Home",
                tableRows: [
                    {
                        "Column 1": "lorem ipsum",
                        "Column 2": "lorem ipsum",
                        "Column 3": "lorem ipsum"
                    },
                    {
                        "Column 1": "lorem ipsum",
                        "Column 2": "lorem ipsum",
                        "Column 3": "lorem ipsum"
                    },
                    {
                        "Column 1": "lorem ipsum",
                        "Column 2": "lorem ipsum",
                        "Column 3": "lorem ipsum"
                    },
                    {
                        "Column 1": "lorem ipsum",
                        "Column 2": "lorem ipsum",
                        "Column 3": "lorem ipsum"
                    },
                    {
                        "Column 1": "lorem ipsum",
                        "Column 2": "lorem ipsum",
                        "Column 3": "lorem ipsum"
                    }
                ]
            }
        },
    };
</script>

