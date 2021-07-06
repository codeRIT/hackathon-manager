import { createApp } from "vue";
import { createRouter, createWebHistory } from "vue-router"

import App from "./App"


import Home from "./routes/Home.vue"
import About from "./routes/About.vue"
import Profile from "./routes/Profile.vue"

import Manage from "./routes/Manage.vue"
import Dashboard from './routes/manage/Dashboard.vue'
import Users from './routes/manage/Users.vue'
import Schools from './routes/manage/Schools.vue'
import Questionnaires from './routes/manage/Questionnaires.vue'
import Schedule from './routes/manage/Schedule.vue'
import Settings from './routes/manage/Settings.vue'

const routes = [
    { path: "/", component: Home },
    { path: "/about", component: About },
    { path: "/profile", component: Profile },
    {
        path: "/manage",
        component: Manage,
        children: [
            {
                path: '',
                component: Dashboard
            },
            {
                path: 'users',
                component: Users
            },
            {
                path: 'schools',
                component: Schools
            },
            {
                path: 'questionnaires',
                component: Questionnaires
            },
            {
                path: 'schedule',
                component: Schedule
            },
            {
                path: 'settings',
                component: Settings
            }
        ]
    }
]

const router = createRouter({
    history: createWebHistory(),
    routes,
})


const app = createApp(App)
app.use(router)
app.mount("#app")