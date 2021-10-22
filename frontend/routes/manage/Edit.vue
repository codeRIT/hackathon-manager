<template>
    <div>
        <div class="space-between">
            <h1>{{applicant}}</h1>
            <p>Edit</p>
        </div>
        <hr>
        <br>
        <p>Check in Compliance</p>
        <p>[big text input]</p>
    </div>
</template>

<script>
    import Card      from "../../components/base/Card.vue";
    import Button    from "../../components/base/Button.vue";
    import TextInput from "../../components/base/TextInput.vue";
    import Checkbox  from "../../components/base/Checkbox.vue";
    import Radio     from "../../components/base/Radio.vue";
    import Table     from "../../components/base/Table.vue";

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
                name: "Edit",
                applicant: "Claire Gallup",
            }
        },
    };
</script>

<style lang="scss" scoped>
.space-between {
    display: flex;
    justify-content: space-between;
}
</style>