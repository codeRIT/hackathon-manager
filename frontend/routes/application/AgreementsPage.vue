<template>
    <Card>
        <div class="intro">
            <h1>{{ $t("pages.application.agreements.title") }}</h1>
            <p>{{ $t("pages.application.agreements.subtitle") }}</p>
        </div>

        <div class="row">
            <div class="col-12">

            </div>
        </div>
    </Card>
</template>

<script>
import Card from "../../components/base/Card.vue"
import Checkbox from "../../components/base/Checkbox.vue"
import TextArea from "../../components/base/TextArea.vue"

export default {
    name: "AgreementsPage",
    components: {
        Card,
        Checkbox,
        TextArea
    }
}
</script>

<style lang="scss" scoped>
.intro {
    padding-bottom: 1rem;
}
</style>
