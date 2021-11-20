<template>
    <Card>
        <div class="intro">
            <h1 class="title">{{ $t("pages.application.personalInfo.title") }}</h1>
            <p class="subtitle">{{ $t("pages.application.personalInfo.subtitle") }}</p>
        </div>

        <div class="row">
            <div class="col-6">
                <TextInput
                    id="date_of_birth"
                    :label="$t('pages.application.personalInfo.dateOfBirth.label')"
                    :placeholder="$t('pages.application.personalInfo.dateOfBirth.placeholder')"
                ></TextInput>
                <Dropdown id="country" :label="$t('pages.application.personalInfo.country')">
                    <option>United States</option>
                    <option>Germany</option>
                </Dropdown>
                <Dropdown id="school" :label="$t('pages.application.personalInfo.school')">
                    <option>Rochester Institute of Technology</option>
                    <option>University of Rochester</option>
                </Dropdown>
                <TextInput
                    id="gender"
                    :label="$t('pages.application.personalInfo.gender.label')"
                    :placeholder="$t('pages.application.personalInfo.gender.placeholder')"
                ></TextInput>
            </div>

            <div class="col-6">
                <TextInput
                    id="phone"
                    :label="$t('pages.application.personalInfo.phone.label')"
                    :placeholder="$t('pages.application.personalInfo.phone.placeholder')"
                ></TextInput>
                <Dropdown id="race_ethnicity" :label="$t('pages.application.personalInfo.raceEthnicity.label')">
                    <option value="White / Caucasian">{{ $t('pages.application.personalInfo.raceEthnicity.whiteCaucasian') }}</option>
                    <option value="Hispanic">{{ $t('pages.application.personalInfo.raceEthnicity.hispanic') }}</option>
                </Dropdown>
                <TextInput
                    id="major"
                    :label="$t('pages.application.personalInfo.major.label')"
                    :placeholder="$t('pages.application.personalInfo.major.placeholder')"
                ></TextInput>
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
@import "../../assets/scss/application.scss";
</style>
