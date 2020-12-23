import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:volunteerstage/Model/Application.dart';
import 'package:volunteerstage/Model/NGO.dart';
import 'package:volunteerstage/Model/Volunteer.dart';

class ApplicationService{

  var db = FirebaseFirestore.instance;

  getVolunteerApplication(String id)async{
    var snapshot=await db.collection('Volunteer').doc(id).collection('applications').get();
    List<Application> applications=[];
    snapshot.docs.forEach((element) {applications.add(Application.fromFirestore(element.data()));});
    return applications;
  }

  SaveVolunteer(Volunteer volunteer){
    db.collection('Volunteer').doc(volunteer.volunteerId).collection('Details').doc('Volunteer Details').set(volunteer.toMap());
  }


  getVolunteer(String id)async{
    var snapshot= await db.collection('Volunteer').doc(id).collection('Details').doc('Volunteer Details').get();
    var volunteer = Volunteer.fromFirestore(snapshot.data());
    return volunteer;
  }

  NGOApplications(NGO ngo){
    db.collection('NGO Applications').doc(ngo.NGOId).set(ngo.toMap());
  }

  SaveNGO(NGO ngo)
  {
    db.collection('NGO').doc(ngo.NGOId).collection('Details').doc('NGO Details').set(ngo.toMap());
    int k=0;
    var snapshot = db.collection('NGO List').where('ngoId',isEqualTo: ngo.NGOId).get();
    snapshot.then((value) => k=value.docs.length);
    print(k);
    if(k==0)
    {db.collection('NGO List').doc().set({'ngoId':ngo.NGOId});}
  }

  Future<NGO> getNGO(String id)async {
    NGO ngo=NGO();
    var snapshot = await db.collection('NGO').doc(id).collection('Details').get();
    snapshot.docs.forEach((element) {ngo=NGO.fromFirestore(element.data());});
    print(ngo.name);
    return ngo;
  }

  Future<List<NGO>> getAllNGO()async{
    var snapshot=await db.collection('NGO List').get();
    List<NgoId> ngoIdList=[];
    snapshot.docs.forEach((element) {ngoIdList.add(NgoId.fromFirestore(element.data()));});
    print('Enter');
    List<NGO> list=[];
    print('length is '+ngoIdList.length.toString());
    int n=ngoIdList.length,i=0;
    while(i<n)
      {
        snapshot = await db.collection('NGO').doc(ngoIdList[i].ngoId).collection('Details').get();
        snapshot.docs.forEach((element) {list.add(NGO.fromFirestore(element.data()));});
        i++;
      }
    print('NGO list is '+list.length.toString());
    return list;
  }

  SaveApplication(Application application)async
  {
    var snapshot=await db.collection('Volunteer').doc(application.volunteer.volunteerId).collection('applications').where('ngoId',isEqualTo: application.ngoId).get();
    String id;
    snapshot.docs.forEach((element) {id=element.id;});
    print(id);
    if(id==null)
      {
        db.collection('NGO').doc(application.ngoId).collection('applications').doc(application.applicationId).set(
            application.toMap());
        db.collection('Volunteer').doc(application.volunteer.volunteerId).collection('applications').doc(application.applicationId).set(
            application.toMap());
        return true;
      }
    else
      {
        application.applicationId=id;
        db.collection('NGO').doc(application.ngoId).collection('applications').doc(id).set(
            application.toMap());
        db.collection('Volunteer').doc(application.volunteer.volunteerId).collection('applications').doc(id).set(
            application.toMap());
        return false;
      }
  }

  getNGOApplications(String ngoId)async
  {
    print('ID is '+ngoId);
    var snapshot = await db.collection('NGO').doc(ngoId).collection('applications').get();
   List<Application> applications=[];
   snapshot.docs.forEach((element) {
     applications.add(Application.fromFirestore(element.data()));
   });
   print('Length is '+applications.length.toString());
   return applications;
  }

  setStatus(String applicationId,String status,ngoId)async
  {
    var snapshot=await db.collection('NGO').doc(ngoId).collection('applications').where('applicationId',isEqualTo: applicationId).get();
    String id;
    snapshot.docs.forEach((element) { id=element.id;});
    await db.collection('NGO').doc(ngoId).collection('applications').doc(id).update({'status':status});
    var applicationData = await db.collection('NGO').doc(ngoId).collection('applications').doc(id).get();
    Application application =  Application.fromFirestore(applicationData.data());
    await db.collection('Volunteer').doc(application.volunteer.volunteerId).collection('applications').doc(application.applicationId).update(
        application.toMap());
  }
}

class NgoId{
  String ngoId;

  NgoId({this.ngoId});

  Map<String,dynamic> toMap(){
    return {'ngoId':ngoId};
  }
  NgoId.fromFirestore(Map<String,dynamic> firestore): ngoId=firestore['ngoId'];
}