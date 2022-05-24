class User
{
  static const String COLLECTION_NAME  = 'Owner';
  String id;
  String name;
  String email;
  String password;
  String phoneNumber;
  bool isOwner;

  String get getName => name;
  String get getEmail => email;

  User({ this.id,  this.name,  this.email, this.password, this.phoneNumber, this.isOwner});

  User.fromJson(Map<String, Object> json)
      : this(
    id: json['id'] as String,
    name: json['name'] as String,
    email: json['email'] as String,
    password: json['email'] as String,
    phoneNumber: json['email'] as String,
    isOwner: json['email'] as bool,
  );

  Map<String, Object> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'password': password,
      'phone_number': phoneNumber,
      'is_owner': isOwner
    };
  }


}