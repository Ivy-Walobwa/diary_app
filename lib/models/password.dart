class Password{
  int id;
  String name;
  String password;

  Password({this.name, this.password});

  Password.fromJson(Map<String, dynamic> map){
    id = map['id'] as int;
    name = map['name'] as String;
    password = map['password'] as String;
  }

  Map<String, dynamic> toJson() =>{'id': id, 'name':name, 'password': password};

}