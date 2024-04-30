import 'package:cineflix/src/models/item_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FavoriteServices {
  final String? _userEmail = FirebaseAuth.instance.currentUser!.email;
  late CollectionReference myCollection = FirebaseFirestore.instance
      .collection('UsersWithFavorite')
      .doc(_userEmail)
      .collection('favorite');
  // // final DocumentReference myCollectionDoc = myCollection.doc(_userEmail);
  // final CollectionReference moviesCollection = FirebaseFireStore.instance.collection("favorite");
  // ItemModel? itemModel;

  Future<void> addFavorite(ItemModel? itemModel, int index) async {
    var moviesModel = itemModel!.results[index];
    try {
      await myCollection.doc(moviesModel.id.toString()).set({
        'imageUrl': moviesModel.poster_path,
        'title': moviesModel.title,
        'date': moviesModel.release_date,
        'rating': moviesModel.vote_average,
        'description': moviesModel.overview,
        'timestamp': Timestamp.now(),
      });
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> deleteFavorite(int? id) {
    return myCollection.doc(id.toString()).delete();
  }

  Stream<QuerySnapshot> getRetriveData(String? email) {
    final favoriteStream =
        myCollection.orderBy('timestamp', descending: true).snapshots();

    favoriteStream.listen((QuerySnapshot snapshot) {
      snapshot.docs.forEach((DocumentSnapshot document) {
        // Access the data inside each document
        print('Document ID: ${document.id}');
        Map<String, dynamic> data = document.data() as Map<String, dynamic>;
        print('Data: $data');
      });
    });

    return favoriteStream;
  }

  // Stream<QuerySnapshot> getRetriveData(String? email) {
  //   // if (email == myCollection.doc(_userEmail).toString()) {
  //   final favoriteStream = myCollection
  //       .doc(email)
  //       .collection('favortie')
  //       .orderBy('timestamp', descending: true)
  //       .snapshots();

  //   print("favorite Data list : ${favoriteStream.toList()}");
  //   return favoriteStream;
  //   // } else {
  //   //   return const Stream.empty();
  //   // }
  // }
}
