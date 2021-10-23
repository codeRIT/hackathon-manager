<template>
    <div class="vertical-group">
        <slot></slot>
    </div>
</template>

<script>
export default {
    name: 'VerticalGroup',
    props: {
        items: Array
    }
}
</script>

<style lang="scss" scoped>
.vertical-group {
    background-color: white;
    border-radius: var(--border-radius);
    box-shadow: var(--shadow-length) var(--shadow-length) var(--dark-color);
    color: var(--dark-color);
    display: flex;
    flex-direction: column;
    width: max-content;

    & > ::v-slotted(*) {
        border-left: 2px solid var(--dark-color);
        border-right: 2px solid var(--dark-color);
        border-top: 2px solid var(--dark-color);
        padding: 15px 20px;

        &:first-of-type {
            border-top-left-radius: var(--border-radius);
            border-top-right-radius: var(--border-radius);
        }

        &:last-of-type {
            border-bottom: 2px solid var(--dark-color);
            border-bottom-left-radius: var(--border-radius);
            border-bottom-right-radius: var(--border-radius);
        }
    }
}
</style>
