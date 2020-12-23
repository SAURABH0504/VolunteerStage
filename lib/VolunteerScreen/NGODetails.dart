import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:volunteerstage/Model/Application.dart';
import 'package:volunteerstage/Model/NGO.dart';
import 'package:volunteerstage/Service/ApplicationService.dart';
import 'package:volunteerstage/VolunteerScreen/ApplicationScreen.dart';

class NGODetails extends StatefulWidget {
  String ngoId;
  String volunteerId;
  NGODetails(this.ngoId,this.volunteerId);
  @override
  _NGODetailsState createState() => _NGODetailsState(ngoId,volunteerId);
}

class _NGODetailsState extends State<NGODetails> {
  String ngoId;
  String volunteerId;
  _NGODetailsState(this.ngoId,this.volunteerId);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: FutureBuilder(
            builder: (context,snapshot){
              if(snapshot.connectionState == ConnectionState.done){
              return snapshot.data;
            }
             if(snapshot.connectionState==ConnectionState.waiting){
             return Center(child: CircularProgressIndicator());
            }
            return Container();
           },
            future: getDetails(ngoId),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        child: Text('Apply'),
        onPressed: ()async{
          var service = ApplicationService();
          var volunteer = await service.getVolunteer(volunteerId);
          service.SaveVolunteer(volunteer);
          String applicationid ="VS"+UniqueKey().toString();
          Application application= Application(status: 'Pending',volunteer: volunteer,ngoId: ngoId,applicationId: applicationid);
          service.SaveApplication(application);
          Fluttertoast.showToast(
              msg: "Application Submitted",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 16.0
          );
          Navigator.push(context, MaterialPageRoute(builder: (_)=>ApplicationScreen(volunteerId)));
        },
      ),
    );
  }
  Future<Widget> getDetails(String id)async{
    NGO ngo=NGO();
    var service=ApplicationService();
    ngo=await service.getNGO(id);
    return Container(
      child: Card(
        child: Column(
          children: [
            Image(image: NetworkImage(ngo.imageUrl),),
            Text(ngo.name,style: TextStyle(color: Colors.black,fontSize: 30),),
            Text('Who We Are?',style: TextStyle(color: Colors.black,fontSize: 25,fontWeight: FontWeight.bold),),
            Text(ngo.description,style: TextStyle(color: Colors.black,fontSize: 15),),
            SizedBox(height: 3,),
            Text('Field Of Work',style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold),),
            ListView.builder(scrollDirection: Axis.vertical,
              shrinkWrap: true,itemBuilder: (context,index){
              return Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text((index+1).toString()+ " " + ngo.field[index].fieldName,style: TextStyle(fontSize: 15),),
              );
            },itemCount: ngo.field.length,),
            Text('Locations',style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold),),
            ListView.builder(scrollDirection: Axis.vertical,
              shrinkWrap: true,itemBuilder: (context,index){
                return Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Text((index+1).toString()+ " " + ngo.location[index].city,style: TextStyle(fontSize: 15),),
                );
              },itemCount: ngo.location.length,),
          ],
        ),
      ),
    );
  }
}
