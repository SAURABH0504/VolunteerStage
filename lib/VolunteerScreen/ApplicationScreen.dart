import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:volunteerstage/Model/Application.dart';
import 'package:volunteerstage/Service/ApplicationService.dart';

class ApplicationScreen extends StatefulWidget {
  String id;
  ApplicationScreen(this.id);
  @override
  _ApplicationScreenState createState() => _ApplicationScreenState(id);
}

class _ApplicationScreenState extends State<ApplicationScreen> {
  String id;
  _ApplicationScreenState(this.id);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Your Applications',style: TextStyle(color: Colors.black,fontSize: 30,fontWeight: FontWeight.bold),),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            FutureBuilder(builder: (context,snapshot){
              if(snapshot.connectionState == ConnectionState.done){
                return snapshot.data;
              }
              if(snapshot.connectionState==ConnectionState.waiting){
                return Center(child: CircularProgressIndicator());
              }
              return Container();
            },future: getApplications(),),
          ],
        ),
      ),
    );
  }
  getApplications()async{
    var service = ApplicationService();
    List<Application> list=await service.getVolunteerApplication(id);
    return ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemBuilder: (context,index){
      var c;
      if(list[index].status=='Pending')
        {
          c=Colors.yellow;
        }
      else
        {
          if(list[index].status=='Rejected')
            {
              c=Colors.red;
            }
          else
            {
              c=Colors.green;
            }
        }
      return Card(
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
            borderRadius: BorderRadius.circular(20)
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                 Center(child: Text('Application No. '+(index+1).toString(),style: TextStyle(fontSize: 15),)),
                ],
              ),
              Row(
                children: [
                  SizedBox(width: 10,),
                  Expanded(child: Text('Application Id :',style: TextStyle(fontSize: 15),)),
                  Expanded(child: Text(list[index].applicationId,style: TextStyle(fontSize: 15),)),
                ],
              ),
              Row(
                children: [
                  SizedBox(width: 10,),
                  Expanded(child: Text('Your Name :',style: TextStyle(fontSize: 15),)),
                  Expanded(child: Text(list[index].volunteer.name,style: TextStyle(fontSize: 15),)),
                ],
              ),
              Row(
                children: [
                  SizedBox(width: 10,),
                  Expanded(child: Text('Application Status :',style: TextStyle(fontSize: 15),)),
                  Expanded(child: Text(list[index].status,style: TextStyle(fontSize: 15,color: c),),),
                ],
              ),
              Row(
                children: [
                  SizedBox(width: 10,),
                  Expanded(child: Text('Contact Number :',style: TextStyle(fontSize: 15),)),
                  Expanded(child: Text(list[index].volunteer.contactNumber,style: TextStyle(fontSize: 15),),),
                ],
              ),
              FutureBuilder(builder: (context,snapshot){
                if(snapshot.connectionState == ConnectionState.done){
                  return snapshot.data;
                }
                if(snapshot.connectionState==ConnectionState.waiting){
                  return Text('Loading');
                }
                return Container(
                  child: Text('Loading'),
                );
              },future: getNGO(list[index].ngoId),),
            ],
          ),
        ),
      );
    },itemCount: list.length,);
  }
  getNGO(String id)async{
    var service=ApplicationService();
    var ngo=await service.getNGO(id);
    return Row(
      children: [
        SizedBox(width: 10,),
        Expanded(child: Text('NGO name :',style: TextStyle(fontSize: 15),)),
        Expanded(child: Text(ngo.name,style: TextStyle(fontSize: 15),),),
      ],
    );
  }
}
