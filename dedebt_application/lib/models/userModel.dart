class Users {
  final int id;
  final int ssn;
  final String firstname;
  final String lastname;
  final String roles;
  final List<int> requests;
  final String email;
  final String tel;
  final String password;
  Users(
      {required this.id,
      required this.ssn,
      required this.firstname,
      required this.lastname,
      required this.roles,
      required this.requests,
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
      'requests': requests,
      'email': email,
      'tel': tel,
      'password': password
    };
  }
}
