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
                NGO ngo=NGO(name: "Ruchi Electricals,",
                    NGOId: "123",
                    location: [Location(address: "150 regal street",city: "Indore",),Location(address: "160 saket street",city: "Indore",),],
                    description: "Established in the year 2015, Ruchi Electricals Agency in Palhar Nagar, Indore is a top player in the category Electrical Shops in the Indore. This well-known establishment acts as a one-stop destination servicing customers both local and from other parts of Indore. Over the course of its journey, this business has established a firm foothold in it’s industry. The belief that customer satisfaction is as important as their products and services, have helped this establishment garner a vast base of customers, which continues to grow by the day. This business employs individuals that are dedicated towards their respective roles and put in a lot of effort to achieve the common vision and larger goals of the company. In the near future, this business aims to expand its line of products and services and cater to a larger client base. In Indore, this establishment occupies a prominent location in Palhar Nagar."
                    , imageUrl: "https://content.jdmagicbox.com/comp/indore/y8/0731px731.x731.171128182018.r4y8/catalogue/ruchi-electricals-agency-palhar-nagar-indore-electricians-03mwvztn4v.jpg?clr="
                    , field: [Field(fieldName: "Wiring"),Field(fieldName: "Socket repairing"),Field(fieldName: "Fuse Installation"),]
                );
                ApplicationService service=ApplicationService();
                service.SaveNGO(ngo);

              }
                ),    //Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ApplicationScreen(volunteerId)));}),
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
                  Image(image: NetworkImage(list[index].imageUrl),),
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
