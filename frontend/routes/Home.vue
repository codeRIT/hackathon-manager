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

            <VerticalGroup>
                <a href="#">Item 1</a>
                <a href="#">Item 2</a>
                <a href="#">Item 3</a>
            </VerticalGroup>
        </div>

        <div>
            <p>{{ $t("pages.home.component") }}</p>
            <p>{{ $t("pages.home.hello") }}</p>
        </div>
    </div>
</template>

<script>
    import Card          from "../components/base/Card.vue";
    import Button        from "../components/base/Button.vue";
    import TextInput     from "../components/base/TextInput.vue";
    import Checkbox      from "../components/base/Checkbox.vue";
    import Radio         from "../components/base/Radio.vue";
    import Table         from "../components/base/Table.vue";
    import VerticalGroup from "../components/base/VerticalGroup.vue";

    export default {
        components: {
            Card,
            Button,
            Checkbox,
            Radio,
            TextInput,
            Table,
            VerticalGroup
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

