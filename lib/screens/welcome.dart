import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_firebase_auth/screens/utils.dart';
import 'package:flutter_firebase_auth/screens/home.dart';
import 'package:flutter_firebase_auth/screens/login.dart';

// ignore: non_constant_identifier_names
final current_user = FirebaseAuth.instance.currentUser;

class WelcomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => StartState();
}

class StartState extends State<WelcomeScreen> {
  final roomNocontroller = TextEditingController();
  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return welcomeWidget();
    //return initWidget();
  }

  /* Stream<List<Housemate>> readUsers() => FirebaseFirestore.instance
      .collection('housemates')
      .snapshots()
      .map((snapshot) => snapshot.docs.map((doc) => doc.data()).toList());
 */

  Future createUser(Housemate housemate) async {
    // users is the name of the collection in the firestone database
    final docUser = FirebaseFirestore.instance.collection('housemates').doc();
    housemate.id = docUser.id;

    final jsonData = housemate.toJson();
    await docUser.set(jsonData);

    Utils.showSnackBar('Housemate successfully created');
  }

  welcomeWidget() {
    return Scaffold(
        body: StreamBuilder<User>(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Something went wrong'));
              } else if (snapshot.hasData) {
                return initWidget();
              } else {
                return HomeScreen();
              }
            }));
  }

  initWidget() {
    return Scaffold(
        body: SingleChildScrollView(
            child: Column(
      children: [
        Container(
          height: 300,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(0)),
            color: new Color(0xffF5591F),
            gradient: LinearGradient(
              colors: [(new Color(0xffF5591F)), new Color(0xffF2861E)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(top: 50),
                child: Image.asset(
                  "images/app_logo.png",
                  height: 90,
                  width: 90,
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 20),
                alignment: Alignment.bottomCenter,
                child: Text(
                  "Welcome to Zuri",
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              )
            ],
          )),
        ),
        Container(
          margin: EdgeInsets.only(top: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                child: Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(left: 20, right: 20, top: 70),
                  padding: EdgeInsets.only(left: 20, right: 20),
                  height: 50,
                  child: Text("You belong here, Great one! Zuri Loves you!! "),
                ),
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "You are signed in as " + current_user.email,
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Add an House Mate",
              ),
            ],
          ),
        ),
        Container(
          alignment: Alignment.center,
          margin: EdgeInsets.only(left: 20, right: 20, top: 20),
          padding: EdgeInsets.only(left: 20, right: 20),
          height: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(0),
            color: Color(0xffEEEEEE),
            boxShadow: [
              BoxShadow(
                  offset: Offset(0, 20),
                  blurRadius: 100,
                  color: Color(0xffEEEEEE)),
            ],
          ),
          child: TextField(
            controller: fullNameController,
            cursorColor: Color(0xffF5591F),
            decoration: InputDecoration(
              focusColor: Color(0xffF5591F),
              icon: Icon(
                Icons.person,
                color: Color(0xffF5591F),
              ),
              hintText: "Full name",
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
            ),
          ),
        ),
        Container(
          alignment: Alignment.center,
          margin: EdgeInsets.only(left: 20, right: 20, top: 20),
          padding: EdgeInsets.only(left: 20, right: 20),
          height: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(0),
            color: Color(0xffEEEEEE),
            boxShadow: [
              BoxShadow(
                  offset: Offset(0, 20),
                  blurRadius: 100,
                  color: Color(0xffEEEEEE)),
            ],
          ),
          child: TextField(
            controller: emailController,
            cursorColor: Color(0xffF5591F),
            decoration: InputDecoration(
              focusColor: Color(0xffF5591F),
              icon: Icon(
                Icons.email,
                color: Color(0xffF5591F),
              ),
              hintText: "Email Address",
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
            ),
          ),
        ),
        Container(
          alignment: Alignment.center,
          margin: EdgeInsets.only(left: 20, right: 20, top: 20),
          padding: EdgeInsets.only(left: 20, right: 20),
          height: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(0),
            color: Color(0xffEEEEEE),
            boxShadow: [
              BoxShadow(
                  offset: Offset(0, 20),
                  blurRadius: 100,
                  color: Color(0xffEEEEEE)),
            ],
          ),
          child: TextField(
            controller: phoneController,
            cursorColor: Color(0xffF5591F),
            decoration: InputDecoration(
              focusColor: Color(0xffF5591F),
              icon: Icon(
                Icons.phone,
                color: Color(0xffF5591F),
              ),
              hintText: "Phone Number",
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
            ),
          ),
        ),
        Container(
          alignment: Alignment.center,
          margin: EdgeInsets.only(left: 20, right: 20, top: 20),
          padding: EdgeInsets.only(left: 20, right: 20),
          height: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(0),
            color: Color(0xffEEEEEE),
            boxShadow: [
              BoxShadow(
                  offset: Offset(0, 20),
                  blurRadius: 100,
                  color: Color(0xffEEEEEE)),
            ],
          ),
          child: TextField(
            controller: roomNocontroller,
            cursorColor: Color(0xffF5591F),
            decoration: InputDecoration(
              focusColor: Color(0xffF5591F),
              icon: Icon(
                Icons.room,
                color: Color(0xffF5591F),
              ),
              hintText: "Room Number",
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
            ),
          ),
        ),
        Container(
          alignment: Alignment.center,
          margin: EdgeInsets.only(top: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                child: Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(left: 20, right: 20, top: 70),
                  padding: EdgeInsets.only(left: 20, right: 20),
                  height: 50,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                      (new Color(0xffF5591F)),
                      new Color(0xffF2861E)
                    ], begin: Alignment.centerLeft, end: Alignment.centerRight),
                    borderRadius: BorderRadius.circular(0),
                    color: Colors.grey[200],
                    boxShadow: [
                      BoxShadow(
                          offset: Offset(0, 10),
                          blurRadius: 50,
                          color: Color(0xffEEEEEE)),
                    ],
                  ),
                  child: Text(
                    "ADD AN HOUSE MATE",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                onTap: () {
                  final fullname = fullNameController.text.trim();
                  final phoneno = int.parse(phoneController.text);
                  final email = emailController.text.trim();
                  final roomno = roomNocontroller.text.trim();

                  final housemate = Housemate(
                    fullname: fullname,
                    email: email,
                    phoneno: phoneno,
                    roomno: roomno,
                  );
                  createUser(housemate);
                  // Write Tap Code Here
                  Navigator.pop(context);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => WelcomeScreen(),
                      ));
                },
              ),
            ],
          ),
        ),
        Container(
          alignment: Alignment.center,
          margin: EdgeInsets.only(top: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                child: Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(left: 20, right: 20, top: 70),
                  padding: EdgeInsets.only(left: 20, right: 20),
                  height: 50,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                      (new Color(0xffF5591F)),
                      new Color(0xffF2861E)
                    ], begin: Alignment.centerLeft, end: Alignment.centerRight),
                    borderRadius: BorderRadius.circular(0),
                    color: Colors.grey[200],
                    boxShadow: [
                      BoxShadow(
                          offset: Offset(0, 10),
                          blurRadius: 50,
                          color: Color(0xffEEEEEE)),
                    ],
                  ),
                  child: Text(
                    "SIGN OUT",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                onTap: () {
                  // Write Tap Code Here.

                  FirebaseAuth.instance.signOut();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginScreen(),
                      ));
                },
              ),
            ],
          ),
        )
      ],
    )));
  }
}

class Housemate {
  String id;
  final String fullname;
  final String email;
  final num phoneno;
  final String roomno;

  Housemate({
    this.id = '',
    this.fullname,
    this.email,
    this.phoneno,
    this.roomno,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': fullname,
        'emailAddress': email,
        'phoneno': phoneno,
        'roomno': roomno,
      };
}
