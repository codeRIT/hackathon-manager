<template>
    <Card>
        <div class="intro">
            <h1>{{ $t("pages.application.application.title") }}</h1>
            <p class="subtitle">{{ $t("pages.application.application.subtitle") }}</p>
        </div>

        <div class="row">
            <div class="col-12">
                <TextArea
                    id="why_attend"
                    :label="$t(
                        'pages.application.application.whyAttend.label',
                        { hackathonName: '<HackathonName>' }
                    )"
                    :placeholder="$t('pages.application.application.whyAttend.placeholder')"
                ></TextArea>

                <div>
                    <p class="question-label">{{ $t('pages.application.application.experience.label') }}</p>
                    <Radio
                        name="experience"
                        value="none"
                        :content="$t('pages.application.application.experience.none')"
                    ></Radio>
                    <Radio
                        name="experience"
                        value="few"
                        :content="$t('pages.application.application.experience.few')"
                    ></Radio>
                    <Radio
                        name="experience"
                        value="many"
                        :content="$t('pages.application.application.experience.many')"
                    ></Radio>
                </div>

                <TextInput
                    id="interest"
                    :label="$t('pages.application.application.interest.label')"
                    :placeholder="$t('pages.application.application.interest.placeholder')"
                ></TextInput>
            </div>
        </div>

        <div class="row">
            <div class="col-6">
                <TextInput
                    id="vcs_url"
                    :label="$t('pages.application.application.vcsURL.label')"
                    :placeholder="$t('pages.application.application.vcsURL.placeholder')"
                ></TextInput>
            </div>

            <div class="col-6">
                <TextInput
                    id="portfolio_url"
                    :label="$t('pages.application.application.portfolioURL.label')"
                    :placeholder="$t('pages.application.application.portfolioURL.placeholder')"
                ></TextInput>
            </div>
        </div>

        <div class="row">
            <div class="col-12">
                <p>TODO: add resume upload once we have a file upload component</p>

                <Dropdown id="shirt_size" :label="$t('pages.application.application.shirtSize.label')">
                    <option value="unisexXS">{{ $t('pages.application.application.shirtSize.unisexXS') }}</option>
                    <option value="unisexS">{{ $t('pages.application.application.shirtSize.unisexS') }}</option>
                    <option value="unisexM">{{ $t('pages.application.application.shirtSize.unisexM') }}</option>
                    <option value="unisexL">{{ $t('pages.application.application.shirtSize.unisexL') }}</option>
                    <option value="unisexXL">{{ $t('pages.application.application.shirtSize.unisexXL') }}</option>
                    <option value="unisexXXL">{{ $t('pages.application.application.shirtSize.unisexXXL') }}</option>
                </Dropdown>
            </div>
        </div>
    </Card>
</template>

<script>
import Card from "../../components/base/Card.vue"
import Dropdown from "../../components/base/Dropdown.vue"
import Radio from "../../components/base/Radio.vue"
import TextArea from "../../components/base/TextArea.vue"
import TextInput from "../../components/base/TextInput.vue"

export default {
    name: "ApplicationPage",
    components: {
        Card,
        Dropdown,
        Radio,
        TextArea,
        TextInput
    }
}
</script>

<style lang="scss" scoped>
@import "../../assets/scss/application.scss";
</style>
