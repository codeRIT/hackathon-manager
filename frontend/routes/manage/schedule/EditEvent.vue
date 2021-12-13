<template>
    <div class="row">
        <div class="col-12">
            <h1>Edit Event</h1>

            <Card>
                <div class="row">
                    <div class="col-12">
                        <TextInput
                            v-model="title"
                            :label="$t('pages.manage.schedule.edit.title.label')"
                            :placeholder="$t('pages.manage.schedule.edit.title.placeholder')"
                        ></TextInput>

                        <TextArea
                            v-model="description"
                            :label="$t('pages.manage.schedule.edit.description.label')"
                            :placeholder="$t('pages.manage.schedule.edit.description.placeholder')"
                        ></TextArea>

                        <!-- TODO: add start/end datetime pickers -->
                    </div>
                </div>
            </Card>
        </div>
    </div>
</template>

<script>
import Card      from "../../../components/base/Card.vue"
import TextArea  from "../../../components/base/TextArea.vue"
import TextInput from "../../../components/base/TextInput.vue"

export default {
    name: 'EditEvent',
    components: {
        Card,
        TextArea,
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
