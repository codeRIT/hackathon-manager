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

    .card {
        display: flex !important;
        flex-direction: column;
        gap: 20px;
        width: 100%;
        max-width: 375px;

        h1 {
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
