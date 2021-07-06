<template>
<div>
    <nav class="container">
        <div class="navbar">
            <a class="active" href="#">Dashboard</a>
            <a href="#">Users</a>
            <a href="#">Schools</a>
            <a href="#">Questionnaires</a>
            <a href="#">Schedule</a>
            <a href="#">Settings</a>
        </div>

        <div class="user">
            <a href="#"><div class="icon"></div> User</a>
            <a href="#">Logout</a>
        </div>
    </nav>
</div>
</template>

<script>
export default {

}
</script>

<style lang="scss" scoped>
nav {
    display: flex;
    justify-content: space-between;
    padding: 4rem;

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