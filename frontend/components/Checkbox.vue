<template>

    <label class="control-container">{{content}}
        <input type="checkbox">
        <span class="control"></span>
    </label>
</template>

<script>
export default {
    name: 'Checkbox',
    props: {
        content: String
    },
    data() {
        return {}
    }
}
</script>

<style lang="scss" scoped>
// These are styled in the controls.sass partial
// because the style for checkboxes and radios
// are nearly identical.
@import "../assets/scss/controls.scss";
</style>
