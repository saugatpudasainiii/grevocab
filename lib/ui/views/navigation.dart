import 'package:bookstolook/ui/views/exhange.dart';
import 'package:bookstolook/ui/views/profile.dart';
import 'package:bookstolook/ui/views/secondHand_bookuy.dart';
import 'package:flutter/material.dart';
import 'homepage.dart';
import 'newBook_bazar.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int selectedIndex = 0;

  final screens = const [
    HomeExplorePage(),
    ExchangePage(),
    SecondHandBook(),
    NewBookBazar(),
    MyProfile()
  ];

  @override
  Widget build(BuildContext context) {
    Future<bool> showExitPopup() async {
      return await showDialog(
            //show confirm dialogue
            //the return value will be from "Yes" or "No" options
            context: context,
            builder: (context) => AlertDialog(
              content: const Text('Do you want to exit an App?'),
              actions: [
                ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  //return false when click on "NO"
                  child: const Text('No'),
                ),
                ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  //return true when click on "Yes"
                  child: const Text('Yes'),
                ),
              ],
            ),
          ) ??
          false; //if showDialouge had returned null, then return false
    }

    return WillPopScope(
        onWillPop: showExitPopup,
        child: Scaffold(
          body: IndexedStack(
            index: selectedIndex,
            children: screens,
          ),
          bottomNavigationBar: NavigationBarTheme(
            data: const NavigationBarThemeData(
              indicatorColor: Colors.white,
            ),
            child: NavigationBar(
              height: 60,
              selectedIndex: selectedIndex,
              onDestinationSelected: (index) =>
                  {setState(() => selectedIndex = index)},
              backgroundColor: Colors.white,
              destinations: [
                NavigationDestination(
                  icon: Icon(Icons.search,
                      size: 30,
                      color:
                          selectedIndex == 0 ? Colors.black : Colors.black45),
                  label: 'EXPLORE',
                ),
                NavigationDestination(
                    icon: Icon(Icons.group,
                        size: 30,
                        color:
                            selectedIndex == 1 ? Colors.black : Colors.black45),
                    label: 'EXCHANGE'),
                const NavigationDestination(
                    icon: Icon(Icons.add_box, size: 30, color: Colors.red),
                    label: 'ADD BOOKS'),
                NavigationDestination(
                    icon: Icon(Icons.menu_book,
                        size: 30,
                        color:
                            selectedIndex == 3 ? Colors.black : Colors.black45),
                    label: 'OLDBOOKS'),
                NavigationDestination(
                    icon: Icon(Icons.library_books,
                        size: 30,
                        color:
                            selectedIndex == 4 ? Colors.black : Colors.black45),
                    label: 'NEWBOOKS'),
              ],
            ),
          ),
        ));
  }
}
