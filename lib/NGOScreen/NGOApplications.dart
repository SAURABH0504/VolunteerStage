import 'package:flutter/material.dart';
import 'package:volunteerstage/Model/Application.dart';
import 'package:volunteerstage/Service/ApplicationService.dart';

class NGOApplications extends StatefulWidget {
  String id;
  NGOApplications(this.id);
  @override
  _NGOApplicationsState createState() => _NGOApplicationsState(id);
}

class _NGOApplicationsState extends State<NGOApplications> {
  String id;

  _NGOApplicationsState(this.id);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Your Applications', style: TextStyle(
            color: Colors.black, fontSize: 30, fontWeight: FontWeight.bold),),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            FutureBuilder(builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return snapshot.data;
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }
              return Container();
            }, future: getApplications(),),
          ],
        ),
      ),
    );
  }

  getApplications() async {
    var service = ApplicationService();
    print('Enter');
    List<Application> list = await service.getNGOApplications(id);
    print(list[0].applicationId);
    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        var c;
        if (list[index].status == 'Pending') {
          c = Colors.yellow;
        }
        else {
          if (list[index].status == 'Rejected') {
            c = Colors.red;
          }
          else {
            c = Colors.green;
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
                Column(
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
                        Expanded(child: Text('Application Status :',style: TextStyle(fontSize: 15),)),
                        Expanded(child: DropdownButton(
                          value: list[index].status,
                          items: [
                            DropdownMenuItem(value: 'Pending',child: Text('Pending',style: TextStyle(color: Colors.yellow.shade700),)),
                           DropdownMenuItem(value: 'Accept',child: Text('Accept',style: TextStyle(color: Colors.green),)),
                           DropdownMenuItem(value: 'Decline',child: Text('Decline',style: TextStyle(color: Colors.red),))
                          ],
                          onChanged: (value)async{
                            var service = ApplicationService();
                            await service.setStatus(list[index].applicationId, value, list[index].ngoId);
                            setState((){
                            });
                          },
                        ),
                        ),
                      ],
                    ),

                  ],
                ),
                ExpansionTile(title: Text('Details'),children: [
                  Column(
                    children: [
                      Row(
                        children: [
                          Text(' Name :'),
                          Text(list[index].volunteer.name),
                        ],
                      ),
                      Row(
                        children: [
                          Text(' Email :'),
                          Text(list[index].volunteer.email),
                        ],
                      ),
                      Row(
                        children: [
                          Text(' Occupation :'),
                          Text(list[index].volunteer.occupation),
                        ],
                      ),
                      Row(
                        children: [
                          Text(' Age :'),
                          Text(list[index].volunteer.age),
                        ],
                      ),
                      Row(
                        children: [
                          Text(' Contact Number :'),
                          Text(list[index].volunteer.contactNumber),
                        ],
                      )
                    ],
                  )
                ],),
              ],
            ),
          ),
        );
      }, itemCount: list.length,);
  }
}



