class AppUser {
  final String uid;
  final String firstName;
  final String lastName;
  final String email;

  AppUser({
    required this.uid,
    required this.firstName,
    required this.lastName,
    required this.email,
  });

  factory AppUser.fromMap(Map<String, dynamic> map) {
    return AppUser(
      uid: map['uid'] ?? '',
      firstName: map['firstName'] ?? '',
      lastName: map['lastName'] ?? '',
      email: map['email'] ?? '',
    );
  }
}
