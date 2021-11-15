<template>
    <div>
        <label v-if="label" :for="id">{{ label }}</label>
        <textarea class="input-textarea" :id="id" :cols="cols" :placeholder="placeholder"></textarea>
    </div>
</template>

<script>
export default {
    name: 'TextArea',
    props: {
        id: String,
        label: String,
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
