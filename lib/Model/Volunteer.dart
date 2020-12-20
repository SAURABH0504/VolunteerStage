class Volunteer{

  String volunteerId;
  String name;
  String age;
  String email;
  String occupation;
  String address;
  String imageUrl;

  Volunteer({this.name, this.age, this.email, this.occupation, this.address,this.imageUrl,this.volunteerId});

  Map<String,dynamic> toMap(){
    return {
      'volunteerId':volunteerId,
      'name':name,
      'age':age,
      'email':email,
      'occupation':occupation,
      'address':address,
      'imageUrl':imageUrl
    };
  }

  Volunteer.fromFirestore(Map<String,dynamic> firestore)
      : name = firestore['name'],
        volunteerId = firestore['volunteerId'],
        age = firestore['age'],
        email = firestore['email'],
        occupation = firestore['occupation'],
        address = firestore['address'],
        imageUrl = firestore['imageUrl'];
}