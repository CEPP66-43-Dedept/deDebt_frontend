class Matchers {
  String uid;
  final String ssn;
  final String firstname;
  final String lastname;
  final String email;
  final String tel;
  final String password;
  final String specialist;

  Matchers({
    required this.uid, // เปลี่ยนให้เป็น required parameter
    required this.ssn,
    required this.firstname,
    required this.lastname,
    required this.email,
    required this.tel,
    required this.password,
    required this.specialist,
  });

  factory Matchers.fromMap(Map<String, dynamic> map) {
    return Matchers(
      uid: map['uid'] ?? '',
      ssn: map['ssn'] ?? 0,
      firstname: map['firstName'] ?? '',
      lastname: map['lastName'] ?? '',
      email: map['email'] ?? '',
      tel: map['tel'] ?? '',
      password: map['password'] ?? '',
      specialist: map['specialist'] ?? '',
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'ssn': ssn,
      'firstName': firstname,
      'lastName': lastname,
      'email': email,
      'tel': tel,
      'specialist': specialist,
    };
  }
}
