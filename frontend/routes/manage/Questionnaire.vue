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
                    <p class="value">{{ questionnaire.phone }}</p>
                </div>

                <div class="item">
                    <p class="key">Date of birth</p>
                    <p class="value">01/01/1990</p>
                </div>

                <div class="item">
                    <p class="key">Gender</p>
                    <p class="value">{{ questionnaire.gender }}</p>
                </div>

                <div class="item">
                    <p class="key">Country</p>
                    <p class="value">{{ questionnaire.country }}</p>
                </div>
            </VerticalGroup>

            <VerticalGroup class="dictionary" name="Resume">
                <div class="item">
                    <p class="key">Why YeetHaw Hacks?</p>
                    <p class="value" :class="{ light: questionnaire.why_attend === null }">
                        {{ questionnaire.why_attend || "Not provided" }}
                    </p>
                </div>

                <div class="item">
                    <p class="key">Experience</p>
                    <p class="value">{{ experience }}</p>
                </div>

                <div class="item">
                    <p class="key">Portfolio</p>
                    <p class="value" :class="{ light: questionnaire.portfolio_url === null }">
                        {{ questionnaire.portfolio_url || "Not provided" }}
                    </p>
                </div>

                <div class="item">
                    <p class="key">GitHub/GitLab/Bitbucket</p>
                    <p class="value" :class="{ light: questionnaire.vcs_url === null }">
                        {{ questionnaire.vcs_url || "Not provided" }}
                    </p>
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
                    <div class="icon" :class="{ completed: isAccepted }"></div>
                    <p>{{ isAccepted ? "Has been accepted" : "Has not been accepted" }}</p>
                    <a href="#">change</a>
                </div>
                <div class="item action">
                    <div class="icon" :class="{ completed: isRSVPd }"></div>
                    <p>{{ isRSVPd ? "RSVP'd as attending" : "Not RSVP'd as attending" }}</p>
                    <a href="#">change</a>
                </div>
                <div class="item">
                    <div class="icon" :class="{ completed: age >= 18 }"></div>
                    <p>{{ age >= 18 ? "18 years or older" : "Less than 18 years old" }}</p>
                </div>
                <div class="item">
                    <div class="icon" :class="{ completed: questionnaire.all_agreements_accepted }"></div>
                    <p>{{ questionnaire.all_agreements_accepted ? "All agreements accepted" : "Not all agreements accepted" }}</p>
                </div>
            </VerticalGroup>

            <VerticalGroup class="dictionary" name="Special notices">
                <div class="item">
                    <p class="key">Shirt size</p>
                    <p class="value">{{ questionnaire.shirt_size }}</p>
                </div>

                <div class="item">
                    <p class="key">Dietary restrictions</p>
                    <p class="value" :class="{ light: questionnaire.dietary_restrictions == null }">
                        {{ questionnaire.dietary_restrictions || "(none)" }}
                    </p>
                </div>

                <div class="item">
                    <p class="key">Bus list</p>
                    <p class="value light">(none)</p>
                </div>

                <div class="item">
                    <p class="key">Bus captain</p>
                    <p class="value" :class="{ light: !questionnaire.is_bus_captain }">
                        {{ questionnaire.is_bus_captain ? "Yes" : "No" }}
                    </p>
                </div>


                <div class="item">
                    <p class="key">Travelling from</p>
                    <p class="value" :class="{ light: !questionnaire.travel_not_from_school }">
                        {{ questionnaire.travel_not_from_school ? questionnaire.travel_location : "My school" }}
                    </p>
                </div>
            </VerticalGroup>

            <VerticalGroup class="dictionary" name="Education">
                <div class="item">
                    <p class="key">School</p>
                    <p class="value"><a href="#">Rochester Institute of Technology</a></p>
                </div>

                <div class="item">
                    <p class="key">Major</p>
                    <p class="value">{{ questionnaire.major }}</p>
                </div>

                <div class="item">
                    <p class="key">Level of study</p>
                    <p class="value">{{ questionnaire.level_of_study }}</p>
                </div>
            </VerticalGroup>
        </div>
    </div>

    <div class="history">
        <div class="meta">
            <h2 class="title">History</h2>
        </div>

        <table class="body list">
            <tr>
                <th>Action</th>
                <th>Modified by</th>
                <th>Timestamp</th>
            </tr>
            <tr>
                <td>Shirt size changed from Women's L to Unisex M</td>
                <td>John Smith</td>
                <td>7/5/21</td>
            </tr>
            <tr>
                <td>Email changed from test@example.com to johnsmith@example.com</td>
                <td>John Smith</td>
                <td>7/5/21</td>
            </tr>
            <tr>
                <td>User created</td>
                <td>John Smith</td>
                <td>7/5/21</td>
            </tr>
        </table>
    </div>
</div>
</template>

<script>
import VerticalGroup from "../../components/VerticalGroup.vue"

export default {
    components: {
        "VerticalGroup": VerticalGroup
    },

    created() {
        this.loadQuestionnaires(this.$route.params.id)
    },

    beforeRouteUpdate(to, from) {
        this.loadQuestionnaires(this.$route.params.id)
    },
    
    data() {
        return {
            questionnaire: {},
            isAccepted: false,
            isRSVPd: false,
            age: 0,
            experience: ""
        }
    },

    methods: {
        loadQuestionnaires(id) {
            this.questionnaire = this.api.getQuestionnaire(1)

            // process DOB
            const dob = new Date(this.questionnaire.date_of_birth)
            const delta = new Date(Date.now() - dob.getTime())
            this.age = Math.abs(delta.getUTCFullYear() - 1970)

            // process experience
            const experience = this.questionnaire.experience
            this.experience = {
                first: "This is my 1st hackathon!",
                experienced: "My feet are wet. (1-5 hackathons)",
                expert: "I'm a veteran hacker. (6+ hackathons)"
            }[experience]

            // process acceptance/RSVP
            const accStatus = this.questionnaire.acc_status
            this.isAccepted = [
                "rsvp_confirmed", "accepted", "rsvp_denied"
            ].includes(accStatus)
            this.isRSVPd = accStatus === "accepted"
        }
    },

    inject: ['api']
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

// shared w/ Questionnaires.vue
.history {
    .meta {
        display: flex;
        justify-content: space-between;
        align-items: baseline;
        margin-bottom: 0.25rem;

        .action {
            font-size: 1.17em;  // default h3
        }
    }

    table.body.list {
        border-collapse: collapse;
        border-radius: 0.5rem;
        overflow: hidden;
        width: 100%;

        td, th {
            padding: 0.75rem 1.5rem;
            text-align: left;
            border: none;

            &.hidden {
                padding: 0;
            }
        }

        tr {
            background: lightgray;
        }

        tr:first-child th, tr:first-child td {
            padding-top: 1.5rem;
        }

        tr:last-child th, tr:last-child td {
            padding-bottom: 1.5rem;
        }
    }
}
</style>