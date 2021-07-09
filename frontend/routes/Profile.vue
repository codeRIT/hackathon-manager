<template>
<div style="position: relative;">
    <nav>
        <a href="#"><div class="icon"></div></a>
        <a href="#">Logout</a>
    </nav>

    <header>
        <div class="banner"></div>
        <div class="icon"></div>

        <h1 class="username">John Smith <a class="edit"></a></h1>
        <h4>Rochester Institute of Technology</h4>
    </header>
    
    <div class="container">
        <div class="row">
            <div class="col-6">
                <div class="cta-button">
                    <h2>Confirm your attendance</h2>
                    <h4>Awaiting RSVP</h4>
                </div>

                <VerticalGroup class="team" name="My Team">
                    <template #actions>
                        <a href="#">manage</a>
                    </template>

                    <template #default>
                        <div class="item">
                            <div class="icon"></div>
                            <div>
                                <h2 class="name">John Smith</h2>
                                <h4 class="school">Rochester Institute of Technology</h4>
                            </div>
                        </div>

                        <div class="item">
                            <div class="icon"></div>
                            <div>
                                <h2 class="name">John Smith</h2>
                                <h4 class="school">Rochester Institute of Technology</h4>
                            </div>
                        </div>

                        <div class="item">
                            <div class="icon icon-orange"></div>
                            <div>
                                <h2 class="name">Invite a teammate</h2>
                            </div>
                        </div>
                    </template>
                </VerticalGroup>
            </div>

            <div class="col-6">
                <!-- <div class="module">
                    <div class="meta">
                        <h2 class="title">Bus</h2>
                        <a class="manage" href="#">change</a>
                    </div>

                    <div class="body">
                        <div class="item">
                            <div class="icon"></div>
                            <div>
                                <h2 class="name">Arriving at 12:30pm</h2>
                                <h4 class="school">5000 Nathaniel Rochester Dr</h4>
                            </div>
                        </div>

                        <div class="item">
                            <div class="icon icon-orange"></div>
                            <div>
                                <h2 class="name">Contact bus leader</h2>
                            </div>
                        </div>
                    </div>
                </div> -->

                <VerticalGroup class="bus" name="Bus">
                    <template #actions>
                        <a href="#">change</a>
                    </template>

                    <template #default>
                        <div class="item">
                            <div class="icon"></div>
                            <div>
                                <h2 class="name">Arriving at 12:30pm</h2>
                                <h4 class="school">5000 Nathaniel Rochester Dr</h4>
                            </div>
                        </div>

                        <div class="item">
                            <div class="icon icon-orange"></div>
                            <div>
                                <h2 class="name">Contact bus leader</h2>
                            </div>
                        </div>
                    </template>
                </VerticalGroup>
            </div>
        </div>
    </div>
</div>
</template>

<script>
import VerticalGroup from "../components/VerticalGroup.vue"

export default {
    components: {
        "VerticalGroup": VerticalGroup
    }
}
</script>

<style lang="scss" scoped>
nav {
    position: absolute;
    top: 2rem;
    right: 10rem;
    display: flex;
    align-items: center;

    .icon {
        background-color: orange;
        width: 1.5rem;
        height: 1.5rem;
        border-radius: 0.5rem;
        margin-right: 0.75rem;
    }
}

header {
    text-align: center;
    margin-bottom: 1.5rem;

    .banner {
        background-color: darkgrey;
        width: 100%;
        height: 20vh;
    }

    .icon {
        background-color: lightgrey;
        margin-left: auto;
        margin-right: auto;
        margin-top: -3rem;
        width: 6rem;
        height: 6rem;
        border-radius: 1.5rem;
    }

    .username {
        position: relative;

        .edit {
            position: absolute;
            top: 50%;
            margin-top: -0.75rem;
            margin-left: 0.75rem;

            // copied from `nav .icon`
            background-color: orange;
            width: 1.5rem;
            height: 1.5rem;
            border-radius: 0.5rem;
        }
    }
}

.cta-button {
    position: relative;
    background-color: lightgray;
    padding: 1.5rem 1.25rem;
    display: flex;
    flex-direction: column;
    border-radius: 0.5rem;
    transition: background-color 0.25s;

    &:hover {
        background-color: gray;
    }

    // scuffed pure CSS triangle - please replace this with an inline SVG or something, it's too pointy like this
    &::after {
        content: "";
        box-sizing: border-box;
        width: 2.5rem;
        height: 2.5rem;
        position: absolute;
        right: 1.25rem;
        top: 50%;
        margin-top: -1.25rem;
        border-style: solid;
        border-color: transparent transparent transparent orange;
        border-width: 1.25rem 0 1.25rem 2.5rem;
        border-radius: 0.5rem;
    }
}

// "Your Team", "Bus", etc.
.team .item, .bus .item {
    transition: background-color 0.25s;

    &:hover {
        background-color: gray;
    }

    .icon {
        background-color: darkgray;
        width: 3rem;
        height: 3rem;
        border-radius: 0.75rem;

        &.icon-orange {
            background-color: orange;
        }
    }
}
</style>
