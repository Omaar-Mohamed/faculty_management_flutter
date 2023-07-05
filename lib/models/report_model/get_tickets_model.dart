class GetTicketsModel {
  String? status;
  String? message;
  List<Data>? data;
  Pagination? pagination;

  GetTicketsModel({this.status, this.message, this.data, this.pagination});

  GetTicketsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    pagination = json['pagination'] != null
        ? new Pagination.fromJson(json['pagination'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    if (this.pagination != null) {
      data['pagination'] = this.pagination!.toJson();
    }
    return data;
  }
}

class Data {
  int? id;
  String? title;
  String? description;
  String? category;
  String? status;
  String? createdAt;
  String? updatedAt;
  AssingnedTo? assingnedTo;

  Data(
      {this.id,
        this.title,
        this.description,
        this.category,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.assingnedTo});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    category = json['category'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    assingnedTo = json['assingned_to'] != null
        ? new AssingnedTo.fromJson(json['assingned_to'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['category'] = this.category;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.assingnedTo != null) {
      data['assingned_to'] = this.assingnedTo!.toJson();
    }
    return data;
  }
}

class AssingnedTo {
  User? user;

  AssingnedTo({this.user});

  AssingnedTo.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}

class User {
  int? id;
  String? fname;
  String? sname;
  String? tname;
  String? lname;
  String? email;
  String? username;
  String? gender;
  String? avatar;
  String? role;

  User(
      {this.id,
        this.fname,
        this.sname,
        this.tname,
        this.lname,
        this.email,
        this.username,
        this.gender,
        this.avatar,
        this.role});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fname = json['fname'];
    sname = json['sname'];
    tname = json['tname'];
    lname = json['lname'];
    email = json['email'];
    username = json['username'];
    gender = json['gender'];
    avatar = json['avatar'];
    role = json['role'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['fname'] = this.fname;
    data['sname'] = this.sname;
    data['tname'] = this.tname;
    data['lname'] = this.lname;
    data['email'] = this.email;
    data['username'] = this.username;
    data['gender'] = this.gender;
    data['avatar'] = this.avatar;
    data['role'] = this.role;
    return data;
  }
}

class Pagination {
  int? total;
  int? perPage;
  int? currentPage;
  String? nextPageUrl;
  String? lastPageUrl;
  int? from;
  int? to;

  Pagination(
      {this.total,
        this.perPage,
        this.currentPage,
        this.nextPageUrl,
        this.lastPageUrl,
        this.from,
        this.to});

  Pagination.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    perPage = json['per_page'];
    currentPage = json['current_page'];
    nextPageUrl = json['next_page_url'];
    lastPageUrl = json['last_page_url'];
    from = json['from'];
    to = json['to'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total'] = this.total;
    data['per_page'] = this.perPage;
    data['current_page'] = this.currentPage;
    data['next_page_url'] = this.nextPageUrl;
    data['last_page_url'] = this.lastPageUrl;
    data['from'] = this.from;
    data['to'] = this.to;
    return data;
  }
}
