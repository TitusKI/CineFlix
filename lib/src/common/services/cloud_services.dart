import 'package:cineflix/src/models/item_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FavoriteServices {
  final CollectionReference moviesCollection =
      FirebaseFirestore.instance.collection("favorite");
  ItemModel? itemModel;

  Future<void> addFavorite(itemModel, int index) async {
    var moviesModel = itemModel.results[index];
    try {
      await moviesCollection.doc(moviesModel.id.toString()).set({
        'imageUrl': moviesModel.poster_path,
        'title': moviesModel.title,
        'date': moviesModel.release_date,
        'rating': moviesModel.vote_average,
        'timestamp': Timestamp.now(),
      });
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> deleteFavorite(int id) {
    return moviesCollection.doc(id.toString()).delete();
  }

  Stream<QuerySnapshot> getRetriveData() {
    final favoriteStream =
        moviesCollection.orderBy('timestamp', descending: true).snapshots();
    return favoriteStream;
  }
}
