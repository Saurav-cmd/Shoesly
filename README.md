# shoesly

An small ecommerce type app for shoes

## Getting Started

## Project Setup
- Install flutter
- Add required dependencies
- Then do flutter pub get 
- Setup firebase and add google-services.json and GoogleService-Info.plist file
- Then initialize firebase in main.dart

## Assumptions
- Users have a stable internet connection for API calls and Firebase operations.
- The application will primarily be used on mobile devices with modern specifications.
- Made own assumption for firebase database so that user can have an feel for the app.

## Challenges and Overcome
- To maintain firebase database like to maintain the data because of its non-sql behaviour was very hard to reference different tables like sql database
- To overcome this went through official documentation and found out about the sub-collection but still was very hard to maintain the data because need to call separately from the main collection.
- But at last overcome this problem by fetching data and storing the data in our own centralized model named CombinedModel.
- I wont say it as an improvement but added different type of toast message for success and identifiers on which filter user have choose and focused mainly in functionality and tried to obtain all the functionality as smoothly as possible.


A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
