// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Welcome to TravelMate`
  String get welcomeToTravelMate {
    return Intl.message(
      'Welcome to TravelMate',
      name: 'welcomeToTravelMate',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get email {
    return Intl.message(
      'Email',
      name: 'email',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message(
      'Password',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get login {
    return Intl.message(
      'Login',
      name: 'login',
      desc: '',
      args: [],
    );
  }

  /// `Sign Up`
  String get signUp {
    return Intl.message(
      'Sign Up',
      name: 'signUp',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your email and password.`
  String get fillEmailPassword {
    return Intl.message(
      'Please enter your email and password.',
      name: 'fillEmailPassword',
      desc: '',
      args: [],
    );
  }

  /// `Invalid email format.`
  String get invalidEmail {
    return Intl.message(
      'Invalid email format.',
      name: 'invalidEmail',
      desc: '',
      args: [],
    );
  }

  /// `Login successful.`
  String get loginSuccess {
    return Intl.message(
      'Login successful.',
      name: 'loginSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Login failed. Please check your credentials.`
  String get loginFailed {
    return Intl.message(
      'Login failed. Please check your credentials.',
      name: 'loginFailed',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get settings {
    return Intl.message(
      'Settings',
      name: 'settings',
      desc: '',
      args: [],
    );
  }

  /// `Personal Information`
  String get personalInformation {
    return Intl.message(
      'Personal Information',
      name: 'personalInformation',
      desc: '',
      args: [],
    );
  }

  /// `Change Password`
  String get changePassword {
    return Intl.message(
      'Change Password',
      name: 'changePassword',
      desc: '',
      args: [],
    );
  }

  /// `First Name`
  String get firstName {
    return Intl.message(
      'First Name',
      name: 'firstName',
      desc: '',
      args: [],
    );
  }

  /// `Last Name`
  String get lastName {
    return Intl.message(
      'Last Name',
      name: 'lastName',
      desc: '',
      args: [],
    );
  }

  /// `Current Password`
  String get currentPassword {
    return Intl.message(
      'Current Password',
      name: 'currentPassword',
      desc: '',
      args: [],
    );
  }

  /// `New Password`
  String get newPassword {
    return Intl.message(
      'New Password',
      name: 'newPassword',
      desc: '',
      args: [],
    );
  }

  /// `Repeat New Password`
  String get repeatNewPassword {
    return Intl.message(
      'Repeat New Password',
      name: 'repeatNewPassword',
      desc: '',
      args: [],
    );
  }

  /// `Save Personal Information`
  String get savePersonalInfo {
    return Intl.message(
      'Save Personal Information',
      name: 'savePersonalInfo',
      desc: '',
      args: [],
    );
  }

  /// `Update Password`
  String get savePassword {
    return Intl.message(
      'Update Password',
      name: 'savePassword',
      desc: '',
      args: [],
    );
  }

  /// `Logout`
  String get logout {
    return Intl.message(
      'Logout',
      name: 'logout',
      desc: '',
      args: [],
    );
  }

  /// `Passwords do not match!`
  String get passwordsDoNotMatch {
    return Intl.message(
      'Passwords do not match!',
      name: 'passwordsDoNotMatch',
      desc: '',
      args: [],
    );
  }

  /// `Personal information updated!`
  String get personalInfoUpdated {
    return Intl.message(
      'Personal information updated!',
      name: 'personalInfoUpdated',
      desc: '',
      args: [],
    );
  }

  /// `Password updated successfully!`
  String get passwordUpdated {
    return Intl.message(
      'Password updated successfully!',
      name: 'passwordUpdated',
      desc: '',
      args: [],
    );
  }

  /// `Personal Info`
  String get personalInfo {
    return Intl.message(
      'Personal Info',
      name: 'personalInfo',
      desc: '',
      args: [],
    );
  }

  /// `Update Password`
  String get updatePassword {
    return Intl.message(
      'Update Password',
      name: 'updatePassword',
      desc: '',
      args: [],
    );
  }

  /// `Logged in as`
  String get loggedInAs {
    return Intl.message(
      'Logged in as',
      name: 'loggedInAs',
      desc: '',
      args: [],
    );
  }

  /// `The note is empty. Please write something.`
  String get noteEmptyMessage {
    return Intl.message(
      'The note is empty. Please write something.',
      name: 'noteEmptyMessage',
      desc: '',
      args: [],
    );
  }

  /// `Note saved successfully!`
  String get noteSavedMessage {
    return Intl.message(
      'Note saved successfully!',
      name: 'noteSavedMessage',
      desc: '',
      args: [],
    );
  }

  /// `Error: Note ID is null`
  String get noteErrorMessage {
    return Intl.message(
      'Error: Note ID is null',
      name: 'noteErrorMessage',
      desc: '',
      args: [],
    );
  }

  /// `Note deleted!`
  String get noteDeletedMessage {
    return Intl.message(
      'Note deleted!',
      name: 'noteDeletedMessage',
      desc: '',
      args: [],
    );
  }

  /// `Error deleting note from Firestore`
  String get errorDeletingNoteMessage {
    return Intl.message(
      'Error deleting note from Firestore',
      name: 'errorDeletingNoteMessage',
      desc: '',
      args: [],
    );
  }

  /// `Save Note`
  String get saveNote {
    return Intl.message(
      'Save Note',
      name: 'saveNote',
      desc: '',
      args: [],
    );
  }

  /// `View Saved Notes`
  String get viewSavedNotes {
    return Intl.message(
      'View Saved Notes',
      name: 'viewSavedNotes',
      desc: '',
      args: [],
    );
  }

  /// `Notes are being stored in: `
  String get notesStoredMessage {
    return Intl.message(
      'Notes are being stored in: ',
      name: 'notesStoredMessage',
      desc: '',
      args: [],
    );
  }

  /// `Fetching city...`
  String get fetchingCityMessage {
    return Intl.message(
      'Fetching city...',
      name: 'fetchingCityMessage',
      desc: '',
      args: [],
    );
  }

  /// `Saved Notes`
  String get savedNotesTitle {
    return Intl.message(
      'Saved Notes',
      name: 'savedNotesTitle',
      desc: '',
      args: [],
    );
  }

  /// `No saved notes`
  String get noSavedNotesMessage {
    return Intl.message(
      'No saved notes',
      name: 'noSavedNotesMessage',
      desc: '',
      args: [],
    );
  }

  /// `Open Gallery`
  String get openGallery {
    return Intl.message(
      'Open Gallery',
      name: 'openGallery',
      desc: '',
      args: [],
    );
  }

  /// `Capture`
  String get capture {
    return Intl.message(
      'Capture',
      name: 'capture',
      desc: '',
      args: [],
    );
  }

  /// `Picture saved to gallery!`
  String get pictureSavedToGallery {
    return Intl.message(
      'Picture saved to gallery!',
      name: 'pictureSavedToGallery',
      desc: '',
      args: [],
    );
  }

  /// `Failed to save picture.`
  String get failedToSavePicture {
    return Intl.message(
      'Failed to save picture.',
      name: 'failedToSavePicture',
      desc: '',
      args: [],
    );
  }

  /// `Map`
  String get map {
    return Intl.message(
      'Map',
      name: 'map',
      desc: '',
      args: [],
    );
  }

  /// `Camera`
  String get camera {
    return Intl.message(
      'Camera',
      name: 'camera',
      desc: '',
      args: [],
    );
  }

  /// `Notes`
  String get notes {
    return Intl.message(
      'Notes',
      name: 'notes',
      desc: '',
      args: [],
    );
  }

  /// `Payment Page`
  String get paymentPageTitle {
    return Intl.message(
      'Payment Page',
      name: 'paymentPageTitle',
      desc: '',
      args: [],
    );
  }

  /// `Fill out the fields below to complete your payment`
  String get fillOutFieldsToCompletePayment {
    return Intl.message(
      'Fill out the fields below to complete your payment',
      name: 'fillOutFieldsToCompletePayment',
      desc: '',
      args: [],
    );
  }

  /// `Card Number`
  String get cardNumber {
    return Intl.message(
      'Card Number',
      name: 'cardNumber',
      desc: '',
      args: [],
    );
  }

  /// `Expiry Date (MM/YY)`
  String get expiryDate {
    return Intl.message(
      'Expiry Date (MM/YY)',
      name: 'expiryDate',
      desc: '',
      args: [],
    );
  }

  /// `CVV`
  String get cvv {
    return Intl.message(
      'CVV',
      name: 'cvv',
      desc: '',
      args: [],
    );
  }

  /// `Payment successful! Returning to Notes.`
  String get paymentSuccessfulMessage {
    return Intl.message(
      'Payment successful! Returning to Notes.',
      name: 'paymentSuccessfulMessage',
      desc: '',
      args: [],
    );
  }

  /// `Upgrade Required`
  String get upgradeRequiredTitle {
    return Intl.message(
      'Upgrade Required',
      name: 'upgradeRequiredTitle',
      desc: '',
      args: [],
    );
  }

  /// `You have reached the free limit of 5 notes. To save more, please upgrade.`
  String get upgradeRequiredMessage {
    return Intl.message(
      'You have reached the free limit of 5 notes. To save more, please upgrade.',
      name: 'upgradeRequiredMessage',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Deletion`
  String get confirmDeletionTitle {
    return Intl.message(
      'Confirm Deletion',
      name: 'confirmDeletionTitle',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to delete this note?`
  String get confirmDeletionMessage {
    return Intl.message(
      'Are you sure you want to delete this note?',
      name: 'confirmDeletionMessage',
      desc: '',
      args: [],
    );
  }

  /// `No`
  String get no {
    return Intl.message(
      'No',
      name: 'no',
      desc: '',
      args: [],
    );
  }

  /// `Yes`
  String get yes {
    return Intl.message(
      'Yes',
      name: 'yes',
      desc: '',
      args: [],
    );
  }

  /// `Action completed!`
  String get toastMessage {
    return Intl.message(
      'Action completed!',
      name: 'toastMessage',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Logout`
  String get confirmLogout {
    return Intl.message(
      'Confirm Logout',
      name: 'confirmLogout',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to logout?`
  String get areYouSureYouWantToLogout {
    return Intl.message(
      'Are you sure you want to logout?',
      name: 'areYouSureYouWantToLogout',
      desc: '',
      args: [],
    );
  }

  /// `Sign Up`
  String get appTitle {
    return Intl.message(
      'Sign Up',
      name: 'appTitle',
      desc: '',
      args: [],
    );
  }

  /// `First Name`
  String get firstNameLabel {
    return Intl.message(
      'First Name',
      name: 'firstNameLabel',
      desc: '',
      args: [],
    );
  }

  /// `Last Name`
  String get lastNameLabel {
    return Intl.message(
      'Last Name',
      name: 'lastNameLabel',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get emailLabel {
    return Intl.message(
      'Email',
      name: 'emailLabel',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get passwordLabel {
    return Intl.message(
      'Password',
      name: 'passwordLabel',
      desc: '',
      args: [],
    );
  }

  /// `Sign Up`
  String get signUpButton {
    return Intl.message(
      'Sign Up',
      name: 'signUpButton',
      desc: '',
      args: [],
    );
  }

  /// `First name should only contain letters and cannot be empty.`
  String get firstNameError {
    return Intl.message(
      'First name should only contain letters and cannot be empty.',
      name: 'firstNameError',
      desc: '',
      args: [],
    );
  }

  /// `Last name should only contain letters and cannot be empty.`
  String get lastNameError {
    return Intl.message(
      'Last name should only contain letters and cannot be empty.',
      name: 'lastNameError',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a valid email address.`
  String get emailError {
    return Intl.message(
      'Please enter a valid email address.',
      name: 'emailError',
      desc: '',
      args: [],
    );
  }

  /// `Password must be at least 6 characters long and contain both letters and numbers.`
  String get passwordError {
    return Intl.message(
      'Password must be at least 6 characters long and contain both letters and numbers.',
      name: 'passwordError',
      desc: '',
      args: [],
    );
  }

  /// `Sign up successful! Please log in.`
  String get signUpSuccess {
    return Intl.message(
      'Sign up successful! Please log in.',
      name: 'signUpSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Sign up failed. Please try again.`
  String get signUpFailure {
    return Intl.message(
      'Sign up failed. Please try again.',
      name: 'signUpFailure',
      desc: '',
      args: [],
    );
  }

  /// `Error during sign up: {error}`
  String signUpError(Object error) {
    return Intl.message(
      'Error during sign up: $error',
      name: 'signUpError',
      desc: '',
      args: [error],
    );
  }

  /// `Login failed: {error}`
  String loginError(Object error) {
    return Intl.message(
      'Login failed: $error',
      name: 'loginError',
      desc: '',
      args: [error],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `No places found`
  String get noPlacesFound {
    return Intl.message(
      'No places found',
      name: 'noPlacesFound',
      desc: '',
      args: [],
    );
  }

  /// `Pay`
  String get pay {
    return Intl.message(
      'Pay',
      name: 'pay',
      desc: '',
      args: [],
    );
  }

  /// `Search places ...`
  String get searchPlaceholder {
    return Intl.message(
      'Search places ...',
      name: 'searchPlaceholder',
      desc: '',
      args: [],
    );
  }

  /// `Please fill in all fields!`
  String get fillAllFields {
    return Intl.message(
      'Please fill in all fields!',
      name: 'fillAllFields',
      desc: '',
      args: [],
    );
  }

  /// `The current password is incorrect.`
  String get wrongCurrentPassword {
    return Intl.message(
      'The current password is incorrect.',
      name: 'wrongCurrentPassword',
      desc: '',
      args: [],
    );
  }

  /// `Error: {error}`
  String error(Object error) {
    return Intl.message(
      'Error: $error',
      name: 'error',
      desc: '',
      args: [error],
    );
  }

  /// `Changing your email requires entering your current password.`
  String get emailChangeRequiresPassword {
    return Intl.message(
      'Changing your email requires entering your current password.',
      name: 'emailChangeRequiresPassword',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'de'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
