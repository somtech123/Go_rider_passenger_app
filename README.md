
# Go_Rider Passenger App

Go_rider is a cap booking app that allow users to easily book a ride with just a few clicks on their smartphone. it connects passengers with nearby taxi drivers, offering a reliable and efficient transportation solution.

The app typically provides a range of features such as real-time tracking of the ride, estimated arrival time, fare calculation, multtple payment option and rating system to ensure the quality of services
## Application Feature

- Available in English
- Authentication(Login, Singup & Reset Password) with Firebase
- Live Location Tracking
- Geo-Coding (Nigeria mainly)
- Real Time Ride Tracking
- Estimated Rider Arrival Time
- Fetching available ride close to user location
- Booking/Ride cancellation
- Ride Rating System
- in-App messaging
- View Ride History 
- Upload profile photo & update Profile
- Responsive layout
- Push Notification
- Performance frienly
## Todo

- Rider App
- user privacy
- Bill payment 
- Referral and incentives
- SOS
## Installation

Android apk file for testing:
[Android Apk](https://drive.google.com/file/d/1B_HPh_uFyTZuw-qh1pgAOFL7cVH028Ac/view?usp=sharing)
## Run Locally


Clone these repository

```bash
  
  git clone https://github.com/somtech123/Go_rider
  fork the repository
```

Go to the project directory

```bash
  cd Go_rider
```

Install dependencies

```bash
  flutter pub get
  set-up firebase for android and ios 
  get google api key and push notification key
  follow the step on the Environment Variables  below to set up .env file 
```

Run the project 

```bash
  flutter run 
  or build an apk with flutter build apk --split-per-abi
```

## Environment Variables

To run this project, you will need to add the following environment variables to your .env file

`GOOGLE_MAP_API_KEY` for Google services

`PUSH_NOTIFICATION_BEARER` for push notification


then loads environment variables from the env file using 
`dotenv.load(fileName: ".env")` on the `main.dart` file 

then load a copy of variables loaded at runtime from .env with 
`dotenv.env['GOOGLE_MAP_API_KEY']`
## Tech stack

Client
```bash
  Flutter and Dart 
```

Server
```bash
  Firebase 
  Bloc
```
## Screenshots

![Untitled design (5)](https://github.com/somtech123/Go_rider/assets/100732124/76bd987f-7c09-48cb-9ec2-6789ddb94be9)
![Untitled design (6)](https://github.com/somtech123/Go_rider/assets/100732124/a1ee27a3-d346-4087-ae27-1ef4465c0641)
![Untitled design (7)](https://github.com/somtech123/Go_rider/assets/100732124/d6313ea6-4e08-4ae3-86f9-51de3731c481)
![Untitled design (8)](https://github.com/somtech123/Go_rider/assets/100732124/4138b2b5-379f-49a4-9ac1-d2179f2853af)
![Untitled design (9)](https://github.com/somtech123/Go_rider/assets/100732124/82461b1c-c401-4d00-b104-4fb6c975ade0)
![Untitled design (10)](https://github.com/somtech123/Go_rider/assets/100732124/f388b175-e3db-44c3-9f06-4bddaea386bf)
## Usage/Examples

![Android Emulator - Pixel_4_API_31_5554 2024-02-29 10-17-02](https://github.com/somtech123/Go_rider/assets/100732124/f80618d3-13a0-4ed2-8f07-9a6933688cee)


## Support

For support, email somtechnolog@gmail.com 
send a dm  ![x](https://img.shields.io/twitter/follow/somtech2001).

