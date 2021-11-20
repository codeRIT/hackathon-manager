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
                    <div class="buttons">
                        <Button v-if="prevButtonVisible()" :content="$t('pages.application.prevButton')" :onclick="prevPage"></Button>
                        <Button class="always-right" :content="nextButtonText()" :onclick="nextPage"></Button>
                    </div>
                </div>
            </div>
        </main>
    </div>
</template>

<script>
import Button from "../components/base/Button.vue"
import HorizontalGroup from "../components/base/HorizontalGroup.vue"

const pages = ["personalInfo", "application", "accessibility", "agreements"];

export default {
    name: 'Application',
    components: {
        Button,
        HorizontalGroup
    },
    data() {
        return {
            currentPage: this.currentPageIndex()
        }
    },
    methods: {
        currentPageIndex() {
            let route = this.$route.fullPath.split('/').slice(-1)[0];
            return pages.findIndex(x => x === route);
        },

        nextButtonText() {
            if (this.currentPage === pages.length - 1) {
                return this.$t("pages.application.nextButton.apply")
            } else {
                return this.$t("pages.application.nextButton.next")
            }
        },

        nextPage() {
            if (this.currentPage === pages.length - 1) {  // at last page
                alert("TODO: submit data");
            } else {
                this.currentPage++;
                this.$router.push({ path: "/application/" + pages[this.currentPage] });
            }
        },

        prevButtonVisible() {
            return this.currentPage !== 0;
        },

        prevPage() {
            if (this.currentPage > 0) {
                this.currentPage--;
                this.$router.push({ path: "/application/" + pages[this.currentPage] });
            }
        }
    },
    watch: {
        $route(oldRoute, newRoute) {
            this.currentPage = this.currentPageIndex();
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
    margin: 1.5rem auto 0 auto;

    .router-link-active {
        background-color: var(--orange);
        color: white;
    }
}

.buttons {
    display: flex;
    flex-direction: row;
    justify-content: space-between;
    width: 100%;
}
.always-right {
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
