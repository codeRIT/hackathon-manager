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
            <a href="#">User</a>
            <a href="#">{{ $t("pages.manage.navbar.logout") }}</a>
        </HorizontalGroup>
    </nav>
</template>

<script>
import HorizontalGroup from "./base/HorizontalGroup.vue";

export default {
    name: 'ManageNavbar',
    components: {
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
