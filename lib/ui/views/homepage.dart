import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../dummy_book_catList.dart';
import '../widgets/custom_chip_button.dart';
import '../widgets/slider_image.dart';

class HomeExplorePage extends StatelessWidget {
  const HomeExplorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                child: Row(
                  children: [
                    const Expanded(
                        child: Icon(
                      Icons.widgets,
                      color: Colors.red,
                    )),
                    const Expanded(
                        flex: 10,
                        child: Center(
                          child: Text(
                            "Explore",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                            ),
                          ),
                        )),
                    Expanded(
                      flex: 3,
                      child: Row(
                        children: const [
                          Icon(
                            Icons.favorite_border,
                            size: 30,
                            color: Colors.black,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          CircleAvatar(
                            radius: 18,
                            backgroundImage: NetworkImage(
                                "https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8dXNlciUyMHByb2ZpbGV8ZW58MHx8MHx8&w=1000&q=80"),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              const HomeSeachFilter(),
              const SizedBox(
                height: 5,
              ),
              const SecondImage(
                  images: ["assets/banner1.jpg", "assets/banner2.jpg"]),
              Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: const Text(
                  "Explore Books to looks",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                      fontFamily: "Helvetica"),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              categorysection(BookList.bookList),
              const BazarRow(
                id: "1",
                text: "New Arrivals",
              ),
              SizedBox(
                height: 250,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: 5,
                  itemBuilder: (context, int1) {
                    return const homeProductcard(
                      bookcategory: "Advanture",
                    );
                  },
                ),
              ),
              const BazarRow(
                id: "1",
                text: "Book on Exchange",
              ),
              SizedBox(
                height: 250,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: 5,
                  itemBuilder: (context, int1) {
                    return const homeProductcard(
                      bookcategory: "Collage Study",
                    );
                  },
                ),
              ),
              const BazarRow(
                id: "1",
                text: "Second hand on Sale",
              ),
              SizedBox(
                height: 250,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: 5,
                  itemBuilder: (context, int1) {
                    return const homeProductcard(
                      bookcategory: "Thiller",
                    );
                  },
                ),
              ),
              const BazarRow(
                id: "1",
                text: "Recommended For you ",
              ),
              GridView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 300,
                      childAspectRatio: 4 / 5,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10),
                  itemCount: 10,
                  itemBuilder: (BuildContext ctx, index) {
                    return const homeProductcard(
                      bookcategory: "Science Friction",
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }
}

class homeProductcard extends StatelessWidget {
  final String bookcategory;
  const homeProductcard({
    Key? key,
    required this.bookcategory,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {},
        child: Container(
            // height: 200,
            margin: EdgeInsets.only(right: 5),
            child: Container(
              width: 165,
              margin: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: CachedNetworkImage(
                            imageUrl: 'https://picsum.photos/500/600',
                            height: 150,
                            width: 195,
                            fit: BoxFit.cover,
                            placeholder: (context, url) => Container(
                              color: Colors.black,
                            ),
                          )),
                      Container(
                          decoration: BoxDecoration(
                            color: Colors.red[400],
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(5),
                              bottomRight: Radius.circular(5),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(bookcategory,
                                style: const TextStyle(
                                  color: Colors.white,
                                )),
                          ))
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: Container(
                          margin: const EdgeInsets.symmetric(vertical: 6),
                          child: const Text(
                            "full metal alkamist",
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.black54),
                          ),
                        ),
                      ),
                      const Expanded(
                        child: Icon(
                          Icons.favorite_border,
                          size: 25,
                          color: Colors.black54,
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: const [
                      Text(
                        "RS 135",
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 14, color: Colors.black54),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "-Like new",
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 7,
                  ),
                  Row(
                    children: const [
                      CircleAvatar(
                        radius: 10,
                        backgroundImage: NetworkImage(
                            "https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8dXNlciUyMHByb2ZpbGV8ZW58MHx8MHx8&w=1000&q=80"),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Saugat pudasaini",
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            )));
  }
}

class HomeSeachFilter extends StatelessWidget {
  const HomeSeachFilter({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Row(
        children: [
          const Expanded(
            flex: 6,
            child: SizedBox(
              height: 50,
              child: TextField(
                decoration: InputDecoration(
                  suffixIcon: Icon(
                    Icons.search,
                    color: Colors.black45,
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                    borderSide: BorderSide(width: 1, color: Colors.red),
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                    borderSide: BorderSide(width: 1, color: Colors.black),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                    borderSide: BorderSide(width: 1, color: Colors.black54),
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                      borderSide: BorderSide(
                        width: 1,
                      )),
                  errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                      borderSide: BorderSide(width: 1, color: Colors.black)),
                  focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                      borderSide:
                          BorderSide(width: 1, color: Colors.yellowAccent)),
                  hintText: "Search...",
                  hintStyle: TextStyle(fontSize: 16, color: Color(0xFFB3B1B1)),
                ),
                obscureText: false,
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.red,
              ),
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(
                  Icons.filter_list,
                  color: Colors.white,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

Widget categorysection(List<String> categories) {
  if (categories.isEmpty) {
    return const Center(child: Text("No Categories"));
  }

  return Container(
    margin: const EdgeInsets.only(bottom: 10.0, left: 10),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 168.0,
          child: GridView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 0),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, mainAxisSpacing: 18),
              itemCount: categories.length,
              primary: false,
              shrinkWrap: true,
              itemBuilder: (BuildContext ctx, index) {
                return customChipButton(
                  name: (categories[index].length > 10)
                      ? categories[index].split(' ')
                      : [categories[index]],
                );
              }),
        ),
      ],
    ),
  );
}

class BazarRow extends StatelessWidget {
  final String text;
  final String id;
  const BazarRow({required this.text, required this.id});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 15, top: 10, bottom: 8.0, right: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text,
            style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
                fontFamily: "Helvetica"),
          ),
          const SizedBox(),
          TextButton(
            onPressed: () {},
            child: const Padding(
              padding: EdgeInsets.only(bottom: 5.0),
              child: Text(
                "SEE ALL >",
                style: TextStyle(
                  color: Colors.black45,
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
