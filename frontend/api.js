class API {
    constructor(jwtToken) {
        this.jwtToken = jwtToken
    }

    isAuthenticated() {
        return !!this.jwtToken  // checks "truthiness" of jwtToken - return true only if not null/undefined/empty
    }
}

export default API
