# COVID Patients Monitor

A Flutter project that helps doctor in monitoring vitals remotely


## How does it work?

The project consists in two parts:
- The Flutter app for the doctors that gets all info from a remote database (in this case, stored in Azure).
- The Arduino sketch for ESP32/ESP8266 Boards that reports the vitals from each patient as each one of them is assigned a unique ID.

