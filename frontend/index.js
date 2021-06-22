
import { createApp } from "vue";
import { createRouter, createWebHistory } from "vue-router"

import App from "./App"


import Home from "./routes/Home.vue"
import About from "./routes/About.vue"
import Profile from "./routes/Profile.vue"
import Application from "./routes/Application.vue"

const routes = [
    { path: "/", component: Home },
    { path: "/about", component: About },
    { path: "/application", component: Application},
    { path: "/profile", component: Profile }
]

const router = createRouter({
    history: createWebHistory(),
    routes,
})


const app = createApp(App)
app.use(router)
app.mount("#app")