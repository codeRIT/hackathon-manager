<template>
    <div>
        <label :for="id">{{ label }}</label>
        <input type="text" :id="id" class="input-text" :placeholder="placeholder"/>
    </div>
</template>

<script>
export default {
    name: 'TextInput',
    props: {
        id: String,
        label: String,
        placeholder: String
    },
    data() {
        return {}
    }
}
</script>

<style lang="scss" scoped>
label {
    display: block;
}

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
