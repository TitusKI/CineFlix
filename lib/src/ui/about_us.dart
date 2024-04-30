import 'package:cineflix/src/common/values/colors.dart';
import 'package:flutter/material.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About Cineflix'),
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome to Cineflix - Your Ultimate Destination for Movies and Shows!',
              style: TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryElement),
            ),
            SizedBox(height: 20.0),
            Text(
              'At Cineflix, we\'re passionately dedicated bringing the magic of cinema and television to your fingertips. With an extensive collection of movies and shows spanning various genres, languages, and cultures, we strive to cater to the diverse tastes of our global audience.',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 20.0),
            Text(
              'Our Mission',
              style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryElement),
            ),
            SizedBox(height: 10.0),
            Text(
              'Our mission at Cineflix is to redefine the entertainment experience by providing unparalleled access to the world of movies and shows. We aim to:',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 10.0),
            Text(
              '- Inspire: Spark your imagination and ignite your passion for storytelling.',
              style: TextStyle(fontSize: 16.0),
            ),
            Text(
              '- Entertain: Delight you with a vast library of blockbuster hits, timeless classics, and binge-worthy series.',
              style: TextStyle(fontSize: 16.0),
            ),
            Text(
              '- Connect: Bring people together through shared experiences and unforgettable moments.',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 20.0),
            Text(
              'Why Choose Cineflix?',
              style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryElement),
            ),
            SizedBox(height: 10.0),
            Text(
              'Extensive Library!',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10.0),
            Text(
              'Discover an endless array of movies and shows, ranging from Hollywood blockbusters to indie gems, from gripping dramas to side-splitting comedies. Whether you\'re a cinephile, a TV buff, or simply looking for something new to watch, Cineflix has something for everyone.',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 10.0),
            Text(
              'Seamless Experience!',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10.0),
            Text(
              'Enjoy a seamless and user-friendly experience across all your devices. Whether you\'re streaming on your smartphone, tablet, or smart TV, Cineflix adapts to your screen size and resolution, ensuring optimal viewing pleasure anytime, anywhere.',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 10.0),
            Text(
              'Get Started Today!',
              style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryElement),
            ),
            SizedBox(height: 10.0),
            Text(
              'Join Team 4 who have made Cineflix their go-to destination for entertainment. Download the Cineflix app now and start streaming your favorite movies and shows in stunning HD quality.',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 20.0),
            Text(
              'Experience the magic of cinema and television like never before with Cineflix. Your journey to endless entertainment begins here!',
              style: TextStyle(fontSize: 16.0),
            ),
          ],
        ),
      ),
    );
  }
}
