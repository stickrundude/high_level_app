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
        "changePassword":
            MessageLookupByLibrary.simpleMessage("Passwort ändern"),
        "currentPassword":
            MessageLookupByLibrary.simpleMessage("Aktuelles Passwort"),
        "email": MessageLookupByLibrary.simpleMessage("E-Mail"),
        "firstName": MessageLookupByLibrary.simpleMessage("Vorname"),
        "language": MessageLookupByLibrary.simpleMessage("Sprache"),
        "lastName": MessageLookupByLibrary.simpleMessage("Nachname"),
        "login": MessageLookupByLibrary.simpleMessage("Anmelden"),
        "loginFailed": MessageLookupByLibrary.simpleMessage(
            "Anmeldung fehlgeschlagen. Bitte überprüfen Sie Ihre Anmeldeinformationen."),
        "loginSuccess":
            MessageLookupByLibrary.simpleMessage("Erfolgreich angemeldet"),
        "logout": MessageLookupByLibrary.simpleMessage("Abmelden"),
        "password": MessageLookupByLibrary.simpleMessage("Passwort"),
        "repeatPassword":
            MessageLookupByLibrary.simpleMessage("Password wiederholen"),
        "save": MessageLookupByLibrary.simpleMessage("Speichern"),
        "settings": MessageLookupByLibrary.simpleMessage("Einstellungen"),
        "signUp": MessageLookupByLibrary.simpleMessage("Registrieren"),
        "signupFailed": MessageLookupByLibrary.simpleMessage(
            "Registrierung fehlgeschlagen. Bitte versuchen Sie es erneut."),
        "signupSuccess":
            MessageLookupByLibrary.simpleMessage("Registrierung erfolgreich!"),
        "welcome":
            MessageLookupByLibrary.simpleMessage("Willkommen bei TravelMate")
      };
}
