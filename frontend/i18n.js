import { createI18n } from 'vue-i18n'

export function setupI18n(options = { locale: 'en' }) {
    const i18n = createI18n(options)
    setI18nLangauge(i18n, options.locale)
    return i18n
}

export function setI18nLangauge(i18n, locale) {
    i18n.global.locale = locale
    // TODO: set "Accept-Language" header for API calls
    document.querySelector('html').setAttribute('lang', locale)
}

export async function loadLocaleMessage(i18n, locale) {
    const res = await fetch(`/locales/${locale}.json`)
    const messages = await res.json()
    i18n.global.setLocaleMessage(locale, messages)
}
