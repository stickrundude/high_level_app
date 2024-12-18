// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  static String m0(error) => "Error: ${error}";

  static String m1(error) => "Login failed: ${error}";

  static String m2(error) => "Error during sign up: ${error}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "appTitle": MessageLookupByLibrary.simpleMessage("Sign Up"),
        "areYouSureYouWantToLogout": MessageLookupByLibrary.simpleMessage(
            "Are you sure you want to logout?"),
        "camera": MessageLookupByLibrary.simpleMessage("Camera"),
        "cancel": MessageLookupByLibrary.simpleMessage("Cancel"),
        "capture": MessageLookupByLibrary.simpleMessage("Capture"),
        "cardNumber": MessageLookupByLibrary.simpleMessage("Card Number"),
        "changePassword":
            MessageLookupByLibrary.simpleMessage("Change Password"),
        "confirmDeletionMessage": MessageLookupByLibrary.simpleMessage(
            "Are you sure you want to delete this note?"),
        "confirmDeletionTitle":
            MessageLookupByLibrary.simpleMessage("Confirm Deletion"),
        "confirmLogout": MessageLookupByLibrary.simpleMessage("Confirm Logout"),
        "currentPassword":
            MessageLookupByLibrary.simpleMessage("Current Password"),
        "cvv": MessageLookupByLibrary.simpleMessage("CVV"),
        "email": MessageLookupByLibrary.simpleMessage("Email"),
        "emailChangeRequiresPassword": MessageLookupByLibrary.simpleMessage(
            "Changing your email requires entering your current password."),
        "emailError": MessageLookupByLibrary.simpleMessage(
            "Please enter a valid email address."),
        "emailLabel": MessageLookupByLibrary.simpleMessage("Email"),
        "error": m0,
        "errorDeletingNoteMessage": MessageLookupByLibrary.simpleMessage(
            "Error deleting note from Firestore"),
        "expiryDate":
            MessageLookupByLibrary.simpleMessage("Expiry Date (MM/YY)"),
        "failedToSavePicture":
            MessageLookupByLibrary.simpleMessage("Failed to save picture."),
        "fetchingCityMessage":
            MessageLookupByLibrary.simpleMessage("Fetching city..."),
        "fillAllFields":
            MessageLookupByLibrary.simpleMessage("Please fill in all fields!"),
        "fillEmailPassword": MessageLookupByLibrary.simpleMessage(
            "Please enter your email and password."),
        "fillOutFieldsToCompletePayment": MessageLookupByLibrary.simpleMessage(
            "Fill out the fields below to complete your payment"),
        "firstName": MessageLookupByLibrary.simpleMessage("First Name"),
        "firstNameError": MessageLookupByLibrary.simpleMessage(
            "First name should only contain letters and cannot be empty."),
        "firstNameLabel": MessageLookupByLibrary.simpleMessage("First Name"),
        "invalidEmail":
            MessageLookupByLibrary.simpleMessage("Invalid email format."),
        "lastName": MessageLookupByLibrary.simpleMessage("Last Name"),
        "lastNameError": MessageLookupByLibrary.simpleMessage(
            "Last name should only contain letters and cannot be empty."),
        "lastNameLabel": MessageLookupByLibrary.simpleMessage("Last Name"),
        "loggedInAs": MessageLookupByLibrary.simpleMessage("Logged in as"),
        "login": MessageLookupByLibrary.simpleMessage("Login"),
        "loginError": m1,
        "loginFailed": MessageLookupByLibrary.simpleMessage(
            "Login failed. Please check your credentials."),
        "loginSuccess":
            MessageLookupByLibrary.simpleMessage("Login successful."),
        "logout": MessageLookupByLibrary.simpleMessage("Logout"),
        "map": MessageLookupByLibrary.simpleMessage("Map"),
        "newPassword": MessageLookupByLibrary.simpleMessage("New Password"),
        "no": MessageLookupByLibrary.simpleMessage("No"),
        "noPlacesFound":
            MessageLookupByLibrary.simpleMessage("No places found"),
        "noSavedNotesMessage":
            MessageLookupByLibrary.simpleMessage("No saved notes"),
        "noteDeletedMessage":
            MessageLookupByLibrary.simpleMessage("Note deleted!"),
        "noteEmptyMessage": MessageLookupByLibrary.simpleMessage(
            "The note is empty. Please write something."),
        "noteErrorMessage":
            MessageLookupByLibrary.simpleMessage("Error: Note ID is null"),
        "noteSavedMessage":
            MessageLookupByLibrary.simpleMessage("Note saved successfully!"),
        "notes": MessageLookupByLibrary.simpleMessage("Notes"),
        "notesStoredMessage":
            MessageLookupByLibrary.simpleMessage("Notes are being stored in: "),
        "openGallery": MessageLookupByLibrary.simpleMessage("Open Gallery"),
        "password": MessageLookupByLibrary.simpleMessage("Password"),
        "passwordError": MessageLookupByLibrary.simpleMessage(
            "Password must be at least 6 characters long and contain both letters and numbers."),
        "passwordLabel": MessageLookupByLibrary.simpleMessage("Password"),
        "passwordUpdated": MessageLookupByLibrary.simpleMessage(
            "Password updated successfully!"),
        "passwordsDoNotMatch":
            MessageLookupByLibrary.simpleMessage("Passwords do not match!"),
        "pay": MessageLookupByLibrary.simpleMessage("Pay"),
        "paymentPageTitle":
            MessageLookupByLibrary.simpleMessage("Payment Page"),
        "paymentSuccessfulMessage": MessageLookupByLibrary.simpleMessage(
            "Payment successful! Returning to Notes."),
        "personalInfo": MessageLookupByLibrary.simpleMessage("Personal Info"),
        "personalInfoUpdated": MessageLookupByLibrary.simpleMessage(
            "Personal information updated!"),
        "personalInformation":
            MessageLookupByLibrary.simpleMessage("Personal Information"),
        "pictureSavedToGallery":
            MessageLookupByLibrary.simpleMessage("Picture saved to gallery!"),
        "repeatNewPassword":
            MessageLookupByLibrary.simpleMessage("Repeat New Password"),
        "saveNote": MessageLookupByLibrary.simpleMessage("Save Note"),
        "savePassword": MessageLookupByLibrary.simpleMessage("Update Password"),
        "savePersonalInfo":
            MessageLookupByLibrary.simpleMessage("Save Personal Information"),
        "savedNotesTitle": MessageLookupByLibrary.simpleMessage("Saved Notes"),
        "searchPlaceholder":
            MessageLookupByLibrary.simpleMessage("Search places ..."),
        "settings": MessageLookupByLibrary.simpleMessage("Settings"),
        "signUp": MessageLookupByLibrary.simpleMessage("Sign Up"),
        "signUpButton": MessageLookupByLibrary.simpleMessage("Sign Up"),
        "signUpError": m2,
        "signUpFailure": MessageLookupByLibrary.simpleMessage(
            "Sign up failed. Please try again."),
        "signUpSuccess": MessageLookupByLibrary.simpleMessage(
            "Sign up successful! Please log in."),
        "toastMessage":
            MessageLookupByLibrary.simpleMessage("Action completed!"),
        "updatePassword":
            MessageLookupByLibrary.simpleMessage("Update Password"),
        "upgradeRequiredMessage": MessageLookupByLibrary.simpleMessage(
            "You have reached the free limit of 5 notes. To save more, please upgrade."),
        "upgradeRequiredTitle":
            MessageLookupByLibrary.simpleMessage("Upgrade Required"),
        "viewSavedNotes":
            MessageLookupByLibrary.simpleMessage("View Saved Notes"),
        "welcomeToTravelMate":
            MessageLookupByLibrary.simpleMessage("Welcome to TravelMate"),
        "wrongCurrentPassword": MessageLookupByLibrary.simpleMessage(
            "The current password is incorrect."),
        "yes": MessageLookupByLibrary.simpleMessage("Yes")
      };
}
