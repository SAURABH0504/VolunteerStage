import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:volunteerstage/Model/Field.dart';
import 'package:volunteerstage/Model/Location.dart';
import 'package:volunteerstage/Model/NGO.dart';
import 'package:volunteerstage/Service/ApplicationService.dart';

class NGORegister extends StatefulWidget {
  @override
  _NGORegisterState createState() => _NGORegisterState();
}

class _NGORegisterState extends State<NGORegister> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String field1;
  String city;
  String address;
  String NGOId;
  String imageUrl;
  String name;
  List<Location> location=new List<Location>();
  String description;
  String password2;
  List<Field> field=new List<Field>();
  String password;
  Widget _buildName() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'NGO Name'),
      maxLength: 20,
      validator: (String value) {
        if (value.isEmpty) {
          return 'NGO Name is Required';
        }

        return null;
      },
      onChanged: (String value) {
        setState(() {
          this.name = value;
        });
      },
    );
  }
  Widget _buildimageUrl() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Image Url'),
      validator: (String value) {
        if (value.isEmpty) {
          return 'Url is Required';
        }

        return null;
      },
      onChanged: (String value) {
        setState(() {
          this.imageUrl = value;
        });
      },
    );
  }
  Widget _buildDescription() {
    return TextFormField(
      minLines: 1,
      maxLines: 5,
      decoration: InputDecoration(labelText: 'Description'),
      validator: (String value) {
        if (value.isEmpty) {
          return 'Description is Required';
        }

        return null;
      },
      onChanged: (String value) {
        setState(() {
          this.description = value;
        });
      },
    );
  }
  Widget _buildPassword() {
    return Column(
      children: [
        TextFormField(
          obscureText: true,
          decoration: InputDecoration(labelText: 'Password'),
          keyboardType: TextInputType.visiblePassword,
          validator: (String value) {
            if (value.isEmpty) {
              return 'Password is Required';
            }

            return null;
          },
          onChanged: (value){
            setState(() {
              this.password=value;
            });
          },
        ),
        TextFormField(
          obscureText: true,
          decoration: InputDecoration(labelText: 'Confirm Password'),
          keyboardType: TextInputType.visiblePassword,
          validator: (String value) {
            if (value.isEmpty) {
              return 'Password is Required';
            }

            return null;
          },
          onChanged: (String value) {
            setState(() {
              password2 = value;
            });
          },
        ),
      ],
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green.shade50,
      appBar: AppBar(title: Text('Register as a NGO'),backgroundColor: Colors.deepOrange.shade300,),
      body: SingleChildScrollView(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: Colors.black)
                      ),
                  child: Column(
                    children: [
                      Text('Fill All Details Carefully',style: TextStyle(color: Colors.black,fontSize: 20),),
                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            _buildName(),
                            _buildDescription(),
                            _buildimageUrl(),
                            _buildPassword(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                    Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(color: Colors.black)
                        ),
                      child: Column(
                        children: [
                          TextFormField(
                            decoration: InputDecoration(
                                labelText: 'Field NGO working in'
                            ),
                            validator: (value){
                              if(location.isEmpty)
                              {
                                return 'Field is required';
                              }
                              return null;
                            },
                            onChanged: (value){
                              setState(() {
                                field1=value;
                              });
                            },
                          ),
                          Container(decoration: BoxDecoration(
                              color: Colors.green.shade200,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.black)
                          ),
                              child: FlatButton(onPressed: (){
                                setState(() {
                                  print(field1);
                                  Field f=new Field(fieldName: field1);
                                  if(field1!=null || field1!='')
                                  {
                                    field.add(f);
                                  }
                                });
                              }, child: Text('Add Field',style: TextStyle(fontSize: 10),))),
                          Container(
                              child: Column(
                                children: [
                                  Text('Added Fields'),
                                  field==null?Container():ListView.builder(itemBuilder: (context,index){
                                    return ListTile(title: Text(field[index].fieldName),leading: Text((index+1).toString()),trailing: IconButton(icon: Icon(Icons.delete,color: Colors.red,),),onTap: (){
                                      setState(() {
                                        field.removeAt(index);
                                      });
                                    },);
                                  },itemCount: field.length,scrollDirection: Axis.vertical,shrinkWrap: true,)
                                ],
                              )),
                        ],
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: Colors.black)
                      ),
                      child: Column(
                        children: [
                          TextFormField(
                            decoration: InputDecoration(
                                labelText: 'City'
                            ),
                            validator: (value){
                              if(location.isEmpty)
                              {
                                return 'City is required';
                              }
                              return null;
                            },
                            onChanged: (value){
                              setState(() {
                                this.city=value;
                              });
                            },
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                                labelText: 'Address'
                            ),
                            validator: (value){
                              if(location.isEmpty)
                              {
                                return 'Address is required';
                              }
                              return null;
                            },
                            onChanged: (value){
                              setState(() {
                                this.address=value;
                              });
                            },
                          ),
                          Container(decoration: BoxDecoration(
                              color: Colors.green.shade200,
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(color: Colors.black)
                          ),
                              child: FlatButton(onPressed: (){
                                setState(() {
                                  print(city);
                                  Location l= new Location(city: city,address: address);
                                  location.add(l);
                                });
                              }, child: Text('Add Location',style: TextStyle(fontSize: 10),))),
                          Container(
                              child: Column(
                                children: [
                                  Text('Added Locations'),
                                  location==null?Container():ListView.builder(itemBuilder: (context,index){
                                    return ListTile(title: Column(
                                      children: [
                                        Text(location[index].city),
                                        Text(location[index].address)
                                      ],
                                    ),leading: Text((index+1).toString()),trailing: IconButton(icon: Icon(Icons.delete,color: Colors.red,),),onTap: (){
                                      setState(() {
                                        location.removeAt(index);
                                      });
                                    },);
                                  },itemCount: location.length,scrollDirection: Axis.vertical,shrinkWrap: true,)
                                ],
                              )),
                        ],
                      ),
                    ),
                    Container(
                      child: RaisedButton(
                        disabledColor: Colors.grey.shade700,
                        child: Text('Submit Application',style: TextStyle(color: Colors.white,),),
                        onPressed: (){
                          if (!_formKey.currentState.validate()) {
                            return;
                          }
                          else
                            {
                              String id;
                              id='NG'+UniqueKey().toString();
                              NGO ngo = NGO(NGOId: id,name: name,location: location,field: field,password: password,description: description,imageUrl: imageUrl);
                              var servie = ApplicationService();
                              servie.NGOApplications(ngo);
                              Fluttertoast.showToast(
                                  msg: "Application Submitted",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.CENTER,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.green,
                                  textColor: Colors.white,
                                  fontSize: 16.0
                              );
                              Navigator.pop(context);
                            }
                        },
                      ),
                    )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
