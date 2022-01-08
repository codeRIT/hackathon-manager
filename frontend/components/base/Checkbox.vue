<template>

    <label class="control-container">{{content}}
        <input
            type="checkbox"
            :value="value"
            v-model="computedValue"
        >
        <span class="control"></span>
    </label>
</template>

<script>
export default {
    name: 'Checkbox',
    computed: {
        computedValue: {
            get() {
                return this.modelValue
            },
            set(value) {
                this.$emit('update:modelValue', value)
            }
        }
    },
    emits: ['update:modelValue'],
    props: {
        content: String,
        modelValue: Array,
        value: String
    }
}
</script>

<style lang="scss" scoped>
// These are styled in the controls.sass partial
// because the style for checkboxes and radios
// are nearly identical.
@import "../../assets/scss/controls.scss";
</style>
