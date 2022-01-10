<template>
    <FormLayout>
        <Card>
            <form>
                <h1>{{ $t("pages.signin.main.title", { hackathonName: "<HackathonName>"}) }}</h1>
                <TextInput id="email" :placeholder="$t('pages.signin.main.email')" type="email" fullWidth />
                <TextInput id="password" :placeholder="$t('pages.signin.main.password')" type="password" fullWidth />
                <Checkbox id="remember" class="checkbox" :content="$t('pages.signin.main.remember')" name="checkbox-test" value="remember"></Checkbox>
                <Button :content="$t('pages.signin.main.signin')" type="submit"></Button>
                <router-link to="/register"><Button :content="$t('pages.signin.main.register')"></Button></router-link>
            </form>
        </Card>
        <Card>
            <h2>{{ $t("pages.signin.alternatives.title") }}</h2>
            <Button :content="$t('pages.signin.alternatives.myMLH')"></Button>
            <Button :content="$t('pages.signin.alternatives.google')"></Button>
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
