<template>
    <nav>
        <!-- TODO: use HorizontalGroup base component, once it exists -->
        <div class="navbar">
            <a class="active" href="#">{{ $t("pages.manage.navbar.dashboard") }}</a>
            <a href="#">{{ $t("pages.manage.navbar.questionnaire") }}</a>
            <a href="#">{{ $t("pages.manage.navbar.admissions") }}</a>
            <a href="#">{{ $t("pages.manage.navbar.users") }}</a>
            <a href="#">{{ $t("pages.manage.navbar.schools") }}</a>
            <a href="#">{{ $t("pages.manage.navbar.schedule") }}</a>
            <a href="#">{{ $t("pages.manage.navbar.settings") }}</a>
        </div>

        <div class="user">
            <a href="#"><div class="icon"></div> User</a>
            <a href="#">{{ $t("pages.manage.navbar.logout") }}</a>
        </div>
    </nav>
</template>

<script>
export default {
    name: 'ManageNavbar'
}
</script>

<style lang="scss" scoped>
nav {
    display: flex;
    justify-content: space-between;

    .user {
        display: flex;

        a {
            padding: 1.25rem;
            background-color: lightgray;
            display: flex;
            flex-direction: row;
            align-items: center;
            gap: 1.25rem;
            transition: background-color 0.25s;

            &:first-child {
                border-radius: 0.5rem 0 0 0.5rem;
                padding-top: 1.25rem;
            }

            &:last-child {
                border-radius: 0 0.5rem 0.5rem 0;
                padding-bottom: 1.25rem;
            }

            &:hover {
                background-color: gray;
            }

            .icon {
                background-color: orange;
                width: 1.5rem;
                height: 1.5rem;
                border-radius: 0.5rem;
            }
        }
    }

    .navbar {
        display: flex;

        a {
            padding: 1.25rem;
            background-color: lightgray;
            display: flex;
            flex-direction: row;
            align-items: center;
            gap: 1.25rem;
            transition: background-color 0.25s;

            &:first-child {
                border-radius: 0.5rem 0 0 0.5rem;
                padding-top: 1.25rem;
            }

            &:last-child {
                border-radius: 0 0.5rem 0.5rem 0;
                padding-bottom: 1.25rem;
            }

            &:hover:not(.active) {
                background-color: gray;
            }

            &.active {
                background-color: orange;
            }

            &.active:hover {
                background-color: darkorange;
            }
        }
    }
}
</style>
