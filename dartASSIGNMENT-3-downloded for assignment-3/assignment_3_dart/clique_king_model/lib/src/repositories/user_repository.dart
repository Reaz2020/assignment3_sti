import 'package:firedart/firedart.dart';
import 'package:meta/meta.dart';
import 'package:clique_king_model/src/models/user.dart';

@immutable
final class UserRepository {
  final Firestore store; // pass it in so it can be mocked.

  UserRepository({required this.store});

  // TODO: Create methods for managing users stored in Firebase Firestore.
  // With Firestore, you have the option to return data once, or return a stream which emits
  // data anytime data in the query changes.



    // Method to create a new user record in Firestore
Future<void> addUserToFirestore(User user) async {


 await Firestore.instance
        .collection("users")
        .document(user.id)
        .set(user.toJson()); // add user to users collection
        print('added user');
  } 




  //current loged in user er id nia shetate set korte hobe may be , ai document id na 
 /* try {
    final firestoreInstance = Firestore.instance;
    await firestoreInstance.collection('users').document(userId).set({
      'name': userName,
      'id': userId,
      // Add any other user data you want to store
    });
    print('User added to Firestore successfully.');
  } catch (e) {
    print('Error adding user to Firestore: $e');
  }
}
*/
}
