
import 'package:flutter_riverpod/flutter_riverpod.dart';

class StateModel {
  String name;
  String place;
  String age;
  String phone;
  String qualification;

  StateModel({
    required this.name,
    required this.place,
    required this.age,
    required this.phone,
    required this.qualification,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'place': place,
      'age': age,
      'phone': phone,
      'qualification': qualification,
    };
  }

  factory StateModel.fromMap(Map<String, dynamic> map) {
    return StateModel(
      name: map['name'],
      place: map['place'],
      age: map['age'],
      phone: map['phone'],
      qualification: map['qualification'],
    );
  }
  StateModel copyWith({
    String? name,
    String? place,
    String? age,
    String? phone,
    String? qualification,
  }) {
    return StateModel(
      name: name ?? this.name,
      place: place ?? this.place,
      age: age ?? this.age,
      phone: phone ?? this.phone,
      qualification: qualification ?? this.qualification,
    );
  }
}
class SampleNotifier extends StateNotifier<List<StateModel>>{
  SampleNotifier() : super([]);
  void addListItem(StateModel){
    state = [...state, StateModel];
  }
  void removeItem(int index) {
    final toRemove = [...state];
    toRemove.removeAt(index);
    state = toRemove;

  }
  void updateItem(int index, StateModel updatedItem) {
    final updatedList = [...state];
    updatedList[index] = updatedItem;
    state = updatedList;
  }
}

