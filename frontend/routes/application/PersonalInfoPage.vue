<template>
    <Card>
        <div class="intro">
            <h1>{{ $t("pages.application.personalInfo.title") }}</h1>
            <p>{{ $t("pages.application.personalInfo.subtitle") }}</p>
        </div>

        <div class="row">
            <div class="col-6">
                <TextInput id="date_of_birth" :label="$t('pages.application.personalInfo.dateOfBirth')" placeholder="01/01/2000"></TextInput>
                <Dropdown id="country" label="Country">
                    <option>United States</option>
                    <option>Germany</option>
                </Dropdown>
                <Dropdown id="school" label="School">
                    <option>Rochester Institute of Technology</option>
                    <option>University of Rochester</option>
                </Dropdown>
                <TextInput id="gender" label="Gender" placeholder="Non-binary"></TextInput>
            </div>

            <div class="col-6">
                <TextInput id="phone" label="Phone number" placeholder="(123) 456-7890"></TextInput>
                <Dropdown id="race_ethnicity" label="Race / Ethnicity">
                    <option>White / Caucasian</option>
                    <option>Hispanic</option>
                </Dropdown>
                <TextInput id="major" label="Major" placeholder="New Media Design"></TextInput>
            </div>
        </div>
    </Card>
</template>

<script>
import Card from "../../components/base/Card.vue"
import Dropdown from "../../components/base/Dropdown.vue"
import TextInput from "../../components/base/TextInput.vue"

export default {
    name: "PersonalInfoPage",
    components: {
        Card,
        Dropdown,
        TextInput
    }
}
</script>

<style lang="scss" scoped>
.intro {
    padding-bottom: 1rem;
}
</style>