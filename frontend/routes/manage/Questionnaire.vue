<template>
<div class="container">
    <div class="header">
        <h1>John Smith (ID #{{ $route.params.id }})</h1>
        <a href="#">edit</a>
    </div>
</div>
</template>

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
</style>