import { createApp } from "vue";
import { createRouter, createWebHistory } from "vue-router"
import { createI18n } from "vue-i18n"

import App from "./App"

import Home from "./routes/Home.vue"
import About from "./routes/About.vue"
import Profile from "./routes/Profile.vue"
// import Application from "./routes/Application.vue"
import Dashboard from "./routes/manage/Dashboard.vue"

// TODO: pull from server when in production
import enLocales from "./assets/locales/en.json"

const routes = [
    { path: "/", component: Home },
    { path: "/about", component: About },
    // { path: "/application", component: Application},
    { path: "/profile", component: Profile },
    { path: "/manage", component: Dashboard }
]

const router = createRouter({
    history: createWebHistory(),
    routes,
})


// i18n code
let messages = { en: enLocales }
const i18n = createI18n({
    locale: navigator.languages[0],
    fallbackLocale: 'en',
    messages
})

const app = createApp(App)
app.use(router)
app.use(i18n)
app.mount("#app")
