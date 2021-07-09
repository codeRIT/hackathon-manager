<template>
<div class="vertical-group">
    <div class="meta">
        <h2>{{ name }}</h2>
        <slot name="actions"></slot>
    </div>

    <div class="body">
        <slot></slot>
    </div>
</div>
</template>

<script>
export default {
    props: ["name"]
}
</script>

<style lang="scss" scoped>
.vertical-group {
    .meta {
        display: flex;
        justify-content: space-between;
        align-items: baseline;
        margin-bottom: 0.25rem;

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

    .body {
        display: flex;
        flex-direction: column;

        :deep .item {
            padding: 0.75rem 1.25rem;
            background-color: lightgray;
            display: flex;
            flex-direction: row;
            align-items: center;
            gap: 1.25rem;

            &:first-child {
                border-radius: 0.5rem 0.5rem 0 0;
                padding-top: 1.25rem;
            }

            &:last-child {
                border-radius: 0 0 0.5rem 0.5rem;
                padding-bottom: 1.25rem;
            }
        }
    }
}
</style>