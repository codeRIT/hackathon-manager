<template>
    <div id="container">
        
        <header>
            <div class="icon"></div>
        </header>

        <div class="module">
            <div class="meta">
                <h1 class="title">Your Team</h1>
                <h3 class="manage">manage</h3>
            </div>

            <div class="body">
                <div class="team-member">
                    <div class="icon"></div>
                    <div>
                        <h2 class="name">John Smith</h2>
                        <p class="school">Rochester Institute of Technology</p>
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>

<script>
export default {
    // Code? in _my_ VS?
}
</script>

<style lang="scss" scoped>
#container {
    width: 100%;
    min-height: 100%;
    display: flex;
    flex-direction: column;
    justify-content: center;
}

header {
    background-color: gray;
    width: 100%;
    height: 25vh;

    .icon {
        background-color: darkgray;
        margin-left: auto;
        margin-right: auto;
        margin-bottom: -3rem;
        width: 6rem;
        height: 6rem;
        border-radius: 1rem;
    }
}

// "Your Team", "Bus", etc.
.module {
    margin-left: 1rem;
    margin-right: 1rem;

    .meta {
        display: flex;
        justify-content: space-between;
        align-items: baseline;
    }

    .body {
        background-color: gray;
        padding: 20px;
        display: flex;
        flex-direction: column;
        border-radius: 0.5rem;

        .team-member {
            display: flex;
            flex-direction: row;
            align-items: center;
            gap: 20px;

            .icon {
                background-color: darkgray;
                width: 2rem;
                height: 2rem;
                border-radius: 0.25rem;
            }
        }
    }
}
</style>
