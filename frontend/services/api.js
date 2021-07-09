class API {
    getQuestionnaire(id) {
        // TODO: implement fetch() call
        // using sample data from https://www.notion.so/peterkos/Questionnaire-apply-json-465059f1d24f4236ac92cb3777aae2ce

        return {
            "id": 1,
            "date_of_birth": "2000-01-01",
            "experience": "expert",
            "school_id": "2304",
            "created_at": "2021-02-06T19:27:03.000-05:00",
            "updated_at": "2021-02-06T19:27:03.000-05:00",
            "shirt_size": "Unisex - XS",
            "dietary_restrictions": null,
            "international": null,
            "portfolio_url": null,
            "vcs_url": null,
            "user_id": 1,
            "acc_status": "pending",
            "acc_status_author_id": null,
            "acc_status_date": null,
            "bus_captain_interest": false,
            "is_bus_captain": false,
            "checked_in_by_id": null,
            "checked_in_at": null,
            "phone": "12036663928",
            "can_share_info": false,
            "special_needs": null,
            "gender": "Male",
            "major": "Computer Science",
            "travel_not_from_school": false,
            "travel_location": null,
            "level_of_study": "University (Undergraduate)",
            "interest": "hardware",
            "why_attend": null,
            "boarded_bus_at": null,
            "graduation_year": 2021,
            "race_ethnicity": "White / Caucasian",
            "bus_list_id": null,
            "country": "United States",
            "all_agreements_accepted": true
        }
    }

    getUser(id) {
        // TODO: implement fetch() call
        // using sample data for now

        return {
            "id": 1,
            "created_at": "2021-01-06T19:41:14.000-05:00",
            "updated_at": "2021-07-09T12:51:48.000-04:00",
            "email": "johnsmith@example.com",
            "provider": null,
            "uid": null,
            "reminder_sent_at": "2021-01-06T19:41:15.000-05:00",
            "role": "user",
            "is_active": true,
            "receive_weekly_report": false,
            "first_name": "John",
            "last_name": "Smith",
            "questionnaire_id": 1
        }
    }
}

export default API;
