class TestModel{

  final String name;
  final String email;
  final String password;
  final String id;
  TestModel({required this.name,required this.email,required this.password,required this.id});

  Map<String,dynamic> toMap(){
    return {
      "name":this.name,
      "email":this.email,
      "password":this.password,
      "id":this.id
    };
  }

  factory TestModel.fromMap(Map<String,dynamic>map){
    return TestModel(
        name: map['name'],
        email: map['email'],
        password: map['password'],
        id: map['id']
    );
  }

  copyWith({String? name, String? email, String? password, String? id}){
    return TestModel(
        name: name?? this.name,
        password: password?? this.password,
      email: email?? this.email,
      id: id?? this.id,
    );
  }
}
class UserModel{
   String id;
   String email;
   String password;
   String username;
   String confirmpassword;
   List? searchkey;
  UserModel(  { required this.searchkey,required this.email,required this.password,required this.username,required this.confirmpassword,required this.id});

  Map<String,dynamic> toMap(){
    return {
      "email":this.email,
      "password":this.password,
      "username":this.username,
      "confirmpassword":this.confirmpassword,
      "id":this.id,
      "searchkey":this.searchkey??[]
    };
  }
  factory UserModel.fromMap(Map<String,dynamic>map){
    return UserModel(
        username: map['username'],
        email: map['email'],
        password: map['password'],
        confirmpassword: map['confirmpassword'],
      id: map['id'],
      searchkey: map['searchkey'],

    );
  }
  copyWith({
    String? email,
    String? password,
    String? username,
    String? confirmpassword,
    String? id,
    List?searchkey,
  } ){
    return UserModel(
      email: email??this.email,
      password: password??this.password,
      username: username??this.username,
      confirmpassword: confirmpassword??this.confirmpassword,
      id: id??this.id,
      searchkey:searchkey??this.searchkey ,
    );
  }
}
class NoteModel {
  String title;
  String content;
  String id;

  NoteModel({ required this.title, required this.content, required this.id});

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'content': content,
      'id': id,
    };
  }
  factory NoteModel.fromMap(Map<String,dynamic>map){
   return NoteModel(
     title: map['title'],
     content: map['content'],
     id: map['id'],
   );
  }
  copyWith({String? title,
    String? content,
    String? id,
  } ){
  return NoteModel(
  title: title??this.title,
  content: content??this.content,
    id: id??this.id,
  );
}
  }

  class StudentModel {
  String name;
  String email;
  String age;
  String id;

  StudentModel({required  this.id, required this.name , required this.email, required this.age});

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'age': age,
      'id':id,
    };
  }
  factory StudentModel.fromMap(Map<String,dynamic>map){
   return StudentModel(
     name: map['name'],
     email: map['email'],
     age: map['age'],
     id: map['id']
   );
  }
  copyWith({String? name,
    String? email,
    String? age,
    String? id,
  } ){
  return StudentModel(
  name: name??this.name,
  email: email??this.email,
    age: age??this.age,
    id: id?? this.id,
  );
}
  }

