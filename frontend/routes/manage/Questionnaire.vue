<template>
<div class="container">
    <div class="header">
        <h1>John Smith (ID #{{ $route.params.id }})</h1>
        <a href="#">edit</a>
    </div>

    <div class="row">
        <div class="col-6">
            <VerticalGroup class="dictionary" name="Personal info">
                <div class="item">
                    <p class="key">First Name</p>
                    <p class="value">John</p>
                </div>

                <div class="item">
                    <p class="key">Last Name</p>
                    <p class="value">Smith</p>
                </div>

                <div class="item">
                    <p class="key">Email</p>
                    <p class="value">johnsmith@example.com</p>
                </div>

                <div class="item">
                    <p class="key">Phone</p>
                    <p class="value">1234567890</p>
                </div>

                <div class="item">
                    <p class="key">Date of birth</p>
                    <p class="value">01/01/1990</p>
                </div>

                <div class="item">
                    <p class="key">Gender</p>
                    <p class="value">Non-Binary</p>
                </div>

                <div class="item">
                    <p class="key">Country</p>
                    <p class="value">United States</p>
                </div>
            </VerticalGroup>

            <VerticalGroup class="dictionary" name="Resume">
                <div class="item">
                    <p class="key">Why YeetHaw Hacks?</p>
                    <p class="value">I like to hack</p>
                </div>

                <div class="item">
                    <p class="key">Experience</p>
                    <p class="value">My feet are wet. (1-5 hackathons)</p>
                </div>

                <div class="item">
                    <p class="key">Portfolio</p>
                    <p class="value light">Not provided</p>
                </div>

                <div class="item">
                    <p class="key">GitHub/GitLab/Bitbucket</p>
                    <p class="value light">Not provided</p>
                </div>

                <div class="item">
                    <p class="key">Resume</p>
                    <p class="value light">Not provided</p>
                </div>
            </VerticalGroup>
        </div>

        <div class="col-6">
            <VerticalGroup class="action-items" name="Check-in compliance">
                <div class="item action">
                    <div class="icon"></div>
                    <p>Has not been accepted</p>
                    <a href="#">change</a>
                </div>
                <div class="item action">
                    <div class="icon"></div>
                    <p>Not RSVP'd as attending</p>
                    <a href="#">change</a>
                </div>
                <div class="item">
                    <div class="icon completed"></div>
                    <p>18 years or older</p>
                </div>
                <div class="item">
                    <div class="icon"></div>
                    <p>Fun agreement, not accepted</p>
                </div>
            </VerticalGroup>

            <VerticalGroup class="dictionary" name="Special notices">
                <div class="item">
                    <p class="key">Shirt size</p>
                    <p class="value">Unisex M</p>
                </div>

                <div class="item">
                    <p class="key">Dietary restrictions</p>
                    <p class="value light">(none)</p>
                </div>

                <div class="item">
                    <p class="key">Bus list</p>
                    <p class="value light">(none)</p>
                </div>

                <div class="item">
                    <p class="key">Bus captain</p>
                    <p class="value light">No</p>
                </div>


                <div class="item">
                    <p class="key">Travelling from</p>
                    <p class="value light">My school</p>
                </div>
            </VerticalGroup>

            <VerticalGroup class="dictionary" name="Education">
                <div class="item">
                    <p class="key">School</p>
                    <p class="value"><a href="#">Rochester Institute of Technology</a></p>
                </div>

                <div class="item">
                    <p class="key">Major</p>
                    <p class="value"><a href="#">BS Packaging Science</a></p>
                </div>

                <div class="item">
                    <p class="key">Level of study</p>
                    <p class="value"><a href="#">University (Undergraduate)</a></p>
                </div>
            </VerticalGroup>
        </div>
    </div>
</div>
</template>

<script>
import VerticalGroup from "../../components/VerticalGroup.vue"

export default {
    components: {
        "VerticalGroup": VerticalGroup
    }
}
</script>

<style lang="scss" scoped>
.header {
    display: flex;
    align-items: baseline;
    margin-bottom: 1rem;
    padding-bottom: 1rem;
    border-bottom: 0.125rem solid lightgray;

    * {
        padding-bottom: 0;
    }

    *:first-child {
        margin-right: auto;
    }

    a {
        font-size: 1.17em;  // default h3
    }
}

.dictionary .item {
    align-items: flex-start;

    p.key {
        font-weight: bold;
        width: 33%;
    }

    p.value {
        width: 67%;
    }

    .light {
        color: rgb(85, 85, 85);
    }
}

.action-items .item {
    position: relative;

    &.action:hover {
        background-color: gray;
    }

    &.action a {
        margin-left: auto;

        &::after {
            // essentially copying Bootstrap's `.stretched-link`
            // TODO: replace w/ JS?

            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            pointer-events: auto;
            content: "";
            background-color: transparent;
        }
    }

    .icon {
        background-color: darkgray;
        width: 1.5rem;
        height: 1.5rem;
        border-radius: 0.375rem;

        &.completed {
            background-color: orange;
        }
    }
}
</style>