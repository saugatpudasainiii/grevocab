// ignore: file_names
class SignUp {
  String? status;
  String? token;
  Data? data;

  SignUp({this.status, this.token, this.data});

  SignUp.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    token = json['token'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['token'] = token;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  User? user;

  Data({this.user});

  Data.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}

class User {
  UserType? userType;
  String? role;
  bool? active;
  String? sId;
  String? name;
  String? email;
  int? iV;

  User(
      {this.userType,
      this.role,
      this.active,
      this.sId,
      this.name,
      this.email,
      this.iV});

  User.fromJson(Map<String, dynamic> json) {
    userType =
        json['userType'] != null ? UserType.fromJson(json['userType']) : null;
    role = json['role'];
    active = json['active'];
    sId = json['_id'];
    name = json['name'];
    email = json['email'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (userType != null) {
      data['userType'] = userType!.toJson();
    }
    data['role'] = role;
    data['active'] = active;
    data['_id'] = sId;
    data['name'] = name;
    data['email'] = email;
    data['__v'] = iV;
    return data;
  }
}

class UserType {
  bool? isExchanger;
  bool? isSeller;

  UserType({this.isExchanger, this.isSeller});

  UserType.fromJson(Map<String, dynamic> json) {
    isExchanger = json['isExchanger'];
    isSeller = json['isSeller'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['isExchanger'] = isExchanger;
    data['isSeller'] = isSeller;
    return data;
  }
}
