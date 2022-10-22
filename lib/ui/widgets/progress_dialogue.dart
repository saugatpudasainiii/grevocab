import 'package:flutter/material.dart';

class CustomProgressDialogFS extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        margin: const EdgeInsets.all(60),
        alignment: FractionalOffset.center,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const CircularProgressIndicator.adaptive(),
              Container(
                margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: const Center(
                  child: Text(
                    "Loading....",
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomProgressDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Material(
      color: Colors.transparent,
      child: new Container(
        margin: new EdgeInsets.all(0),
        alignment: FractionalOffset.center,
        child: Center(
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              CircularProgressIndicator.adaptive(),
              new Container(
                margin: new EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: new Center(
                  child: Text(
                    "Loading....",
                    style: new TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
