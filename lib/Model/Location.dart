class Location{
  String city;
  String address;

  Location({this.city, this.address});

  Map<String,dynamic> toMap(){
    return {
      'city':city,
      'address':address
    };
  }

  Location.fromFirestore(Map<String,dynamic> firestore)
     : city=firestore['city'],
       address=firestore['address'];

  static List<Map> ConvertCustomStepsToMap(List<Location> customSteps){
    List<Map> steps = [];
    customSteps.forEach((Location customStep) {
      Map step = customStep.toMap();
      steps.add(step);
    });
    return steps;
  }
}