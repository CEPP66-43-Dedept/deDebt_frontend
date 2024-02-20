class Advisors {
  String uid;
  final int ssn;
  final String firstname;
  final String lastname;
  final String email;
  final String tel;
  final String password;
  final String specialist;

  Advisors({
    required this.uid, // เปลี่ยนให้เป็น required parameter
    required this.ssn,
    required this.firstname,
    required this.lastname,
    required this.email,
    required this.tel,
    required this.password,
    required this.specialist,
  });

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
