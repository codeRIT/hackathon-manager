<template>
    <div class="card">
        {{ content }}
    </div>
</template>

<script>
    export default {
        name: 'Card',
        props: {
            content: String
        },
        data () {
            return {
                content: this.content
            }
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