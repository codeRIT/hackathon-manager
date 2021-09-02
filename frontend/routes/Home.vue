<template>
    <h1>Component Test</h1>

    <Card :content="asdf"></Card>

    <br><br><br>

    <button class="button">Button</button>
    <button class="button-hover">Button</button>
    <button class="button-active">Button</button>

    <br><br><br>

    <input type="text" class="input-text" placeholder="Password please"/>

    <label class="checkbox-container">Hello
        <input type="checkbox">
        <span class="checkbox"></span>
    </label>

    <label class="radio-container">Hello
        <input type="radio" name="asdf" value="123" checked>
        <span class="checkbox radio"></span>
    </label>

    <label class="radio-container">World
        <input type="radio" name="asdf" value="144;">
        <span class="checkbox radio"></span>
    </label>

</template>

<script>
    import Card from "../components/Card.vue";

    export default {
        components: {
            Card
        },
        data() {
            return {
                name: "Home",
            };
        },
    };
</script>

<style lang="scss" scoped>

@use "sass:math";

// FIXME: https://github.com/vuejs/vue-loader/issues/1601


.button {
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
        @extend .button-hover;
    }

    // FIXME: Button active
    &:active {
        @extend .button-active;
    }
}

.button-hover {
    @extend .button;
    background-color: var(--orange);
    color: white;
    // font-weight: bold;
}

.button-active {
    @extend .button-hover;
    box-shadow: 0 0 var(--dark-color);
    transform: translate(var(--shadow-length), var(--shadow-length));
}

.input-text {
    border-radius: var(--border-radius);
    border: var(--border-size) solid var(--dark-color);
    padding: 6px;

    &:focus {
        @extend .input-text-focus;
    }
}

.input-text-focus {
    @extend .input-text;
    border-color: var(--orange);
}


// TODO: Checkbox

.checkbox-container {
    display: block;
    position: relative;
    cursor: pointer;
    user-select: none;
    padding-left: 20px + 10px;
    padding-top: 5px;
    margin-top: 10px;

    // Hide default checkbox
    input {
        position: absolute;
        opacity: 0;
        cursor: pointer;
    }

    // Hover state
    &:hover input ~ .checkbox {
        // background-color: yellow;
        background-color: var(--orange);
    }

    input:checked ~ .checkbox {
        // background-color: darkgreen;
        &::before {
            content: "";
            $size: 70%;
            width: $size;
            height: $size;
            top: math.div((100% - $size), 2);
            left: math.div((100% - $size), 2);
            position: absolute;
            background-color: var(--dark-color);
            border-radius: math.div(var(--border-radius), 2);
        }
    }

    input ~ .checkbox {
        transition: var(--duration) all;
    }

    &:active input ~ .checkbox {
        box-shadow: 0 0 var(--dark-color);
        transform: translate(var(--shadow-length-control), var(--shadow-length-control));
    }
}

.checkbox {
    position: absolute;
    top: 0;
    left: 0;
    height: 20px;
    width: 20px;
    background-color: white;
    box-shadow: var(--shadow-length-control) var(--shadow-length-control) var(--dark-color);
    border: var(--border-size) solid var(--dark-color);
    border-radius: var(--border-radius);

    &:after {
        content: "";
        position: absolute;
        display: none;
    }
}

.radio-container {
    @extend .checkbox-container;

    input:checked ~ .radio::before {
        border-radius: 50%;
    }
}


.radio {
    border-radius: 50%;

}



</style>