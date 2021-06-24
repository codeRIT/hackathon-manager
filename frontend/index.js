
import { createApp } from "vue";
import { createRouter, createWebHashHistory } from "vue-router"

import App from "./App"


import Home from "./routes/Home.vue"
import About from "./routes/About.vue"

const routes = [
    { path: "/", component: Home },
    { path: "/about", component: About },
]

const router = createRouter({
    history: createWebHashHistory(),
    routes,
})


const app = createApp(App)
app.use(router)
app.mount("#app")