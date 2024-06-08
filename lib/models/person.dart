class Person {
  String firstName;
  String lastName;
  String phoneNumber;
  String email;
  bool personStatus;

  Person({
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.email,
    this.personStatus = false,
  });
}
