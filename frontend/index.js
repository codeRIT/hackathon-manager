import { createApp } from "vue";
import { createRouter, createWebHashHistory } from "vue-router"

import App from "./App"


import Home from "./routes/Home.vue"
import About from "./routes/About.vue"
import Profile from "./routes/Profile.vue"
import Dashboard from "./routes/manage/Dashboard.vue"
import ComponentTest from "./routes/ComponentTest.vue"

const routes = [
    { path: "/", component: Home },
    { path: "/about", component: About },
    { path: "/profile", component: Profile },
    { path: "/manage", component: Dashboard },
    { path: "/component-test", component: ComponentTest }
]

const router = createRouter({
    history: createWebHashHistory(),
    routes,
})


const app = createApp(App)
app.use(router)
app.mount("#app")