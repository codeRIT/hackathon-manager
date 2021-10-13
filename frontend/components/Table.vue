<template>
    <table>
        <tr>
            <th v-if="editLink !== null"></th>

            <th v-for="columnName in tableHeader" :key="columnName">
                {{ columnName }}
            </th>
        </tr>

        <tr v-for="(row, index) in rows" :key="index">
            <td v-if="editLink !== null"><a :href="editLink">X</a></td>

            <td v-for="(value, name) in row" :key="name">
                {{ value }}
            </td>
        </tr>
    </table>
</template>

<script>
export default {
    name: 'Table',
    props: {
        rows: Array,
        editLink: String
    },
    data () {
        return {}
    },
    computed: {
        tableHeader: function() {
            if (this.rows.length == 0) {
                return []
            } else {
                const row = []
                for (let key of Object.keys(this.rows[0])) {
                    row.push(key)
                }
                return row
            }
        }
    }
}
</script>

<style lang="scss" scoped>
table {
    background-color: white;
    border-collapse: separate;
    border-spacing: 0;
    color: var(--dark-color);
    border: 2px solid var(--dark-color);
    border-radius: var(--border-radius);
    box-shadow: var(--shadow-length) var(--shadow-length) var(--dark-color);
    width: 100%;
}

th {
    text-align: left;
}

th, td {
    border-bottom: 2px solid var(--dark-color);
    padding: 15px 20px;
}

tr:last-child {
    th, td {
        border-bottom: unset;
    }
}
</style>