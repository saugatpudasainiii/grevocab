import 'package:flutter/material.dart';

Widget customChipButton({required List<String> name}) {
  return GestureDetector(
    onTap: () {},
    child: Container(
      margin: const EdgeInsets.only(bottom: 10, top: 10),
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(5))),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              name[0],
              style: const TextStyle(
                color: Colors.black45,
                fontFamily: "Helvetica",
              ),
              textAlign: TextAlign.center,
            ),
            (name.length == 2)
                ? Text(
                    name[1],
                    style: const TextStyle(
                      color: Colors.black54,
                      fontFamily: "Helvetica",
                    ),
                    textAlign: TextAlign.center,
                  )
                : Container()
          ]),
    ),
  );
}
