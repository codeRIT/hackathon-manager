<template>
    <div>
        <div class="space-between">
            <h1>{{applicant}}</h1>
            <h1>Edit</h1>
        </div>
        <hr>
        <h2>Check in Compliance</h2>
        <TextArea></TextArea>
    </div>
</template>

<script>
    import TextArea from "../../components/base/TextArea.vue";

    export default {
        components: {
            TextArea,
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
