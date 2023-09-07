---
title: Meet Chavan - Unicode DJSCE - App Task
created at: Thu Sep 07 2023 07:37:50 GMT+0000 (Coordinated Universal Time)
updated at: Thu Sep 07 2023 07:51:55 GMT+0000 (Coordinated Universal Time)
---

# Meet Chavan - Unicode DJSCE - App Task

This app was developed as a part of Task for Unciode'23 Club - Dwarkadas J. Sanghvi College of Engineering

The app constitutes of 4 modules/screens.

![unicode.png](media_Meet%20Chavan%20-%20Unicode%20DJSCE%20-%20App%20Task/unicode.png)

-   Splash Screen

    The Splash Screen module which contains logo of Unicode checks for the status of existence of stored persistent data in shared preference and redirects the user to either Registration or Home based on this status.

-   Registration

    The registration module contains Name, Phone No., Email and D.O.B field having a date picker calendar. It has two buttons 'Clear' clears every input field and 'Proceed' which on clicking saves the entered data into shared preferences for persistency and redirects the user to Home Screen.

-   Home Screen

    -   The Home module displays the current user based on the stored persistent data.
    -   The Home module requests permission of Location for fetching the weather based on current location using the OpenWeatherMap API.
    -   The Home module fetches the weather from API and displays weather information like temperature, description, humidity, wind pressure, etc.
    -   The Home module requests permission of Contacts for displaying the contacts list
    -   The contact list contains the name of the contact, its profile icon generated from the name initials and which on clicking opens a bottom sheet displaying detailed contact information.

-   Contact Details

    The contact details page/bottom sheet displays the name, profile icon, phone number and email id of the contact. It also has 3 buttons for placing call, sending sms, and sending mail which are handled by the url intents 'tel:', 'sms:' and 'mailto&#x3A;' respectively. If the contact does not have any email or phone the respective fields are not displayed thus preventing any exceptions.

          
