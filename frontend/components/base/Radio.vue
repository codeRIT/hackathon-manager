<template>
    <label class="control-container">{{ content }}
        <input type="radio" :name="name" :value="value" checked>
        <span class="control"></span>
    </label>
</template>

<script>
export default {
    name: 'Radio',
    props: {
        content: String,
        name: String,
        value: String
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
@import "../../assets/scss/controls.scss";

// The "nearly" in "nearly identical" styling...
.control-container input:checked ~ .control::before {
    border-radius: 50%;
}

.control {
    border-radius: 50%;
}
</style>
