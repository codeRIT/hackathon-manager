<template>
    <input type="text" class="input-text" placeholder="Password please"/>
</template>

<script>
    export default {
        name: 'TextInput',
        props: {
            placeholder: String
        },
        data() {
            return {}
        }
    }
</script>

<style lang="scss" scoped>

.input-text {
    border-radius: var(--border-radius);
    border: var(--border-size) solid var(--dark-color);
    padding: 6px;
    outline: none;

    &:focus {
       border-color: var(--orange);
    }
}

</style>
