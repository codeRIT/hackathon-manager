<template>
    <div>
        <h1>{{ $t("pages.manage.schedule.title") }}</h1>

        <div class="day" v-for="(events, day) in days" :key="day">
            <h2>{{ day }}</h2>  <!-- TODO: cleaner date formatting and structure -->
            <Table :rows="events" :shownColumns="tableColumns" :showEditLink="true" @go-to-edit="goToEdit"></Table>
        </div>
    </div>
</template>

<script>
import Table from "../../../components/base/Table.vue"

export default {
    name: 'Schedule',
    components: {
        Table
    },
    data() {
        return {
            days: {
                "2021-11-27": [
                    {
                        id: 1,
                        title: "Opening Ceremony",
                        description: "lorem ipsum",
                        start: "9:30am",
                        end: "10:00am"
                    },
                    {
                        id: 2,
                        title: "Opening Ceremony",
                        description: "lorem ipsum",
                        start: "9:30am",
                        end: "10:00am"
                    },
                    {
                        id: 3,
                        title: "Opening Ceremony",
                        description: "lorem ipsum",
                        start: "9:30am",
                        end: "10:00am"
                    },
                    {
                        id: 4,
                        title: "Opening Ceremony",
                        description: "lorem ipsum",
                        start: "9:30am",
                        end: "10:00am"
                    }
                ],
                "2021-11-28": [
                    {
                        id: 5,
                        title: "Opening Ceremony",
                        description: "lorem ipsum",
                        start: "9:30am",
                        end: "10:00am"
                    },
                    {
                        id: 6,
                        title: "Opening Ceremony",
                        description: "lorem ipsum",
                        start: "9:30am",
                        end: "10:00am"
                    },
                    {
                        id: 7,
                        title: "Opening Ceremony",
                        description: "lorem ipsum",
                        start: "9:30am",
                        end: "10:00am"
                    },
                    {
                        id: 8,
                        title: "Opening Ceremony",
                        description: "lorem ipsum",
                        start: "9:30am",
                        end: "10:00am"
                    }
                ]
            },
            tableColumns: {
                title: "Title",
                start: "Start time",
                end: "End time",
                description: "Description"
            }
        }
    },
    methods: {
        goToEdit(event) {
            this.$router.push('/manage/schedule/edit/' + event.id);
        }
    }
}
</script>
