import 'package:flutter/material.dart';
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
              IconButton(icon: Icon(Icons.format_list_bulleted,color: Colors.black,), onPressed: (){Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ApplicationScreen(volunteerId)));}),
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
