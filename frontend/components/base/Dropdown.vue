<template>
    <div class="input-dropdown">
        <!-- making this invisible so that screen readers can ignore the "pretty" version -->
        <select class="invisible" ref="select">
            <slot></slot>
        </select>

        <div class="dropdown" :class="{ 'opened': isOpen }" @click="toggleOpen" aria-hidden="true">
            <div class="name">
                <p>{{ name }}</p>
            </div>

            <div
                v-for="(option, index) in options"
                :key="option"
                @click="select(option.value)"
                class="item"
                :class="{ 'selected': currentSelection === option.value }"
                :style="{ 'z-index': index + 1 }"
            >
                <p>{{ option.value }}</p>
            </div>
        </div>
    </div>
</template>

<script>
export default {
    name: 'Dropdown',
    props: {
        name: String
    },
    data() {
        return {
            currentSelection: "",
            isOpen: false,
            options: [],  // populated in mounted()
        }
    },
    mounted() {
        this.options = [...this.$refs.select.getElementsByTagName("option")];  // convert HTMLCollection to array
        this.currentSelection = this.$refs.select.value;  // pull default vaclue from <select> element
    },
    methods: {
        toggleOpen() {
            this.isOpen = !this.isOpen;
        },

        select(value) {
            this.currentSelection = value;
            this.$refs.select.value = value;
        }
    }
}
</script>

<style lang="scss" scoped>
.dropdown {
    align-items: end;
    display: inline-flex;
    flex-direction: column;

    .name, .item {
        box-shadow: var(--shadow-length) var(--shadow-length) var(--dark-color);
        cursor: pointer;
        padding: 6px;
        user-select: none;
        transition: var(--duration) box-shadow, var(--duration) transform, var(--duration) background-color, var(--duration) color;
    }

    .name {
        border: var(--border-size) solid var(--dark-color);
        border-bottom-left-radius: var(--border-radius);
        border-top-left-radius: var(--border-radius);
        border-top-right-radius: var(--border-radius);
    }

    .item {
        background: white;
        border: var(--border-size) solid var(--dark-color);
        display: none;
        margin-top: calc(-1 * var(--border-size));
        width: max-content;

        &:hover {
            background-color: var(--orange);
            color: white;
            filter: brightness(1.2);
        }

        &:active {
            box-shadow: 0 0 var(--dark-color);
            transform: translate(var(--shadow-length), var(--shadow-length));
        }

        &:last-child {
            border-bottom-left-radius: var(--border-radius);
            border-bottom-right-radius: var(--border-radius);
        }

        &.selected {
            background-color: var(--orange);
            color: white;
        }
    }

    &:not(.opened) .name {
        border-bottom-right-radius: var(--border-radius);

        &:hover {
            background-color: var(--orange);
            color: white;
        }

        &:active {
            box-shadow: 0 0 var(--dark-color);
            transform: translate(var(--shadow-length), var(--shadow-length));
        }
    }

    &.opened .item {
        display: block;
    }
}

// from https://webaim.org/techniques/css/invisiblecontent/
.invisible {
    clip: rect(1px, 1px, 1px, 1px);
    clip-path: inset(50%);
    height: 1px;
    width: 1px;
    margin: -1px;
    overflow: hidden;
    padding: 0;
    position: absolute;
}
</style>
