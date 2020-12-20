class Field{
  String fieldName;

  Field({this.fieldName});

  Map<String,dynamic> toMap(){
    return {
      'fieldName':fieldName
    };
  }

  Field.fromFirestore(Map<String,dynamic> firestore)
      : fieldName=firestore['fieldName'];

  static List<Map> ConvertCustomStepsToMap(List<Field> customSteps){
    List<Map> steps = [];
    customSteps.forEach((Field customStep) {
      Map step = customStep.toMap();
      steps.add(step);
    });
    return steps;
  }
}