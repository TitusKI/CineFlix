import 'package:cineflix/src/models/item_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FavoriteServices {
  final CollectionReference moviesCollection =
      FirebaseFirestore.instance.collection("favorite");
  ItemModel? itemModel;

  Future<void> addFavorite(ItemModel itemModel, int index) async {
    var movie = itemModel.results[index];
    String? userEmail = FirebaseAuth.instance.currentUser?.email;
    if (userEmail != null) {
      try {
        await moviesCollection.doc(movie.id.toString()).set({
          'userEmail': userEmail,
          'imageUrl': movie.poster_path,
          'title': movie.title,
          'date': movie.release_date,
          'rating': movie.vote_average,
          'description': movie.overview,
          'timestamp': Timestamp.now(),
        });
      } catch (e) {
        print(e.toString());
      }
    }
  }

  Future<void> deleteFavorite(int? id) {
    return moviesCollection.doc(id.toString()).delete();
  }

  Stream<QuerySnapshot> getRetriveData(String? userEmail) {
    if (userEmail != null) {
      final favoriteStream = FirebaseFirestore.instance
          .collection('movies')
          .where('userEmail', isEqualTo: userEmail)
          .snapshots();
      return favoriteStream;
    } else {
      // Return an empty stream if userEmail is null
      return const Stream.empty();
    }
  }
}
