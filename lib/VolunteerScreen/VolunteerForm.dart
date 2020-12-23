import 'package:flutter/material.dart';
import 'package:volunteerstage/Model/Volunteer.dart';
import 'package:volunteerstage/Service/ApplicationService.dart';
import 'package:volunteerstage/VolunteerScreen/ViewNGO.dart';

class VolunteerForm extends StatefulWidget {
  @override
  _VolunteerFormState createState() => _VolunteerFormState();
}

class _VolunteerFormState extends State<VolunteerForm> {
  String volunteerId;
  String name;
  String age;
  String email;
  String occupation;
  String contactNumber;
  String password1;
  String password2;
  String checkPassword;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget _buildName() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Name'),
      maxLength: 20,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Name is Required';
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
  Widget _buildOccupation() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Occupation'),
      maxLength: 20,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Occupation is Required';
        }

        return null;
      },
      onChanged: (String value) {
        setState(() {
          occupation = value;
        });
      },
    );
  }
  Widget _buildEmail() {
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
              this.password1=value;
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



  Widget _buildAge() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Age'),
      keyboardType: TextInputType.number,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Age is Required';
        }

        return null;
      },
      onChanged: (String value) {
        setState(() {
          age = value;
        });
      },
    );
  }

  Widget _buildPhoneNumber() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Phone number'),
      keyboardType: TextInputType.phone,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Phone number is Required';
        }

        return null;
      },
      onChanged: (String value) {
        setState(() {
          contactNumber = value;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(50.0),
              child: Column(
                children: [
                  Text('Sign Up as a Volunteer',style: TextStyle(color: Colors.black,fontSize: 30),),
                  Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        _buildName(),
                        _buildEmail(),
                        _buildPhoneNumber(),
                        _buildAge(),
                        _buildOccupation(),
                        _buildPassword(),
                        SizedBox(height: 20),
                        RaisedButton(
                          child: Text(
                            'Sign Up',
                            style: TextStyle(color: Colors.blue, fontSize: 16),
                          ),
                          onPressed: () {
                            if (!_formKey.currentState.validate()) {
                              return;
                            }
                            else
                            {
                              if(password1!=password2)
                              {
                               return;
                              }
                              print(name);
                              print(age);
                              Volunteer volunteer = Volunteer(name: name,email: email,volunteerId: email,password: password1,age: age,occupation: occupation,contactNumber: contactNumber);
                              volunteerId=email;
                              var service = ApplicationService();
                              service.SaveVolunteer(volunteer);
                              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ViewNGO(volunteerId)));
                            }
                            _formKey.currentState.save();
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
