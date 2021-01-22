---
id: users-and-staff
title: Users & Staff
---

**Accessible by:** Directors 

The Users & Staff page is an easy way to manage the users of your hackathon's HackathonManager instance. In addition to attendees, you can also manage volunteers, organizers and directors. 

## User Management
Certain attributes within a user can be modified. 

**Email:** The email for the user, used for signing into HackathonManager.  
**Role:** Role for the user, see [Roles](#roles).  
**Login access:** Allow/Block login for that specific user. Will also disable the weekly report email if that user is an admin.   
**Receive weekly report:** A weekly email report on admissions, bus lists, and messages. Only sent when there are weekly updates up until 7 days past the event.


## Roles
Roles allow for organization and permission access for users. There are four roles within HackathonManager: **User**, **Volunteer**, **Organizer** and **Director** with Director being the highest.

### Permissions
The following are permissions for all admin roles. An admin role is any role other than User that has access to the admin dashboard. User can only create, view, edit and delete their own questionnaire.

|                            |  Volunteer  | Organizer | Director |
|---|:-:|:-:|:-:|
| `View Questionnaires`             |      ✔️      |     ✔️     |     ✔️    |
| `Create Questionnaires`           |             |           |     ✔️    |
| `Update Questionnaires`           |             |           |     ✔️    |
| `Destroy Questionnaires`          |             |           |     ✔️    |
| `Check in Hackers`                |      ✔️      |     ✔️     |     ✔️    |
| `View Messages`                   |             |     ✔️     |     ✔️    |
| `Modify Message Triggers`         |             |           |     ✔️    |
| `Send Messages`                   |             |           |     ✔️    |
| `Create Messages`                 |             |           |     ✔️    |
| `Update Messages`                 |             |           |     ✔️    |
| `Destroy Messages`                |             |           |     ✔️    |
| `View Statistics`                 |             |     ✔️     |     ✔️    |
| `View Trackable Tags`             |             |     ✔️     |     ✔️    |
| `(API) View Trackable Tags`       |      ✔️      |     ✔️     |     ✔️    |
| `Create Trackable Tags`           |             |           |     ✔️    |
| `Update Trackable Tags`           |             |           |     ✔️    |
| `Destroy Trackable Tags`          |             |           |     ✔️    |
| `View [own] Trackable Events`     |      ✔️      |     ✔️     |     ✔️    |
| `View [other] Trackable Events`   |             |     ✔️     |     ✔️    |
| `Create Trackable Events`         |      ✔️      |     ✔️     |     ✔️    |
| `Destroy [own] Trackable Events`  |      ✔️      |     ✔️     |     ✔️    |
| `Destroy [other] Trackable Events`|             |           |     ✔️    |
| `View Schools`                    |      ✔️      |     ✔️     |     ✔️    |
| `Create Schools`                  |             |           |     ✔️    |
| `Update Schools`                  |             |           |     ✔️    |
| `Merge Schools`                   |             |           |     ✔️    |
| `Message Schools`                 |             |           |     ✔️    |
| `View Users & Staff`              |             |           |     ✔️    |
| `Update Users & Staff`            |             |           |     ✔️    |
| `Destroy Users & Staff`           |             |           |     ✔️    |
| `Modify Account Role`             |             |           |     ✔️    |
| `View Legal Agreements`           |             |           |     ✔️    |
| `Update Legal Agreements`         |             |           |     ✔️    |
| `Destroy Legal Agreements`        |             |           |     ✔️    |
| `View Hackathon Settings`         |             |           |     ✔️    |
| `Update Hackathon Settings`       |             |           |     ✔️    |
| `View App Authentication`         |             |           |     ✔️    |
| `Create OAuth2 Applications`      |             |           |     ✔️    |
| `Update OAuth2 Applications`      |             |           |     ✔️    |
| `Destroy OAuth2 Applications`     |             |           |     ✔️    |
| `View Sidekiq`                    |             |           |     ✔️    |
| `View Blazer`                     |             |           |     ✔️    |
| `View Data Exports`               |             |           |     ✔️    |
| `Export Hackathon Data`           |             |           |     ✔️    |
_Own:_ Objects/events that were created by that user.    
_Other:_ Objects/events that were created by any user.