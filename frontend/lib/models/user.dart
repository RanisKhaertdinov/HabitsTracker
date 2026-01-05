class User {
  final String? id;
  final String? email;
  final String? name;
  
  const User({
    required this.id,
    required this.email,
    required this.name,
  });

  factory User.fromJson(Map<String, dynamic> map) {
    return User(
      id: map['id'] as String?,
      email: map['email'] as String?,
      name: map['name'] as String?,
    );
  }
}