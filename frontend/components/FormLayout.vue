<template>
    <div class="form-wrapper">
        <div class="form-column">
            <slot></slot>
        </div>
    </div>
</template>

<script>
export default {
    name: 'FormLayout'
}
</script>

<style lang="scss">
.form-wrapper {
    display: flex;
    min-height: calc(100vh - 50px);
    margin: 25px 50px;
    overflow-wrap: break-word;

    .form-column {
        display: flex;
        flex-direction: column;
        align-items: center;
        gap: 25px;
        width: 100%;
        max-width: 300px;
        margin: auto;

        .card {
            width: 100%;

            h1, h2 {
                text-align: center;
            }
        }
        .card, form {
            display: flex;
            flex-direction: column;
            gap: 20px;

            .control-container {
                margin: 0;
            }
        }
    }
}
</style>
