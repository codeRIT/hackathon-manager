<template>
    <div>
        <h1>Edit Event</h1>

        <div class="row">
            <div class="col-12">
                <TextInput
                    v-model="title"
                    :label="$t('pages.manage.schedule.edit.title.label')"
                    :placeholder="$t('pages.manage.schedule.edit.title.placeholder')"
                ></TextInput>

                <TextInput
                    v-model="description"
                    :label="$t('pages.manage.schedule.edit.description.label')"
                    :placeholder="$t('pages.manage.schedule.edit.description.placeholder')"
                ></TextInput>

                <!-- TODO: add start/end datetime pickers -->
            </div>
        </div>
    </div>
</template>

<script>
import TextInput from "../../../components/base/TextInput.vue"

export default {
    name: 'EditEvent',
    components: {
        TextInput
    },
    data() {
        return {
            title: "Opening Ceremony",
            description: "lorem ipsum",
            start: "9:30am",
            end: "10:00am"
        }
    }
}
</script>
