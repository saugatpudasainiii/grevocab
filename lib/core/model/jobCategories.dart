// ignore: file_names
class BookCatagories {
  bool? success;
  List<Data>? data;
  String? msg;

  BookCatagories({this.success, this.data, this.msg});

  BookCatagories.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
    msg = json['msg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['msg'] = msg;
    return data;
  }
}

class Data {
  List<Subcat>? subcat;
  String? sId;
  String? name;
  String? description;
  String? slug;
  int? iV;

  Data(
      {this.subcat, this.sId, this.name, this.description, this.slug, this.iV});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['subcat'] != null) {
      subcat = <Subcat>[];
      json['subcat'].forEach((v) {
        subcat!.add(Subcat.fromJson(v));
      });
    }
    sId = json['_id'];
    name = json['name'];
    description = json['description'];

    slug = json['slug'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (subcat != null) {
      data['subcat'] = subcat!.map((v) => v.toJson()).toList();
    }
    data['_id'] = sId;
    data['name'] = name;
    data['description'] = description;

    data['slug'] = slug;
    data['__v'] = iV;
    return data;
  }
}

class Subcat {
  String? sId;
  String? name;
  String? description;
  String? maincat;
  String? slug;

  Subcat({this.sId, this.name, this.description, this.maincat, this.slug});

  Subcat.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    description = json['description'];
    maincat = json['maincat'];
    slug = json['slug'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['name'] = name;
    data['description'] = description;
    data['maincat'] = maincat;
    data['slug'] = slug;
    return data;
  }
}
