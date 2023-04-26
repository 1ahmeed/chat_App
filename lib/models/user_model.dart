class UserModel {
  String? name;
  String? email;
  String? phone;
  String? image;
  String? uId;


  UserModel(
      {this.email,
        this.name,
        this.phone,
        this.uId,
        this.image
        });



  UserModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    uId = json['uId'];
    image = json['image'];
  }

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'name': name,
      'phone': phone,
      'uId': uId,
      'image': image,
    };
  }
}