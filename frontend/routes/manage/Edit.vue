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
    export default {
        components: {
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