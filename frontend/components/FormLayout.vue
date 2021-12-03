<template>
    <div class="formlayout">
        <slot></slot>
    </div>
</template>

<script>
export default {
    name: 'FormLayout',
    data () {
        return {}
    },
}
</script>

<style lang="scss">
.formlayout {
    display: flex;
    flex-direction: column;
    align-items: center;
    gap: 25px;

    .card, form {
        display: flex;
        flex-direction: column;
        gap: 20px;
        width: 100%;
        max-width: 300px;

        h1, h2 {
            text-align: center;
        }
        .control-container {
            margin: 0;
        }
        .center {
            align-self: center; // disable fullwidth behavior
        }
    }
}
</style>
