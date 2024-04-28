import 'package:cineflix/src/blocs/movies_detail_bloc_provider.dart';
import 'package:cineflix/src/common/services/cloud_services.dart';
import 'package:cineflix/src/common/values/colors.dart';
import 'package:cineflix/src/models/item_model.dart';
import 'package:cineflix/src/models/people_model.dart';
import 'package:cineflix/src/pages/common_widgets.dart';
import 'package:cineflix/src/resources/people_api_provider.dart';
import 'package:cineflix/src/ui/item_navigation.dart';
import 'package:cineflix/src/ui/movie_detail.dart';
import 'package:cineflix/src/ui/star_rating.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  FavoriteServices favoriteServices = FavoriteServices();
  String? _userEmail;
  @override
  void initState() {
    super.initState();
    // Fetch username when the drawer is initialized
    fetchUsername();
  }

  Future<void> fetchUsername() async {
    String? userEmail = FirebaseAuth.instance.currentUser?.email;
    if (_userEmail != null) {
      DocumentSnapshot userData = await FirebaseFirestore.instance
          .collection('users')
          .doc(userEmail)
          .get();
      setState(() {
        _userEmail = userData.get('email');
      });
    }
  }

  buildFavoriteList(snapshot) {
    PeopleApiProvider pplApi = PeopleApiProvider();
    late List<Person> cast;
    List favoriteList = snapshot.data!.docs;
    print(favoriteList);
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
          print("Image : $imageUrl");

          String title = data['title'] ?? " ";
          print("title: $title");
          String date = data['date'] ?? " ";
          print('date: $date');

          double rating = data['rating'] ?? " ";
          print('rating: $rating');
          String description = data['description'] ?? " ";
          print('description: $description');
          return Column(
            children: [
              ListTile(
                onTap: () async {
                  cast = await pplApi
                      .fetchPeople(snapshot.data!.results[index].id);
                  openDetailPage(
                    context,
                    snapshot.data as ItemModel?,
                    cast,
                    index,
                  );
                },
                title: AspectRatio(
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
                trailing: Container(
                  padding: const EdgeInsets.all(4.0),
                  alignment: Alignment.topCenter,
                  width: 150,
                  height: 400, // Adjust the width as needed
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
              ),
              const SizedBox(
                height: 10,
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: favoriteServices.getRetriveData(_userEmail),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
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
              child: Text('No favorite avaliable'),
            );
          }

          return const Center(child: CircularProgressIndicator());
        });
  }
}
