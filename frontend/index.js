import { createApp } from "vue";
import { createRouter, createWebHistory } from "vue-router"
import { createI18n } from "vue-i18n"

import App from "./App"

import Home from "./routes/Home.vue"
import About from "./routes/About.vue"
import Profile from "./routes/Profile.vue"

import Application from "./routes/Application.vue"
import PersonalInfoPage from "./routes/application/PersonalInfoPage.vue"
import ApplicationPage from "./routes/application/ApplicationPage.vue"
import AccessibilityPage from "./routes/application/AccessibilityPage.vue"
import AgreementsPage from "./routes/application/AgreementsPage.vue"

import Manage from "./routes/manage/Manage.vue"
import Dashboard from "./routes/manage/Dashboard.vue"

// TODO: pull from server when in production
import enLocales from "./assets/locales/en-US.json"
import { loadLocaleMessage, setI18nLangauge } from "./i18n"

const routes = [
    { path: "/", component: Home },
    { path: "/about", component: About },
    {
        path: "/application",
        component: Application,
        children: [
            { path: "", redirect: "/application/personalInfo" },
            { path: "personalInfo", component: PersonalInfoPage },
            { path: "application", component: ApplicationPage },
            { path: "accessibility", component: AccessibilityPage },
            { path: "agreements", component: AgreementsPage }
        ]
    },
    { path: "/profile", component: Profile },
    {
        path: "/manage",
        component: Manage,
        children: [
            { path: "", component: Dashboard }
        ]
    }
]

const router = createRouter({
    history: createWebHistory(),
    linkExactActiveClass: "active",
    routes,
})


// i18n code
let messages = { "en-US": enLocales }
const i18n = createI18n({
    locale: 'en-US',
    fallbackLocale: 'en-US',
    messages
})

const desiredLocale = navigator.languages[0]
if (!i18n.global.availableLocales.includes(desiredLocale)) {
    loadLocaleMessage(i18n, desiredLocale)
}
setI18nLangauge(i18n, desiredLocale)

const app = createApp(App)
app.use(router)
app.use(i18n)
app.mount("#app")
