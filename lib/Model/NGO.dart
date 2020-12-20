import 'package:volunteerstage/Model/Field.dart';
import 'package:volunteerstage/Model/Location.dart';

class NGO{
  String NGOId;
  String name;
  List<Location> location;
  String description;
  List<Field> field;

  NGO({this.NGOId,this.name, this.location, this.description, this.field});

  Map<String,dynamic> toMap(){
    return {
      'NGOId':NGOId,
      'name':name,
      'location':Location.ConvertCustomStepsToMap(location),
      'description':description,
      'field':Field.ConvertCustomStepsToMap(field)
    };
  }

  NGO.fromFirestore(Map<String,dynamic> firestore)
   : NGOId=firestore['NGOId'],
     name=firestore['name'],
     location = (firestore['location'] as List).map((e) => Location.fromFirestore(e.cast<String,dynamic>())).toList(),
     description=firestore['description'],
     field=(firestore['field'] as List).map((e) => Field.fromFirestore(e.cast<String,dynamic>())).toList();
}