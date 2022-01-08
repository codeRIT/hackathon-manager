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

            <TextInput placeholder="Give password" v-model="textInputVal"></TextInput>

            <TextArea placeholder="Does the black moon howl?" v-model="textAreaVal"></TextArea>

            <Checkbox content="Hello 1" value="test 1" v-model="checkboxVal"></Checkbox>
            <Checkbox content="Hello 2" value="test 2" v-model="checkboxVal"></Checkbox>
            <Checkbox content="Hello 3" value="test 3" v-model="checkboxVal"></Checkbox>

            <Radio content="Hello" name="radio-test" value="asdf" v-model="radioVal"></Radio>
            <Radio content="Hello" name="radio-test" value="1234" v-model="radioVal"></Radio>

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

            <Dropdown label="Dropdown" :withLabel="false" v-model="dropdownVal">
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
        computed: {
            // simplest way to verify model bindings for input components

            textInputVal: {
                get() {
                    return this._textInputVal
                },
                set(value) {
                    this._textInputVal = value
                    alert(value)
                }
            },

            textAreaVal: {
                get() {
                    return this._textAreaVal
                },
                set(value) {
                    this._textAreaVal = value
                    alert(value)
                }
            },

            checkboxVal: {
                get() {
                    return this._checkboxVal
                },
                set(value) {
                    this._checkboxVal = value
                    alert(value)
                }
            },

            radioVal: {
                get() {
                    return this._radioVal
                },
                set(value) {
                    this._radioVal = value
                    alert(value)
                }
            },

            dropdownVal: {
                get() {
                    return this._dropdownVal
                },
                set(value) {
                    this._dropdownVal = value
                    alert(value)
                }
            }
        },
        data() {
            return {
                name: "Home",

                // input component models
                _textInputVal: "",
                _textAreaVal: "",
                _checkboxVal: [],
                _radioVal: "",
                _dropdownVal: "",

                // table setup
                tableRows: [
                    {
                        id: 1,
                        title: "lorem ipsum",
                        description: "dolor sit amet",
                        features: "test test"
                    },
                    {
                        id: 2,
                        title: "lorem ipsum",
                        description: "dolor sit amet",
                        features: "test test"
                    },
                    {
                        id: 3,
                        title: "lorem ipsum",
                        description: "dolor sit amet",
                        features: "test test"
                    },
                    {
                        id: 4,
                        title: "lorem ipsum",
                        description: "dolor sit amet",
                        features: "test test"
                    },
                    {
                        id: 5,
                        title: "lorem ipsum",
                        description: "dolor sit amet",
                        features: "test test"
                    }
                ],
                tableColumns: {
                    features: "Features",
                    description: "Description",
                    title: "Title"
                }
            }
        },
    };
</script>

