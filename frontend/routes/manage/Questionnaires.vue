<template>
<div class="container">
    <div class="module">
        <div class="meta">
            <h2 class="title">Questionnaires</h2>
            <a class="action">filter</a>
        </div>

        <table class="body list">
            <tr>
                <th class="hidden"></th>  <!-- used for row links -->
                <th>First Name</th>
                <th>Last Name</th>
                <th>Email</th>
                <th>Status</th>
                <th>Checked in?</th>
                <th>Applied On</th>
            </tr>
            <tr>
                <td class="hidden"><router-link class="link" to="/manage/questionnaires/1"></router-link></td>
                <td>John</td>
                <td>Smith</td>
                <td>johnsmith@example.com</td>
                <td>RSVP Accepted</td>
                <td>Yes</td>
                <td>7/5/21</td>
            </tr>
            <tr>
                <td class="hidden"><router-link class="link" to="/manage/questionnaires/2"></router-link></td>
                <td>John</td>
                <td>Smith</td>
                <td>johnsmith@example.com</td>
                <td>RSVP Accepted</td>
                <td>Yes</td>
                <td>7/5/21</td>
            </tr>
            <tr>
                <td class="hidden"><router-link class="link" to="/manage/questionnaires/3"></router-link></td>
                <td>John</td>
                <td>Smith</td>
                <td>johnsmith@example.com</td>
                <td>RSVP Accepted</td>
                <td>Yes</td>
                <td>7/5/21</td>
            </tr>
        </table>
    </div>
</div>
</template>

<style lang="scss" scoped>
.module {
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
            transition: background-color 0.25s;
            position: relative;

            a.link::after {
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

            &:not(:first-child):hover {
                background: gray;
            }
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