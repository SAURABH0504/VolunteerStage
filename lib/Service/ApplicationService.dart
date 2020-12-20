import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:volunteerstage/Model/Application.dart';
import 'package:volunteerstage/Model/NGO.dart';

class ApplicationService{

  var db = FirebaseFirestore.instance;

  SaveNGO(NGO ngo)
  {
    db.collection('NGO').doc(ngo.NGOId).collection('Details').doc('NGO Details').set(ngo.toMap());
  }

  SaveApplication(Application application)
  {
    db.collection('NGO').doc(application.ngoId).collection('applications').doc().set(
        application.toMap());
    db.collection('Volunteer').doc(application.volunteer.volunteerId).collection('applications').doc(application.applicationId).set(
        application.toMap());
  }

  getNGOApplications(String ngoId)async
  {
   var snapshot = await db.collection('NGO').doc(ngoId).collection('applications').get();
   List<Application> applications=[];
   snapshot.docs.forEach((element) {
     applications.add(Application.fromFirestore(element.data()));
   });
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