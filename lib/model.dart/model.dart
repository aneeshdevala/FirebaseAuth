class UserModel {
  String id;
  final String? name;
  final String? email;
  final String? password;
  final String? image;
  final String? address;
  final String? contact;

  UserModel({
    this.id = '',
    this.name,
    this.email,
    this.password,
    this.image,
    this.address,
    this.contact,
  });
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'password': password,
      'image': image,
      'address': address,
      'contact': contact,
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      password: json['password'],
      image: json['image'],
      address: json['address'],
      contact: json['contact'],
    );
  }
}
