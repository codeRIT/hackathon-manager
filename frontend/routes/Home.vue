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

    <input type="checkbox" id="first" class="checkbox" name="first" value="Banana">
    <label for="first"> I have a banana</label><br>

    <input type="checkbox" id="second" class="checkbox" name="second" value="Orange">
    <label for="second"> I have a orange</label><br>

    <input type="checkbox" id="third" class="checkbox" name="third" value="Apple">
    <label for="third"> I have a apple</label><br>



</template>

<script>
    export default {
        data() {
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
$border-radius: 6px;
$border-size: 2px;
$orange: #F76901;

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
    transition: 0.1s all;

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
    box-shadow: 0 0 $dark-color;
    transform: translate($shadow-length, $shadow-length);

}

.button-active {
    @extend .button-hover;
    background-color: $orange;
    color: white;
    font-weight: bold;
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
.checkbox {
    box-shadow: $shadow-length $shadow-length $dark-color;
    border-radius: $border-radius;


}




</style>