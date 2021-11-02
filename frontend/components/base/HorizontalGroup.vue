<template>
    <div class="horizontal-group">
        <slot></slot>
    </div>
</template>

<script>
export default {
    name: 'HorizontalGroup'
}
</script>

<style lang="scss" scoped>
.horizontal-group {
    background-color: white;
    border-radius: var(--border-radius);
    box-shadow: var(--shadow-length) var(--shadow-length) var(--dark-color);
    color: var(--dark-color);
    display: flex;
    width: max-content;

    & > ::v-slotted(*) {
        border-bottom: 2px solid var(--dark-color);
        border-left: 2px solid var(--dark-color);
        border-top: 2px solid var(--dark-color);
        padding: 15px 20px;

        &:first-of-type {
            border-bottom-left-radius: var(--border-radius);
            border-top-left-radius: var(--border-radius);
        }

        &:last-of-type {
            border-right: 2px solid var(--dark-color);
            border-bottom-right-radius: var(--border-radius);
            border-top-right-radius: var(--border-radius);
        }

        &:hover {
            background-color: var(--orange);
        }
    }
}
</style>
