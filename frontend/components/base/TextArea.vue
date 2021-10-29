<template>
    <textarea class="input-textarea" :cols="cols" :placeholder="placeholder"></textarea>
</template>

<script>
export default {
    name: 'TextArea',
    props: {
        placeholder: String,
        cols: {
            type: Number,
            default: 20
        }
    }
}
</script>

<style lang="scss" scoped>
.input-textarea {
    border-radius: var(--border-radius);
    border: var(--border-size) solid var(--dark-color);
    display: block;
    font-family: unset;
    padding: 6px;
    outline: none;
    width: 100%;

    &:focus {
       border-color: var(--orange);
    }
}
</style>
