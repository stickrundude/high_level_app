// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a de locale. All the
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
  String get localeName => 'de';

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "areYouSureYouWantToLogout": MessageLookupByLibrary.simpleMessage(
            "Möchten Sie sich wirklich abmelden?"),
        "camera": MessageLookupByLibrary.simpleMessage("Kamera"),
        "cancel": MessageLookupByLibrary.simpleMessage("Abbrechen"),
        "capture": MessageLookupByLibrary.simpleMessage("Aufnehmen"),
        "cardNumber": MessageLookupByLibrary.simpleMessage("Kartennummer"),
        "changePassword":
            MessageLookupByLibrary.simpleMessage("Passwort ändern"),
        "confirmDeletionMessage": MessageLookupByLibrary.simpleMessage(
            "Möchten Sie diese Notiz wirklich löschen?"),
        "confirmDeletionTitle":
            MessageLookupByLibrary.simpleMessage("Löschbestätigung"),
        "confirmLogout":
            MessageLookupByLibrary.simpleMessage("Abmelden bestätigen"),
        "currentPassword":
            MessageLookupByLibrary.simpleMessage("Aktuelles Passwort"),
        "cvv": MessageLookupByLibrary.simpleMessage("CVV"),
        "email": MessageLookupByLibrary.simpleMessage("E-Mail"),
        "errorDeletingNoteMessage": MessageLookupByLibrary.simpleMessage(
            "Fehler beim Löschen der Notiz aus Firestore"),
        "expiryDate":
            MessageLookupByLibrary.simpleMessage("Ablaufdatum (MM/JJ)"),
        "failedToSavePicture": MessageLookupByLibrary.simpleMessage(
            "Fehler beim Speichern des Bildes."),
        "fetchingCityMessage":
            MessageLookupByLibrary.simpleMessage("Stadt wird abgerufen..."),
        "fillEmailPassword": MessageLookupByLibrary.simpleMessage(
            "Bitte E-Mail und Passwort ausfüllen."),
        "fillOutFieldsToCompletePayment": MessageLookupByLibrary.simpleMessage(
            "Füllen Sie die untenstehenden Felder aus, um Ihre Zahlung abzuschließen"),
        "firstName": MessageLookupByLibrary.simpleMessage("Vorname"),
        "invalidEmail":
            MessageLookupByLibrary.simpleMessage("Ungültiges E-Mail-Format."),
        "lastName": MessageLookupByLibrary.simpleMessage("Nachname"),
        "loggedInAs": MessageLookupByLibrary.simpleMessage("Angemeldet als"),
        "login": MessageLookupByLibrary.simpleMessage("Anmelden"),
        "loginFailed": MessageLookupByLibrary.simpleMessage(
            "Anmeldung fehlgeschlagen. Bitte überprüfen Sie Ihre Zugangsdaten."),
        "loginSuccess":
            MessageLookupByLibrary.simpleMessage("Anmeldung erfolgreich."),
        "logout": MessageLookupByLibrary.simpleMessage("Abmelden"),
        "map": MessageLookupByLibrary.simpleMessage("Karte"),
        "newPassword": MessageLookupByLibrary.simpleMessage("Neues Passwort"),
        "no": MessageLookupByLibrary.simpleMessage("Nein"),
        "noSavedNotesMessage":
            MessageLookupByLibrary.simpleMessage("Keine gespeicherten Notizen"),
        "noteDeletedMessage":
            MessageLookupByLibrary.simpleMessage("Notiz gelöscht!"),
        "noteEmptyMessage": MessageLookupByLibrary.simpleMessage(
            "Die Notiz ist leer. Bitte schreiben Sie etwas."),
        "noteErrorMessage":
            MessageLookupByLibrary.simpleMessage("Fehler: Notiz-ID ist null"),
        "noteSavedMessage": MessageLookupByLibrary.simpleMessage(
            "Notiz erfolgreich gespeichert!"),
        "notes": MessageLookupByLibrary.simpleMessage("Notizen"),
        "notesStoredMessage": MessageLookupByLibrary.simpleMessage(
            "Notizen werden gespeichert in: "),
        "openGallery": MessageLookupByLibrary.simpleMessage("Galerie öffnen"),
        "password": MessageLookupByLibrary.simpleMessage("Passwort"),
        "passwordUpdated": MessageLookupByLibrary.simpleMessage(
            "Passwort erfolgreich aktualisiert!"),
        "passwordsDoNotMatch": MessageLookupByLibrary.simpleMessage(
            "Passwörter stimmen nicht überein!"),
        "pay": MessageLookupByLibrary.simpleMessage("Bezahlen"),
        "paymentPageTitle":
            MessageLookupByLibrary.simpleMessage("Zahlungsseite"),
        "paymentSuccessfulMessage": MessageLookupByLibrary.simpleMessage(
            "Zahlung erfolgreich! Zurück zu den Notizen."),
        "personalInfo":
            MessageLookupByLibrary.simpleMessage("Persönliche Infos"),
        "personalInfoUpdated": MessageLookupByLibrary.simpleMessage(
            "Persönliche Informationen aktualisiert!"),
        "personalInformation":
            MessageLookupByLibrary.simpleMessage("Persönliche Informationen"),
        "pictureSavedToGallery": MessageLookupByLibrary.simpleMessage(
            "Bild in Galerie gespeichert!"),
        "repeatNewPassword":
            MessageLookupByLibrary.simpleMessage("Neues Passwort wiederholen"),
        "saveNote": MessageLookupByLibrary.simpleMessage("Notiz speichern"),
        "savePassword":
            MessageLookupByLibrary.simpleMessage("Passwort aktualisieren"),
        "savePersonalInfo": MessageLookupByLibrary.simpleMessage(
            "Persönliche Informationen speichern"),
        "savedNotesTitle":
            MessageLookupByLibrary.simpleMessage("Gespeicherte Notizen"),
        "settings": MessageLookupByLibrary.simpleMessage("Einstellungen"),
        "signUp": MessageLookupByLibrary.simpleMessage("Registrieren"),
        "toastMessage":
            MessageLookupByLibrary.simpleMessage("Aktion abgeschlossen!"),
        "updatePassword":
            MessageLookupByLibrary.simpleMessage("Passwort aktualisieren"),
        "upgradeRequiredMessage": MessageLookupByLibrary.simpleMessage(
            "Sie haben das kostenlose Limit von 5 Notizen erreicht. Um mehr zu speichern, bitte upgraden."),
        "upgradeRequiredTitle":
            MessageLookupByLibrary.simpleMessage("Upgrade erforderlich"),
        "viewSavedNotes": MessageLookupByLibrary.simpleMessage(
            "Gespeicherte Notizen anzeigen"),
        "welcomeToTravelMate":
            MessageLookupByLibrary.simpleMessage("Willkommen bei TravelMate"),
        "yes": MessageLookupByLibrary.simpleMessage("Ja")
      };
}
