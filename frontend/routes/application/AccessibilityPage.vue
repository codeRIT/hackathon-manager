<template>
    <Card>
        <div class="intro">
            <h1>{{ $t("pages.application.accessibility.title") }}</h1>
            <p class="subtitle">{{ $t("pages.application.accessibility.subtitle") }}</p>
        </div>

        <div class="row">
            <div class="col-12">
                <div>
                    <Checkbox
                        name="captioning"
                        value="true"
                        :content="$t('pages.application.accessibility.captioning')"
                    ></Checkbox>

                    <Checkbox
                        name="interpreter"
                        value="true"
                        :content="$t('pages.application.accessibility.interpreter')"
                    ></Checkbox>
                </div>

                <TextArea
                    id="dietary_restrictions"
                    :label="$t('pages.application.accessibility.dietaryRestrictions.label')"
                    :placeholder="$t('pages.application.accessibility.dietaryRestrictions.placeholder')"
                ></TextArea>

                <TextArea
                    id="special_needs"
                    :label="$t('pages.application.accessibility.specialNeeds.label')"
                    :placeholder="$t('pages.application.accessibility.specialNeeds.placeholder')"
                ></TextArea>
            </div>
        </div>
    </Card>
</template>

<script>
import Card from "../../components/base/Card.vue"
import Checkbox from "../../components/base/Checkbox.vue"
import TextArea from "../../components/base/TextArea.vue"

export default {
    name: "AccessibilityPage",
    components: {
        Card,
        Checkbox,
        TextArea
    }
}
</script>

<style lang="scss" scoped>
@import "../../assets/scss/application.scss";
</style>
