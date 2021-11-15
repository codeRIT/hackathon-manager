<template>
    <div>
        <div class="banner">
            <h1>{{ $t("pages.application.bannerText", { hackathonName: "<HackathonName>" }) }}</h1>
        </div>

        <main class="container">
            <div class="row">
                <div class="col-12">
                    <HorizontalGroup class="nav">
                        <router-link to="/application/personalInfo">{{ $t("pages.application.personalInfo.title") }}</router-link>
                        <router-link to="/application/application">{{ $t("pages.application.application.title") }}</router-link>
                        <router-link to="/application/accessibility">{{ $t("pages.application.accessibility.title") }}</router-link>
                        <router-link to="/application/agreements">{{ $t("pages.application.agreements.title") }}</router-link>
                    </HorizontalGroup>

                    <router-view></router-view>
                </div>

                <div class="col-12">
                    <Button :content="nextButtonText" class="right-align" :onclick="nextPage"></Button>
                </div>
            </div>
        </main>
    </div>
</template>

<script>
import Button from "../components/base/Button.vue"
import HorizontalGroup from "../components/base/HorizontalGroup.vue"

export default {
    name: 'Application',
    components: {
        Button,
        HorizontalGroup
    },
    computed: {
        nextButtonText() {
            if (this.$route.fullPath.endsWith("agreements")) {
                return this.$t("pages.application.nextButton.apply")
            } else {
                return this.$t("pages.application.nextButton.next")
            }
        }
    },
    methods: {
        nextPage() {
            let currentRoute = this.$route;

            if (currentRoute.fullPath.endsWith("personalInfo")) {
                this.$router.push({ path: "/application/application" })
            } else if (currentRoute.fullPath.endsWith("application")) {
                this.$router.push({ path: "/application/accessibility" })
            } else if (currentRoute.fullPath.endsWith("accessibility")) {
                this.$router.push({ path: "/application/agreements" })
            } else {
                alert("TODO: submit data")
            }
        }
    }
}
</script>

<style lang="scss" scoped>
.banner {
    align-items: center;
    background-color: var(--orange);
    color: white;
    display: flex;
    height: 12rem;
    justify-content: center;
    width: 100%;
}

.nav {
    margin: 0 auto;

    .router-link-active {
        background-color: var(--orange);
        color: white;
    }
}

.right-align {
    margin-left: auto;
}


// stolen from Profile.vue - TODO: refactor later
@media only screen and (max-width: 768px) {
    .container {
        width: 100%;
    }

    .row {
        .col-6 {
            width: 100%;
        }
    }
}
</style>
