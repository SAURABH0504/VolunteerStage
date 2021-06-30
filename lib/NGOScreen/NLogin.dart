import 'package:flutter/material.dart';
import 'package:volunteerstage/NGOScreen/NGOApplications.dart';
import 'package:volunteerstage/NGOScreen/NGORegister.dart';
import 'package:volunteerstage/Service/ApplicationService.dart';

class NLogin extends StatefulWidget {
  @override
  _NLoginState createState() => _NLoginState();
}

class _NLoginState extends State<NLogin> {
  String checkPassword;
  String ngoId;
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
  Widget _getNGOId() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Company ID'),
      validator: (String value) {
        if (value.isEmpty) {
          return 'Company ID is Required';
        }
        return null;
      },
      onChanged: (String value) {
        setState(() {
          ngoId = value;
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
                    child: Text('He who wished to secure the good of others Has already secured his own. - Confucius',style: TextStyle(color: Colors.black,fontSize: 15),),
                  ),
                  SizedBox(height: 15,),
                  Text('Welcome',style: TextStyle(color: Colors.purple,fontSize: 30,fontWeight: FontWeight.bold),),
                  Text('Login Here',style: TextStyle(color: Colors.purple,fontSize: 20),),
                  Form(key: _formKey2,child: Column(
                    children: [
                      _getNGOId(),
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
                      var ngo=await service.getNGO(ngoId);
                      if(ngo.password==checkPassword)
                        {
                          Navigator.of(context).push(MaterialPageRoute(builder: (context)=>NGOApplications(ngoId)));
                        }
                    }
                  }, child: Container(color: Colors.blue.shade200,child: Text('Login',style: TextStyle(color: Colors.black,fontSize: 20),))),
                  SizedBox(),
                  Text('or'),
                  FlatButton(onPressed: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>NGORegister()));
                  }, child: Text('Register Company',style: TextStyle(fontSize: 20),))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
