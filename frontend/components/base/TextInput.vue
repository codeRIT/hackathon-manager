<template>
    <div>
        <label class="control-label" :for="id">{{ label }}</label>
        <input :type="[type == null ? 'text' : type]" :id="id" class="input-text" :class="{'full-width': fullWidth}" :placeholder="placeholder"/>
    </div>
</template>

<script>
export default {
    name: 'TextInput',
    props: {
        id: String,
        label: String,
        placeholder: String,
        type: String,
        fullWidth: Boolean
    },
    data() {
        return {}
    }
}
</script>

<style lang="scss" scoped>
@import "../../assets/scss/controls.scss";

.input-text {
    border-radius: var(--border-radius);
    border: var(--border-size) solid var(--dark-color);
    padding: 6px;
    outline: none;

    &.full-width {
        width: 100%;
        box-sizing: border-box;
    }

    &:focus {
        border-color: var(--orange);
    }
}
</style>
