<template>
    <div>
        <h1>Component Test</h1>

        <div class="test">
            <Card>
                <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.</p>
            </Card>

            <Button content="Button"></Button>
            <Button content="Button"></Button>
            <Button content="Button"></Button>

            <TextInput placeholder="Give password"></TextInput>

            <TextArea placeholder="Does the black moon howl?"></TextArea>

            <Checkbox content="Hello" name="checkbox-test" value="test"></Checkbox>

            <Radio content="Hello" name="radio-test" value="asdf"></Radio>
            <Radio content="Hello" name="radio-test" value="1234"></Radio>

            <Table :rows="tableRows" :shownColumns="tableColumns"></Table>

            <VerticalGroup>
                <a href="#">Item 1</a>
                <a href="#">Item 2</a>
                <a href="#">Item 3</a>
            </VerticalGroup>

            <HorizontalGroup>
                <a href="#">Item 1</a>
                <a href="#">Item 2</a>
                <a href="#">Item 3</a>
            </HorizontalGroup>

            <Dropdown name="Dropdown">
                <option selected>Item 1</option>
                <option>Item 2</option>
                <option>Item 3</option>
            </Dropdown>
        </div>

        <div>
            <p>{{ $t("pages.home.component") }}</p>
            <p>{{ $t("pages.home.hello") }}</p>
        </div>
    </div>
</template>

<script>
    import Card            from "../components/base/Card.vue";
    import Button          from "../components/base/Button.vue";
    import TextInput       from "../components/base/TextInput.vue";
    import Checkbox        from "../components/base/Checkbox.vue";
    import Radio           from "../components/base/Radio.vue";
    import Table           from "../components/base/Table.vue";
    import VerticalGroup   from "../components/base/VerticalGroup.vue";
    import HorizontalGroup from "../components/base/HorizontalGroup.vue";
    import Dropdown        from "../components/base/Dropdown.vue";
    import TextArea  from "../components/base/TextArea.vue";

    export default {
        components: {
            Card,
            Button,
            Checkbox,
            Radio,
            TextInput,
            Table,
            VerticalGroup,
            HorizontalGroup,
            Dropdown,
            TextArea
        },
        data() {
            return {
                name: "Home",
                tableRows: [
                    {
                        id: 1,
                        title: "lorem ipsum",
                        description: "dolor sit amet"
                    },
                    {
                        id: 2,
                        title: "lorem ipsum",
                        description: "dolor sit amet"
                    },
                    {
                        id: 3,
                        title: "lorem ipsum",
                        description: "dolor sit amet"
                    },
                    {
                        id: 4,
                        title: "lorem ipsum",
                        description: "dolor sit amet"
                    },
                    {
                        id: 5,
                        title: "lorem ipsum",
                        description: "dolor sit amet"
                    }
                ],
                tableColumns: {
                    description: "Description",
                    title: "Title"
                }
            }
        },
    };
</script>

