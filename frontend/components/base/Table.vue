<template>
    <!--
        We need to use two containers here to make the drop shadow work because the table's drop shadow is not part of
        its bounding box, so the `overflow-y: scroll` on the outer container cuts it off. The inner container has
        padding so that the padding needed for the drop shadow to remain visible doesn't get cut off by overflow
        either. It's admittedly scuffed, but it works, so :shrug:.
    -->
    <div class="table-container">
        <div class="table-inner-container">
            <table :style="{ minWidth: numColumns * 125 + 'px' }">
                <tr>
                    <th v-if="showEditLink"></th>

                    <th v-for="columnName in shownColumns" :key="columnName">
                        {{ columnName }}
                    </th>
                </tr>

                <tr v-for="(row, index) in rows" :key="index">
                    <td v-if="showEditLink">
                        <font-awesome-icon icon="edit" @click="$emit('goToEdit', row)"></font-awesome-icon>
                    </td>

                    <td v-for="(value, name) in filterRow(row)" :key="name">
                        {{ value }}
                    </td>
                </tr>

                <!-- <tr v-if="paginated">
                    <td class="action-row" :colspan="numColumns">
                        <div>
                            !-- TODO: add prop for Font Awesome icons here --
                            <div class="filters">
                                filter <span class="arrow">v</span>
                            </div>

                            !-- TODO: add prop for Font Awesome icons here --
                            <div class="pagination">
                                <p class="arrow" v-on:click="goToPage(1)">&lt;</p>
                                <p class="current-page" v-on:click="goToPage(1)">1</p>
                                <p v-on:click="goToPage(2)">2</p>
                                <p v-on:click="goToPage(3)">3</p>
                                <p v-on:click="goToPage(4)">4</p>
                                <p v-on:click="goToPage(5)">5</p>
                                <p class="arrow" v-on:click="goToPage(2)">&gt;</p>
                            </div>
                        </div>
                    </td>
                </tr> -->
            </table>
        </div>
    </div>
</template>

<script>
import { FontAwesomeIcon } from "@fortawesome/vue-fontawesome"

export default {
    name: 'Table',
    components: {
        FontAwesomeIcon
    },
    props: {
        rows: Array,
        paginated: Boolean,
        pageSize: Number,
        showEditLink: Boolean,
        shownColumns: Object
    },
    data () {
        return {
            pageNumber: 0
        }
    },
    emits: ["goToEdit"],
    computed: {
        numColumns: function() {
            let num = Object.keys(this.shownColumns).length;
            if (this.showEditLink) {
                num++
            }
            return num
        },

        numPages: function() {
            return Math.ceil(this.rows.length / pageSize)
        }
    },
    methods: {
        goToPage: function(pageNumber) {
            alert(`going to page #${pageNumber}\nto be implemented later!`)
        },

        filterRow: function(row) {
            let shownColumnKeys = Object.keys(this.shownColumns)

            // filter columns in row and sort by order specified in this.shownColumns
            return Object.fromEntries(
                Object.entries(row)
                    .filter(([key, value]) => shownColumnKeys.includes(key))
                    .sort((x, y) => shownColumnKeys.indexOf(x[0]) - shownColumnKeys.indexOf(y[0]))
            )
        }
    }
}
</script>

<style lang="scss" scoped>
.table-container {
    overflow-x: scroll;
}

.table-inner-container {
    padding: var(--shadow-length);
    min-width: min-content;
}

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

.action-row {
    padding: 0;

    & > div {
        display: flex;
        width: 100%;
    }
}

.pagination {
    border-left: 2px solid var(--dark-color);
    display: flex;
    gap: 0.5rem;
    margin-left: auto;
    padding: 15px 20px;

    & > span {
        cursor: pointer;
    }
}

.filters {
    border-right: 2px solid var(--dark-color);
    cursor: pointer;
    display: flex;
    gap: 0.5rem;
    padding: 15px 20px;
}

.current-page {
    font-weight: bold;
}
</style>
