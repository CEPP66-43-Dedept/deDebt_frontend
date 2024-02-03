class Matchers {
  final int id;
  final int ssn;
  final String firstname;
  final String lastname;
  final String roles;
  final String email;
  final String tel;
  final String password;
  Matchers(
      {required this.id,
      required this.ssn,
      required this.firstname,
      required this.lastname,
      required this.roles,
      required this.email,
      required this.tel,
      required this.password});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'ssn': ssn,
      'firstname': firstname,
      'lastname': lastname,
      'roles': roles,
      'email': email,
      'tel': tel,
      'password': password
    };
  }
}
