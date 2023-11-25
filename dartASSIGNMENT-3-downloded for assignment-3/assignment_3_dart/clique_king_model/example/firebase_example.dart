import 'dart:ffi';
import 'dart:io';
import 'dart:js_util';


import 'package:clique_king_model/clique_king_model.dart';
import 'package:clique_king_model/src/models/user.dart';
import 'package:firedart/auth/user_gateway.dart' as auth;
import 'package:firedart/firedart.dart';
import 'package:dotenv/dotenv.dart';

void main() async {
  final env = DotEnv(includePlatformEnvironment: true)..load();
  String? apiKey = env['FIREBASE_API_KEY'];
  String? projectId = env['FIREBASE_PROJECT_ID'];

  if (apiKey == null) {
    print("FIREBASE_API_KEY missing from .env file");
    exit(0);
  }

  if (projectId == null) {
    print("FIREBASE_PROJECT_ID missing from .env file");
    exit(0);
  }

  FirebaseAuth.initialize( //firebase auth initialize korar jonno amake ai hive dite hobe r hive init korar jonno ai method k dak disi, ja ase
  //hiveStore class e , hive store class e amra hive k init koresi, r box open koresi nicher method er maddhome 
      apiKey, await HiveStore.create(path: Directory.current.path));

  Firestore.initialize(projectId);

  AuthenticationRepository repository =
      AuthenticationRepository(auth: FirebaseAuth.instance);

  late User user;
  Firestore store = Firestore.instance; 

  try {
    user = await repository.signUp(
        "name444", "name@boNEW.KAGUusingmethod***********.com", "abc1234!"); // signing up also signs in

     /*UserRepository urepo = UserRepository(store: store);
     urepo.addUserToFirestore(user);*/

   await Firestore.instance
        .collection("users")
        .document(user.id)
        .set(user.toJson()); // add user to users collection
        print('added user');
  } catch (e) {
    print(e);

  }


    FirebaseAuth.instance.signInState.listen((event) {
   // print(event); // this one only prints when we add new user 
   
  });

  if (!FirebaseAuth.instance.isSignedIn) {
    final success = await repository.signIn("name@boom2.com", "abc1234!"); //this user not added yet 
    print("signed in: $success");
  }
  //-------------------------*************               ***********



  

  final userCollection = Firestore.instance.collection("users");
    // Query all user documents
  final querySnapshot = await userCollection.get();
  // Store user scores 
  querySnapshot[0];//
  print(querySnapshot.length);
  //print(querySnapshot[0]);
  for (var i = 0; i < querySnapshot.length; i++) {
    var v =querySnapshot[i].toString();
    // Split the string by space
  final splitted = v.split(' ');
  
  print(splitted[0]); // Prints the first part of the split string user id 
  // Iterate through the split string
  
  for (var i = 0; i < splitted.length; i++) {
    if (splitted[i] == '{score:' || splitted[i] == 'score:' ) {
      // Extract the value associated with 'score:' and remove non-numeric characters
     
      var scoreString = splitted[i + 1].replaceAll(RegExp(r"\D"), ""); // akhane may b prob
      
      // Convert the extracted string to an int
      try {
        var scoreValue = int.parse(scoreString);
        print(scoreValue);
      } catch (e) {
        print("Error: Unable to convert to int");
      }
    }
  }

  }

 print('');


 
 
 
 
 print('query snapshot **************************************************************************');
 //--------------------------**********************             *******************************

  Firestore.instance.collection("users").stream.listen((event) {
    //print(event); // get all users when the users collection changes
     //print('event printed here it dosnt print any user.... ');
  });

  final currentUser = await FirebaseAuth.instance.getUser();

  final document = await Firestore.instance
      .collection("users")
      .document(currentUser.id)
      .get();

  Firestore.instance.collection("users").document(document.id).stream.listen(
    (event) {
     // print({"yooo", event});
    },
  ); 

  //await Firestore.instance.collection("users").document(document.id).delete();
  await Firestore.instance.collection("users").document(document.id).set({ "nam":'eee',"score": 300});// it will change all the data to only score : 300

 // trying to create a subcollection of my users user  with same user
  Firestore.instance.collection("users").document(document.id).collection('sub2222').document('1212121212').set({
    'user id':1
  });
  
  print(document.id);
 

//await Firestore.instance.collection("users").document(document.id).update({"name": "new name-----00009090"});
print('***********************************************************');

  var exists = await Firestore.instance.collection("users").document(document.id).exists;
       
  if (!exists) {
    await FirebaseAuth.instance.deleteAccount();
  }
  await Future.delayed(Duration(seconds: 1));






 

  exit(255);



  
}



