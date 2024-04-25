import 'package:cineflix/src/ui/widgets/carousel_container.dart';
import 'package:cineflix/src/ui/widgets/movie-show_carousell.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    // _tabController.addListener(_handleTabSelection);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        TabBar(
          dividerColor: Colors.transparent,
          indicator: const UnderlineTabIndicator(
            borderSide: BorderSide(
                width: 4.0,
                color: Colors.red), // Customize the indicator width and color
            insets: EdgeInsets.symmetric(
                horizontal: 16.0), // Adjust the indicator padding
          ),
          tabs: const [
            Tab(
              child: Text(
                "Movies",
                style: TextStyle(color: Colors.red, fontSize: 20),
              ),
            ),
            Tab(
              child: Text(
                "Tv Shows",
                style: TextStyle(color: Colors.red, fontSize: 20),
              ),
            ),
          ],
          controller: _tabController,
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: const [
              CarouselContainer(carouselList: [
                MovieShowCarousel(
                  categoryId: 1,
                  mediaId: 1,
                  title: "Popular Movies",
                ),
                MovieShowCarousel(
                  categoryId: 2,
                  mediaId: 1,
                  title: "Upcoming Movies",
                ),
                MovieShowCarousel(
                  categoryId: 3,
                  mediaId: 1,
                  title: "Top Rated",
                ),
                MovieShowCarousel(
                  categoryId: 4,
                  mediaId: 1,
                  title: "Now Playing",
                ),
              ]),
              CarouselContainer(carouselList: [
                MovieShowCarousel(
                  categoryId: 1,
                  mediaId: 2,
                  title: "Popular Shows",
                ),
                MovieShowCarousel(
                  categoryId: 2,
                  mediaId: 2,
                  title: "Airing Today",
                ),
                MovieShowCarousel(
                  categoryId: 2,
                  mediaId: 3,
                  title: "Top Rated",
                ),
                MovieShowCarousel(
                  categoryId: 2,
                  mediaId: 4,
                  title: "On Tv",
                ),
              ]),
            ],
          ),
        ),
      ],
    );
  }
}
