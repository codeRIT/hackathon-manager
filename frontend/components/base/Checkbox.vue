<template>

    <label class="control-container">{{content}}
        <input
            type="checkbox"
            :value="value"
            @input="onChange($event.target)"
        >
        <span class="control"></span>
    </label>
</template>

<script>
export default {
    name: 'Checkbox',
    methods: {
        // inspired by https://stackoverflow.com/a/58201070
        onChange(target) {
            let currentValue = [...this.modelValue]
            if (target.checked) {
                currentValue.push(target.value)
            } else {
                currentValue = currentValue.filter(item => item !== target.value)
            }
            this.$emit('update:modelValue', currentValue);
        }
    },
    props: {
        content: String,
        modelValue: Boolean,
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
