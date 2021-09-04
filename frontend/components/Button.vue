<template>
    <button class="button">{{ content }}</button>
</template>

<script>
	export default {

		name: "Button",
        props: {
            content: String
        },
		data () {
			return {}
		}
	}
</script>

<style lang="scss" scoped>
.button {
    cursor: pointer;
    text-decoration: none;
    display: inline-block;
    background-color: white;
    padding: 5px 10px;
    margin-right: 10px;
    color: var(--dark-color);
    border: var(--border-size) solid var(--dark-color);
    border-radius: var(--border-radius);
    box-shadow: var(--shadow-length) var(--shadow-length) var(--dark-color);
    transition: var(--duration) all;

    &:hover {
        @extend .button;
        background-color: var(--orange);
        color: white;
    }

    &:active {
        box-shadow: 0 0 var(--dark-color);
        transform: translate(var(--shadow-length), var(--shadow-length));
    }
}
</style>
