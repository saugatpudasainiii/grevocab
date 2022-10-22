import 'package:bookstolook/ui/widgets/ClickCircle.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class SecondImage extends StatefulWidget {
  final List<String> images;
  const SecondImage({super.key, required this.images});
  @override
  // ignore: library_private_types_in_public_api
  _SecondImageState createState() => _SecondImageState();
}

int imagelikeindex = 0;
CarouselSlider? carouselSlider;

class _SecondImageState extends State<SecondImage> {
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
        margin: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
        width: double.infinity,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child: CarouselSlider(
            options: CarouselOptions(
              onPageChanged: (index, reason) {
                setState(() {
                  imagelikeindex = index;
                });
              },
              viewportFraction: 1,
              height: 155,
              autoPlay: true,
              enableInfiniteScroll: true,
              autoPlayAnimationDuration: const Duration(milliseconds: 800),
            ),
            items: widget.images.map((e) {
              return Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage(
                      e.toString(),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ),
      Positioned(
        top: 120,
        right: 180,
        child: Row(
          children: widget.images.map<Widget>((url) {
            int index = widget.images.indexOf(url);
            return Container(
                margin:
                    const EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                child: imagelikeindex == index
                    ? const ClickCircle()
                    : const SimpleCirsle());
          }).toList(),
        ),
      ),
    ]);
  }
}
