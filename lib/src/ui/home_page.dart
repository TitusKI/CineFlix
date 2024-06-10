import 'package:cineflix/src/common/values/colors.dart';
import 'package:cineflix/src/ui/widgets/carousel_container.dart';
import 'package:cineflix/src/ui/widgets/movie_show_home_card.dart';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

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
  void dispose() {
    Hive.box('itemBox');
    super.dispose();
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
            borderSide: BorderSide(width: 5.0, color: AppColors.primaryElement),
            insets: EdgeInsets.symmetric(horizontal: 20.0),
          ),
          tabs: const [
            Tab(
              child: Text(
                "Movies",
                style: TextStyle(color: AppColors.primaryElement, fontSize: 20),
              ),
            ),
            Tab(
              child: Text(
                "Tv Shows",
                style: TextStyle(color: AppColors.primaryElement, fontSize: 20),
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
                MovieShowHomeCard(
                  categoryId: 1,
                  mediaId: 1,
                  title: "Popular Movies",
                ),
                MovieShowHomeCard(
                  categoryId: 2,
                  mediaId: 1,
                  title: "Top Rated",
                ),
                MovieShowHomeCard(
                  categoryId: 3,
                  mediaId: 1,
                  title: "Now Playing",
                ),
                MovieShowHomeCard(
                  categoryId: 4,
                  mediaId: 1,
                  title: "Upcoming",
                ),
              ]),
              CarouselContainer(carouselList: [
                MovieShowHomeCard(
                  categoryId: 1,
                  mediaId: 2,
                  title: "Popular Shows",
                ),
                MovieShowHomeCard(
                  categoryId: 2,
                  mediaId: 2,
                  title: "Airing Today",
                ),
                MovieShowHomeCard(
                  categoryId: 3,
                  mediaId: 2,
                  title: "Top Rated",
                ),
                MovieShowHomeCard(
                  categoryId: 4,
                  mediaId: 2,
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
