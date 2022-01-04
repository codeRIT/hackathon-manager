<template>
    <FormLayout>
        <Card>
            <form>
                <h1>{{ $t("pages.register.main.title") }}</h1>
                <TextInput id="fname" :placeholder="$t('pages.register.main.firstName')" fullWidth />
                <TextInput id="lname" :placeholder="$t('pages.register.main.lastName')" fullWidth />
                <TextInput id="email" :placeholder="$t('pages.register.main.email')" type="email" fullWidth />
                <TextInput id="password" :placeholder="$t('pages.register.main.password')" type="password" fullWidth />
                <TextInput id="confirm" :placeholder="$t('pages.register.main.confirmPassword')" type="password" fullWidth />
                <Button class="center" :content="$t('pages.register.main.register')" type="submit"></Button>
            </form>
        </Card>
        <Card>
            <h2>{{ $t("pages.register.alternatives.title") }}</h2>
            <Button :content="$t('pages.register.alternatives.myMLH')"></Button>
            <Button :content="$t('pages.register.alternatives.google')"></Button>
        </Card>
    </FormLayout>
</template>

<script>
import FormLayout from "../components/FormLayout.vue"
import Card       from "../components/base/Card.vue";
import Button     from "../components/base/Button.vue";
import TextInput  from "../components/base/TextInput.vue";
import Checkbox   from "../components/base/Checkbox.vue";

export default {
    components: {
        FormLayout,
        Card,
        Button,
        TextInput,
        Checkbox,
    },
};
</script>
