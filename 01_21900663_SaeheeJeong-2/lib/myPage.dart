
import 'package:flutter/material.dart';
import 'applicationState.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget{
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.exit_to_app,
              semanticLabel: 'logout',
            ),
            onPressed: () async {
              print('Logout button');
              FirebaseAuth.instance.signOut();
              Navigator.pop(context);
              Navigator.pushNamed(context, '/login');
            },
          ),
        ],
      ),
      backgroundColor: Colors.black,
      body: Center(
        child: Consumer<ApplicationState>(
          builder: (context, appState, _) => Column(
            children: <Widget>[
              proPic(appState.photoURL),
              const SizedBox(height: 60.0),
              Padding(
                padding: const EdgeInsets.fromLTRB(40, 10, 40, 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      appState.uid.toString(),
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                    const Divider(
                      thickness: 1,
                      height: 40.0,
                      color: Colors.white,
                    ),
                    Text(
                      ifEmail(appState.email),
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 60.0),
                    const Text(
                      "Saehee Jeong",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    const Text(
                      "I Promise to take the test honestly before GOD",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  proPic(String? photoURL) {
    if(photoURL != null){
      return Image.network(
        photoURL,
        width: 200,
        height: 200,
        fit: BoxFit.fill,
      );
    }else{
      return Image.network(
        'https://handong.edu/site/handong/res/img/logo.png',
        width: 200,
        height: 200,
        fit: BoxFit.fill,
      );
    }
  }

  ifEmail(String? email) {
    if(email != null){
      return email;
    }else{
      return "Anonymous";
    }
  }

}