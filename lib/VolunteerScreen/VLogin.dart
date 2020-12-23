import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:volunteerstage/Model/Volunteer.dart';
import 'package:volunteerstage/Service/ApplicationService.dart';
import 'package:volunteerstage/VolunteerScreen/ViewNGO.dart';
import 'package:volunteerstage/VolunteerScreen/VolunteerForm.dart';

class VLogin extends StatefulWidget {
  @override
  _VLoginState createState() => _VLoginState();
}

class _VLoginState extends State<VLogin> {
  String checkPassword;
  String email;
  final GlobalKey<FormState> _formKey2 = GlobalKey<FormState>();
  Widget _getPassword() {
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
          onChanged: (String value) {
            setState(() {
              this.checkPassword = value;
            });
          },
        ),
      ],
    );
  }
  Widget _getEmail() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Email'),
      validator: (String value) {
        if (value.isEmpty) {
          return 'Email is Required';
        }
        if (!RegExp(
            r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
            .hasMatch(value)) {
          return 'Please enter a valid email Address';
        }

        return null;
      },
      onChanged: (String value) {
        setState(() {
          email = value;
        });
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Card(
                    color: Colors.purple.shade50,
                    child: Text('You can study government and politics in school, but the best way to really understand the process is to volunteer your time. -Rob McKenna'
                ,style: TextStyle(color: Colors.black,fontSize: 15),),
                  ),
                  SizedBox(height: 15,),
                  Text('Welcome',style: TextStyle(color: Colors.purple,fontSize: 30,fontWeight: FontWeight.bold),),
                  Text('Login Here',style: TextStyle(color: Colors.purple,fontSize: 20),),
                  Form(key: _formKey2,child: Column(
                    children: [
                      _getEmail(),
                      _getPassword(),
                    ],
                  )),
                  FlatButton(onPressed: ()async{
                    if (!_formKey2.currentState.validate()) {
                      return;
                    }
                    else
                      {
                       var service=ApplicationService();
                       Volunteer v=await service.getVolunteer(email);
                       if(v==null)
                         {
                           Fluttertoast.showToast(
                               msg: "No Account Sign Up",
                               toastLength: Toast.LENGTH_SHORT,
                               gravity: ToastGravity.CENTER,
                               timeInSecForIosWeb: 1,
                               backgroundColor: Colors.red,
                               textColor: Colors.white,
                               fontSize: 16.0
                           );
                         }
                       else
                         {
                           if(v.password==checkPassword)
                             {
                               Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ViewNGO(email)));
                             }
                           else
                             {
                               Fluttertoast.showToast(
                                   msg: "Password/Email Wrong",
                                   toastLength: Toast.LENGTH_SHORT,
                                   gravity: ToastGravity.CENTER,
                                   timeInSecForIosWeb: 1,
                                   backgroundColor: Colors.red,
                                   textColor: Colors.white,
                                   fontSize: 16.0
                               );
                             }
                         }
                      }
                  }, child: Container(color: Colors.blue.shade200,child: Text('Login',style: TextStyle(color: Colors.black,fontSize: 20),))),
                  SizedBox(),
                  Text('or'),
                  FlatButton(onPressed: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>VolunteerForm()));
                  }, child: Text('Sign Up',style: TextStyle(fontSize: 20),))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
