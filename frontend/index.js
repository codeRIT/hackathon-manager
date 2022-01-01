import { createApp } from "vue";
import { createRouter, createWebHistory } from "vue-router"
import { createI18n } from "vue-i18n"

import { library } from "@fortawesome/fontawesome-svg-core"
import { faChevronUp, faChevronDown, faEdit } from "@fortawesome/free-solid-svg-icons"

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

import {Auth0} from "./auth";

// TODO: pull from server when in production
import enLocales from "./assets/locales/en-US.json"
import { loadLocaleMessage, setI18nLangauge } from "./i18n"

async function init() {

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
            beforeEnter: Auth0.routeGuard,
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


    // Auth
    const AuthPlugin = await Auth0.init({
        onRedirectCallback: (appState) => {
            router.push(appState && appState.targetURL ? appState.targetURL : window.location.pathname)
        },
        clientId: "mO6AyghLFWgjRz2u1e7jleLShbdVWBrY",
        domain: "peterkos.auth0.com",
        // audience: "asdf",
        redirectUri: window.location.origin, // FIXME: idk lol
    });


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


    // needed for vue-fontawesome
    library.add(faChevronUp, faChevronDown, faEdit)


    const app = createApp(App)
    app.use(AuthPlugin)
    app.use(router)
    app.use(i18n)
    app.mount("#app")
}

init();
