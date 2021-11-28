<template>
    <div>
        <h1>Schedule</h1>

        <div class="day" v-for="(events, day) in days" :key="day">
            <h2>{{ day }}</h2>  <!-- TODO: cleaner date formatting and structure -->
            <Table v-for="(events, day) in days" :key="day" :rows="events" editLink="edit"></Table>
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
                        "Title": "Opening Ceremony",
                        "Description": "lorem ipsum",
                        "Start time": "9:30am",
                        "End time": "10:00am"
                    },
                    {
                        "Title": "Opening Ceremony",
                        "Description": "lorem ipsum",
                        "Start time": "9:30am",
                        "End time": "10:00am"
                    },
                    {
                        "Title": "Opening Ceremony",
                        "Description": "lorem ipsum",
                        "Start time": "9:30am",
                        "End time": "10:00am"
                    },
                    {
                        "Title": "Opening Ceremony",
                        "Description": "lorem ipsum",
                        "Start time": "9:30am",
                        "End time": "10:00am"
                    }
                ],
                "2021-11-28": [
                    {
                        "Title": "Opening Ceremony",
                        "Description": "lorem ipsum",
                        "Start time": "9:30am",
                        "End time": "10:00am"
                    },
                    {
                        "Title": "Opening Ceremony",
                        "Description": "lorem ipsum",
                        "Start time": "9:30am",
                        "End time": "10:00am"
                    },
                    {
                        "Title": "Opening Ceremony",
                        "Description": "lorem ipsum",
                        "Start time": "9:30am",
                        "End time": "10:00am"
                    },
                    {
                        "Title": "Opening Ceremony",
                        "Description": "lorem ipsum",
                        "Start time": "9:30am",
                        "End time": "10:00am"
                    }
                ]
            }
        }
    }
}
</script>
