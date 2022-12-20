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
    return
      Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Center(
              child: Consumer<ApplicationState>(
                builder: (context, appState, _) => Column(
                  children: <Widget>[
                    Row(
                      children: [
                        proPic(appState.photoURL),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(40, 10, 40, 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                appState.name.toString(),
                                style: TextStyle(
                                   fontSize: 18,
                                   fontWeight: FontWeight.w600,
                                 ),
                              ),
                              const SizedBox(height: 7.0),
                              Text(
                                ifEmail(appState.email),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    textSection,
                  ],
                ),
              ),
            ),

          ],),
      );

          /*
      Consumer<ApplicationState>(
        builder: (context, appState, _) => ListView(

        children: const [
            final name = appState.name.toString();
          ListTile(
            leading: Icon(Icons.car_rental),
            title: Text(
              appState.name.toString(),
            ),
            trailing: Icon(Icons.more_vert),
          ),
          ListTile(
            leading: Icon(Icons.flight),
            title: Text('Flight'),
            trailing: Icon(Icons.more_vert),
          ),
          ListTile(
            leading: Icon(Icons.train),
            title: Text('Train'),
            trailing: Icon(Icons.more_vert),
          )
        ],
      );*/
  }

  Widget textSection = Container(
    padding: const EdgeInsets.all(32),
    child: ListView(
      children: const [
        ListTile(
          leading: Icon(Icons.car_rental),
          title: Text('Car'),
          trailing: Icon(Icons.more_vert),
        ),
        ListTile(
          leading: Icon(Icons.flight),
          title: Text('Flight'),
          trailing: Icon(Icons.more_vert),
        ),
        ListTile(
          leading: Icon(Icons.train),
          title: Text('Train'),
          trailing: Icon(Icons.more_vert),
        )
      ],
    )

  );

  proPic(String? photoURL) {
    if(photoURL != null){
      return ClipOval(
        child: Image.network(
                  photoURL,
                  width: 60,
                  height: 60,
                  fit: BoxFit.fill,
                ),
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