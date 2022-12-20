
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'applicationState.dart';
import 'src/authentication.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  @override
  Widget build(BuildContext context) {
    /*
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          children: <Widget>[
            const SizedBox(height: 80.0),
            Column(
              children: <Widget>[
                Image.asset('assets/diamond.png'),
                const SizedBox(height: 16.0),
                const Text('Hotel Booking'),
              ],
            ),
            const SizedBox(height: 120.0),
            ElevatedButton.icon(
              onPressed: () {},
              icon: Icon(Icons.add, size: 18),
              label: Text("CONTAINED BUTTON"), ),
            InkWell(
              child: Container(
                  width: 200,
                  height: 80,
                  margin: EdgeInsets.only(top: 25),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color:Colors.black
                  ),
                  child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Container(
                            height: 30.0,
                            width: 30.0,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                  image:
                                  AssetImage('assets/google.webp'),
                                  fit: BoxFit.cover),
                              shape: BoxShape.circle,
                            ),
                          ),
                          const Text('Sign in with Google',
                            style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white
                            ),
                          ),
                        ],
                      )
                  )
              ),
              onTap: ()
              async{ ApplicationState().signInWithGoogle();
              },
            ),
            InkWell(
              child: Container(
                  width: 200,
                  height: 80,
                  margin: EdgeInsets.only(top: 25),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color:Colors.black
                  ),
                  child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Container(
                            height: 30.0,
                            width: 30.0,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                  image:
                                  AssetImage('assets/google.webp'),
                                  fit: BoxFit.cover),
                              shape: BoxShape.circle,
                            ),
                          ),
                          const Text('Sign in Anonymously',
                            style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white
                            ),
                          ),
                        ],
                      )
                  )
              ),
              onTap: ()
              async{ ApplicationState().signInAnon();
              },
            ),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
     */
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          children: <Widget>[
            const SizedBox(height: 200.0),
            Column(
              children: <Widget>[
                Image.asset('assets/diamond.png'),
                const SizedBox(height: 16.0),
                const Text('SHRINE'),
              ],
            ),
            const SizedBox(height: 120.0),
            Consumer<ApplicationState>(
                builder: (context, appState, _) => Authentication(
                  email: appState.email,
                  loginState: appState.loginState,
                  startLoginFlow: appState.startLoginFlow,
                  signInWithGoogle: appState.signInWithGoogle,
                  signInAnonymously: appState.signInAnonymously,
                  signOut: appState.signOut,
                )
            ),
            const SizedBox(height: 12.0),
            // ButtonBar(
            //   children: <Widget>[
            //     ElevatedButton(
            //       child: const Text('NEXT'),
            //       onPressed: () {
            //         Navigator.pop(context);
            //       },
            //     ),
            //   ],
            // ),
          ],
        ),
      ),
    );
  }
}