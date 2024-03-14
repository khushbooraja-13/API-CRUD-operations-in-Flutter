class StudentModel{
  String? _name;
  String? _age;
  String get name => _name!;
  set name(String newName){
    _name = newName;
  }

  String get age => _age!;
  set age(String newAge) {
    _age = newAge;
  }

  Map<String, dynamic> mapConverter(){
    return {
      "name" : _name,
      "age" : _age
    };
  }
}