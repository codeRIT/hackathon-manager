<template>
    <div id="container">
        <header>
            <button type="button" class="button">Logout</button>
            <h1 class="title">YeeHaw Hacks Application</h1>
        </header>

        <div class="body">
            <div class="sectionList" :key="section" v-for="section in sectionOption">
                <button>{{ section }}</button>
            </div>
        </div>
    </div>
</template>

<script>
    export default {
        name: "Application",
        data () {
            return {
                sectionOption: ["Section0", "Section1", "Section2", "Section3", "Section4", "Section5"]
            }
        }
    }
</script>

<style lang="scss" scoped>
header {
    background-color: darkgray;
    width: 100%;
    height: 25vh;
    margin: auto;

    .button {
        float: right;
    }

    .title {
        padding-top: 6rem;
        text-align: center;
    }
}

body {
    .sectionList {
        
    }
}


</style>