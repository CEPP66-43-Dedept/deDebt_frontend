class Users {
  final String id;
  final int ssn;
  final String firstname;
  final String lastname;
  final int role;
  final String email;
  final String tel;
  Users({
    required this.id,
    required this.ssn,
    required this.firstname,
    required this.lastname,
    required this.role,
    required this.email,
    required this.tel,
  });
  factory Users.fromMap(Map<String, dynamic> map) {
    return Users(
      id: map['uid'] ?? '',
      ssn: map['ssn'] ?? 0,
      firstname: map['firstName'] ?? '',
      lastname: map['lastName'] ?? '',
      role: map['role'] ?? '',
      tel: map['tel'] ?? '',
      email: map['email'] ?? '',
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'ssn': ssn,
      'firstName': firstname,
      'lastName': lastname,
      'role': role,
      'email': email,
      'tel': tel,
    };
  }
}
