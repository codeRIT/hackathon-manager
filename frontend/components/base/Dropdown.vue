<template>
    <div class="input-dropdown">
        <!-- making this invisible so that screen readers can ignore the "pretty" version -->
        <select
            class="invisible"
            :id="id" ref="select"
            :aria-label="withLabel ? null : label"
            :value="modelValue"
        >
            <slot></slot>
        </select>

        <label v-if="withLabel" class="control-label" :for="id">{{ label }}</label>
        <div class="dropdown" :class="{ 'opened': isOpen }" @click="toggleOpen" aria-hidden="true">
            <div class="name">
                <p v-if="withLabel">{{ currentSelection?.textContent }} <font-awesome-icon :icon="isOpen ? 'chevron-up' : 'chevron-down'"></font-awesome-icon></p>
                <p v-else>{{ label }} <font-awesome-icon :icon="isOpen ? 'chevron-up' : 'chevron-down'"></font-awesome-icon></p>
            </div>

            <div
                v-for="(option, index) in options"
                :key="option"
                @click="select(option)"
                class="item"
                :class="{ 'selected': currentSelection?.value === option.value }"
                :style="{ 'z-index': index + 1 }"
            >
                <p>{{ option.textContent }}</p>
            </div>
        </div>
    </div>
</template>

<script>
import { FontAwesomeIcon } from "@fortawesome/vue-fontawesome"

export default {
    name: 'Dropdown',
    components: {
        FontAwesomeIcon
    },
    props: {
        id: String,
        label: String,
        modelValue: String,
        withLabel: {
            type: Boolean,
            default: true
        }
    },
    data() {
        return {
            currentSelection: null,
            isOpen: false,
            options: [],  // populated in mounted()
        }
    },
    mounted() {
        this.options = [...this.$refs.select.getElementsByTagName("option")];  // convert HTMLCollection to array
        this.currentSelection = this.options.filter(x => x.value === this.$refs.select.value)[0] || this.options[0];  // pull default vaclue from <select> element
    },
    methods: {
        toggleOpen() {
            this.isOpen = !this.isOpen;
        },

        select(option) {
            this.currentSelection = option;
            this.$refs.select.value = option.value;
            this.$emit('update:modelValue', option.value)
        }
    }
}
</script>

<style lang="scss" scoped>
@import "../../assets/scss/controls.scss";

.dropdown {
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
        border-bottom-left-radius: var(--border-radius);
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
