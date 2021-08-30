<template>
    <h1>Component Test</h1>

    <div class="card">
        <p>This is some cool content.</p>
    </div>

    <br><br><br>

    <button class="button">Button</button>
    <button class="button-hover">Button</button>
    <button class="button-active">Button</button>

    <br><br><br>

    <input type="text" class="input-text" placeholder="Password please"/>

    <br><br><br>

    <label class="checkbox-container">
        <input type="checkbox">
        <span class="checkbox"></span>
    </label>

    <br><br><br>

    <label class="radio-container">
        <input type="radio" name="asdf" value="123" checked>
        <span class="checkbox radio"></span>
    </label>

    <br><br>
    <label class="radio-container">
        <input type="radio" name="asdf" value="144;">
        <span class="checkbox radio"></span>
    </label>



</template>

<script>
    export default {        data() {
            return {
                name: "Home",
            };
        },
    };
</script>

<style lang="scss" scoped>

// FIXME: https://github.com/vuejs/vue-loader/issues/1601
$dark-color: #4D4D4D;
$shadow-length: 4px;
$shadow-length-control: $shadow-length / 2;
$border-radius: 6px;
$border-size: 2px;
$orange: #F76901;
$duration: 0.1s;

.card {
    display: inline-block;
    background-color: white;
    padding: 20px;
    color: $dark-color;
    border: 2px solid $dark-color;
    border-radius: $border-radius;
    box-shadow: $shadow-length $shadow-length $dark-color;
}

.button {
    text-decoration: none;
    display: inline-block;
    background-color: white;
    padding: 5px 10px;
    margin-right: 10px;
    color: $dark-color;
    border: $border-size solid $dark-color;
    border-radius: $border-radius;
    box-shadow: $shadow-length $shadow-length $dark-color;
    transition: $duration all;

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
    background-color: $orange;
    color: white;
    // font-weight: bold;
}

.button-active {
    @extend .button-hover;
    box-shadow: 0 0 $dark-color;
    transform: translate($shadow-length, $shadow-length);
}

.input-text {
    border-radius: $border-radius;
    border: $border-size solid $dark-color;
    padding: 6px;

    &:focus {
        @extend .input-text-focus;
    }
}

.input-text-focus {
    @extend .input-text;
    border-color: $orange;
}


// TODO: Checkbox

.checkbox-container {
    display: block;
    position: relative;
    cursor: pointer;
    user-select: none;

    // Hide default checkbox
    input {
        position: absolute;
        opacity: 0;
        cursor: pointer;

    }

    // Hover state
    &:hover input ~ .checkbox {
        // background-color: yellow;
        background-color: $orange;
    }

    input:checked ~ .checkbox {
        // background-color: darkgreen;
        &::before {
            content: "";
            $size: 70%;
            width: $size;
            height: $size;
            top: (100% - $size) / 2;
            left: (100% - $size) / 2;
            position: absolute;
            background-color: $dark-color;
            border-radius: $border-radius / 2;
        }
    }

    input ~ .checkbox {
        transition: $duration all;
    }

    &:active input ~ .checkbox {
        box-shadow: 0 0 $dark-color;
        transform: translate($shadow-length-control, $shadow-length-control);
    }
}

.checkbox {
    position: absolute;
    top: 0;
    left: 0;
    height: 20px;
    width: 20px;
    background-color: white;
    box-shadow: $shadow-length-control $shadow-length-control $dark-color;
    border: $border-size solid $dark-color;
    border-radius: $border-radius;

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