import 'package:cineflix/src/common/services/cloud_services.dart';
import 'package:cineflix/src/common/values/colors.dart';
import 'package:cineflix/src/models/people_model.dart';
import 'package:cineflix/src/pages/common_widgets.dart';
import 'package:cineflix/src/resources/people_api_provider.dart';
import 'package:cineflix/src/ui/item_navigation.dart';

import 'package:cineflix/src/ui/widgets/star_rating.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({
    super.key,
  });

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  FavoriteServices favoriteServices = FavoriteServices();
//   String? _userEmail;
//   @override
//   void initState() {
//     super.initState();
//     // Fetch username when the drawer is initialized
//     fetchUsername();
//   }

//   Future<void> fetchUsername() async {
//     String? userEmail = FirebaseAuth.instance.currentUser?.email;
//     if (_userEmail != null) {
//       DocumentSnapshot userData = await FirebaseFirestore.instance
//           .collection('users')
//           .doc(userEmail)
//           .get();
//       setState(() {
//         _userEmail = userData.get('email');
//       });
//     }
//   }

  buildFavoriteList(snapshot) {
    PeopleApiProvider pplApi = PeopleApiProvider();
    late List<Person> cast;
    List favoriteList = snapshot.data!.docs;
    // print("All snapshots: $snapshot");
    // print("List of favorite: $favoriteList");
    const Divider(
      color: AppColors.primarySecondaryElementText,
      thickness: 1.5,
    );
    return ListView.builder(
        itemCount: favoriteList.length,
        itemBuilder: (context, index) {
          DocumentSnapshot document = favoriteList[index];
          String favMovieId = document.id;

          Map<String, dynamic> data = document.data() as Map<String, dynamic>;
          String imageUrl = data['imageUrl'] ?? " ";
          print("Image: $imageUrl");

          String title = data['title'] ?? " ";
          print("title: $title");
          String date = data['date'] ?? " ";
          print('date: $date');

          double rating = data['rating'] ?? " ";
          print('rating: $rating');
          String description = data['description'] ?? " ";
          print('description: $description');
          return GestureDetector(
            onTap: () async {
              print('All snapshots are : $snapshot');
              cast =
                  await pplApi.fetchPeople(snapshot.data!.results[index].id, 2);
              print('All Data : ${snapshot.data!.results[index]}');
              openDetailPage(
                context,
                snapshot.data,
                cast,
                index,
              );
            },
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 5),
              color: Colors.black,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: AspectRatio(
                      aspectRatio: 2 / 3,
                      child: Image(
                        alignment: Alignment.bottomCenter,
                        fit: BoxFit.contain,
                        image: NetworkImage(
                          'https://image.tmdb.org/t/p/w500$imageUrl',
                          // scale: 5.0,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(4.0),
                    alignment: Alignment.topCenter,
                    width: 200,
                    // height: 300, // Adjust the width as needed
                    child: Wrap(
                      // mainAxisAlignment: MainAxisAlignment.start,
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      // mainAxisSize: MainAxisSize.min, // Use min instead of max
                      children: [
                        Text(
                          title,
                          textAlign: TextAlign.justify,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        reusableText(date),
                        StarRating(voteAverage: rating),
                        Text(
                          maxLines: 5,
                          description,
                          style: const TextStyle(
                              fontSize: 14,
                              textBaseline: TextBaseline.ideographic,
                              overflow: TextOverflow.ellipsis),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: favoriteServices
            .getRetriveData(FirebaseAuth.instance.currentUser?.email),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            print("Built the snapshot");
            return buildFavoriteList(snapshot);
          } else if (snapshot.connectionState == ConnectionState.none ||
              snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
                child: SpinKitCubeGrid(
              color: Colors.red,
              size: 60.0,
            ));
          } else if (snapshot.connectionState == ConnectionState.done) {
            return const Center(
              child: Text('No favorite avaliable.'),
            );
          }

          return const Center(child: CircularProgressIndicator());
        });
  }
}
