class Volunteer {
  String volunteerId;
  String name;
  String age;
  String email;
  String occupation;
  String contactNumber;
  String password;

  Volunteer({this.contactNumber,this.name, this.age, this.email, this.occupation, this.password,this.volunteerId});

  Map<String,dynamic> toMap(){
    return {
      'volunteerId':volunteerId,
      'name':name,
      'age':age,
      'email':email,
      'occupation':occupation,
      'password':password,
      'contactNumber':contactNumber
    };
  }

  Volunteer.fromFirestore(Map<String,dynamic> firestore)
      : name = firestore['name'],
        volunteerId = firestore['volunteerId'],
        age = firestore['age'],
        email = firestore['email'],
        occupation = firestore['occupation'],
        password = firestore['password'],
        contactNumber = firestore['contactNumber'];
}