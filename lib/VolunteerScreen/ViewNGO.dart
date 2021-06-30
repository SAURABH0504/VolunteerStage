import 'package:flutter/material.dart';
import 'package:volunteerstage/Model/Field.dart';
import 'package:volunteerstage/Model/Location.dart';
import 'package:volunteerstage/Model/NGO.dart';
import 'package:volunteerstage/Service/ApplicationService.dart';
import 'package:volunteerstage/VolunteerScreen/ApplicationScreen.dart';
import 'package:volunteerstage/VolunteerScreen/NGODetails.dart';

class ViewNGO extends StatefulWidget {
  String volunteerId;
  ViewNGO(this.volunteerId);
  @override
  _ViewNGOState createState() => _ViewNGOState(volunteerId);
}

class _ViewNGOState extends State<ViewNGO> {
  String volunteerId;
  _ViewNGOState(this.volunteerId);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.white,title: Row(
        children: [
          Expanded(flex:3,child: Text(' ')),
          Expanded(flex:1,child: Column(
            children: [
              Text('Applications',style: TextStyle(color: Colors.black,fontSize: 11),),
              IconButton(icon: Icon(Icons.format_list_bulleted,color: Colors.black,), onPressed: () {
                /*NGO ngo=NGO(name: "Santosh Hardware,",
                    NGOId: "125",
                    location: [Location(address: "150 regal street",city: "Indore",),Location(address: "160 saket street",city: "Indore",),],
                    description: "Established in the year 2019, Hindustan Hardware in Pipliyahana, Indore is a top player in the category Hardware Shops in the Indore. This well-known establishment acts as a one-stop destination servicing customers both local and from other parts of Indore. Over the course of its journey, this business has established a firm foothold in it’s industry. The belief that customer satisfaction is as important as their products and services, have helped this establishment garner a vast base of customers, which continues to grow by the day. This business employs individuals that are dedicated towards their respective roles and put in a lot of effort to achieve the common vision and larger goals of the company. In the near future, this business aims to expand its line of products and services and cater to a larger client base",
                    imageUrl: "data:image/jpeg;base64,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"
                    , field: [Field(fieldName: "Sanitary fitting"),Field(fieldName: "Carpenter Work"),Field(fieldName: "Plumber Work"),]
                );
                ApplicationService service=ApplicationService();
                service.SaveNGO(ngo);*/
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ApplicationScreen(volunteerId)));
               }
                ),
            ],
          ))
        ],
      ),),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black,width: 2),
                borderRadius: BorderRadius.circular(70)
              ),
              child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Center(
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: 'Search',
                        fillColor: Colors.black,
                      ),
                      onChanged: (value){

                      },
                    ),
                  ),
                ),
            ),
            FutureBuilder(builder: (context,snapshot){
                if(snapshot.connectionState == ConnectionState.done){
                  return snapshot.data;
                }
                if(snapshot.connectionState==ConnectionState.waiting){
                  return CircularProgressIndicator();
                }
                return Container();
              },future: getNGO(),),
          ],
        ),
      ),
    );
  }

  Future<Widget> getNGO()async{
    List<NGO> list;
    var service=ApplicationService();
    list = await service.getAllNGO();
    print('IN Get NGO length is '+list.length.toString());
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: Colors.black,width: 2)
      ),
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return FlatButton(
            onPressed: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>NGODetails(list[index].NGOId,volunteerId)));
            },
            child: Card(
              child: Column(
                children: [
                  SizedBox(width: 400,height: 200,child: Image(image: NetworkImage(list[index].imageUrl),)),
                  Column(
                    children: [
                      Text(list[index].name,style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold),),
                    ],
                  )
                ],
              ),
            ),
          );
        },
        itemCount: list.length,
      ),
    );
  }
}
