<template>
    <nav>
        <!-- TODO: replace <a>s with <router-links> as we add routes -->
        <HorizontalGroup>
            <router-link to="/manage">{{ $t("pages.manage.navbar.dashboard") }}</router-link>
            <a href="#">{{ $t("pages.manage.navbar.questionnaire") }}</a>
            <a href="#">{{ $t("pages.manage.navbar.admissions") }}</a>
            <a href="#">{{ $t("pages.manage.navbar.users") }}</a>
            <a href="#">{{ $t("pages.manage.navbar.schools") }}</a>
            <router-link to="/manage/schedule">{{ $t("pages.manage.navbar.schedule") }}</router-link>
            <a href="#">{{ $t("pages.manage.navbar.settings") }}</a>
        </HorizontalGroup>

        <HorizontalGroup>
            <a href="#"><font-awesome-icon icon="user"></font-awesome-icon></a>
            <a href="#">{{ $t("pages.manage.navbar.logout") }}</a>
        </HorizontalGroup>
    </nav>
</template>

<script>
import { FontAwesomeIcon } from "@fortawesome/vue-fontawesome"
import HorizontalGroup from "./base/HorizontalGroup.vue"

export default {
    name: 'ManageNavbar',
    components: {
        FontAwesomeIcon,
        HorizontalGroup
    }
}
</script>

<style lang="scss" scoped>
nav {
    align-items: center;
    display: flex;
    justify-content: space-between;
}
</style>
