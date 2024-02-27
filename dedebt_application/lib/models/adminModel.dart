class Admins {
  String _uid;
  final int id;
  final int ssn;
  final String firstname;
  final String lastname;
  final String roles;
  final String email;
  final String tel;
  final String password;
  final String uid;

  Admins(
      {required this.id,
      required this.ssn,
      required this.firstname,
      required this.lastname,
      required this.roles,
      required this.email,
      required this.tel,
      required this.password,
      required this.uid})
      : _uid = uid;
  set uid(String value) {
    _uid = value;
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'ssn': ssn,
      'firstname': firstname,
      'lastname': lastname,
      'roles': roles,
      'email': email,
      'tel': tel,
      'password': password,
      'uid': uid
    };
  }
}
