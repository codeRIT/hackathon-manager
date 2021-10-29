<template>
    <div class="card">
        <slot></slot>
    </div>
</template>

<script>
export default {
    name: 'Card',
    data () {
        return {}
    },
}
</script>

<style lang="scss" scoped>
.card {
    display: inline-block;
    background-color: white;
    padding: 20px;
    color: var(--dark-color);
    border: 2px solid var(--dark-color);
    border-radius: var(--border-radius);
    box-shadow: var(--shadow-length) var(--shadow-length) var(--dark-color);
}
</style>