import 'package:volunteerstage/Model/Volunteer.dart';

class Application{

  Volunteer volunteer;
  String ngoId;
  String applicationId;
  String status;

  Application({this.volunteer, this.ngoId, this.applicationId,this.status});

  Map<String,dynamic> toMap(){
    return{
      'volunteer':volunteer.toMap(),
      'ngoId':ngoId,
      'applicationId':applicationId,
      'status':status
    };
  }

  Application.fromFirestore(Map<String,dynamic> firestore)
    : volunteer = Volunteer.fromFirestore(firestore['volunteer']),
      ngoId = firestore['ngoId'],
      applicationId = firestore['applicationId'],
      status = firestore['status'];
}