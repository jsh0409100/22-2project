import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart'
    hide EmailAuthProvider, PhoneAuthProvider;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:google_sign_in/google_sign_in.dart';


import 'model/product.dart';
import 'src/authentication.dart';

class ApplicationState extends ChangeNotifier {
  ApplicationState() {
    init();
  }

  Future<void> init() async {

    FirebaseAuth.instance
        .userChanges()
        .listen((User? user) {
      if (user != null) {
        _email = user.email;
        _photoURL = user.photoURL;
        _uid = user.uid;
        _loginState = ApplicationLoginState.loggedIn;
        print(user.uid + ': User is signed in!');

        addUserColl();

        _productSubscription = FirebaseFirestore.instance
            .collection('products')
            .orderBy('productPrice', descending: false)
            .snapshots()
            .listen((snapshot){
          _products = [];
          for(var document in snapshot.docs){
            print("Products: " + document.id);
            _products.add(
              Product(
                picUrl: document.data()['picUrl'].toString(),
                ownerId: document.data()['ownerId'].toString(),
                ownerName: document.data()['ownerName'].toString(),
                productCreated: document.data()['productCreated'],
                productModified: document.data()['productModified'],
                docId: document.id.toString(),
                productName: document.data()['productName'].toString(),
                productPrice: document.data()['productPrice'].toString(),
                productDesc: document.data()['productDesc'].toString(),
                productLikes: document.data()['productLikes'].toString(),
              ),
            );
          }
          notifyListeners();
        });

      } else {
        _loginState = ApplicationLoginState.loggedOut;

        _products = [];
        _productSubscription?.cancel();

        print(': User is currently signed out!');
      }
      notifyListeners();
    });
  }

  ApplicationLoginState _loginState = ApplicationLoginState.loggedOut;
  ApplicationLoginState get loginState => _loginState;

  String? _photoURL;
  String? get photoURL => _photoURL;

  String? _email;
  String? get email => _email;

  String? _uid;
  String? get uid => _uid;

  StreamSubscription<QuerySnapshot>? _productSubscription;
  List<Product> _products = [];
  List<Product> get products => _products;

  Future<bool> checkExistLike(String docId, String userId) {
    return FirebaseFirestore.instance.collection('products')
        .doc(docId)
        .collection('likedUsers')
        .snapshots().contains(userId);
  }

  Future<void> addCountLike(String docId){
    if (_loginState != ApplicationLoginState.loggedIn) {
      throw Exception('Must be logged in');
    }

    return FirebaseFirestore.instance.collection('products')
        .doc(docId)
        .update({
      'productLikes': FieldValue.increment(1)})
        .whenComplete(() => print("update completed"))
        .catchError((e) => print(e));
  }

  Future<void> addUserLike(String docId, String userId) async {
    if (_loginState != ApplicationLoginState.loggedIn) {
      throw Exception('Must be logged in');
    }

    bool check = false;
    //await checkExistLike(docId, userId);

    if(check == false){
      addCountLike(docId);

      return FirebaseFirestore.instance.collection('products')
          .doc(docId).collection('likedUsers')
          .doc(userId)
          .set({
        'likedId': userId,
      })
          .then((value) => print('liked added'))
          .catchError((error) => print("failed adding like"));
    }else{
      return;
    }
  }

  Future<DocumentReference> addProductToMarket(String name, int price, String desc){
    if (_loginState != ApplicationLoginState.loggedIn) {
      throw Exception('Must be logged in');
    }

    return FirebaseFirestore.instance.collection('products').add(<String, dynamic>{
      'picUrl': 'https://handong.edu/site/handong/res/img/logo.png',
      'ownerId': FirebaseAuth.instance.currentUser!.uid,
      'ownerName': FirebaseAuth.instance.currentUser!.displayName,
      'productCreated': FieldValue.serverTimestamp(),
      'productModified': FieldValue.serverTimestamp(),
      'productName': name,
      'productPrice': price,
      'productDesc': desc,
      'productLikes': 0,
    });
  }

  Future<void> updateProduct(String docId, String name, int price, String desc){
    if (_loginState != ApplicationLoginState.loggedIn) {
      throw Exception('Must be logged in');
    }

    Map<String, dynamic> data = <String, dynamic>{
      'productName': name,
      'productPrice': price,
      'productDesc': desc,
      'productModified': FieldValue.serverTimestamp(),
    };

    return FirebaseFirestore.instance.collection('products')
        .doc(docId)
        .update(data)
        .whenComplete(() => print("update completed"))
        .catchError((e) => print(e));
  }

  Future<void> deleteProduct(String docId){
    if (_loginState != ApplicationLoginState.loggedIn) {
      throw Exception('Must be logged in');
    }

    return FirebaseFirestore.instance.collection('products')
        .doc(docId)
        .delete()
        .then((value) => print("product deleted"))
        .catchError((error) => print("failed deletion"));
  }

  void startLoginFlow() {
    _loginState = ApplicationLoginState.register;
    notifyListeners();
  }

  Future<void> signInAnonymously(
      void Function(FirebaseAuthException e) errorCallback
      ) async {
    try{
      await FirebaseAuth.instance.signInAnonymously();
    } on FirebaseAuthException catch (e) {
      errorCallback(e);
    }

    _loginState = ApplicationLoginState.loggedIn;

    notifyListeners();
  }

  Future<void> signInWithGoogle(BuildContext context) async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    await FirebaseAuth.instance.signInWithCredential(credential);

    Navigator.pop(context);

    _loginState = ApplicationLoginState.loggedIn;

    notifyListeners();
  }

  void signOut() {
    FirebaseAuth.instance.signOut();
  }

  void addUserColl() {
    if (_loginState != ApplicationLoginState.loggedIn) {
      throw Exception('Must be logged in');
    }

    FirebaseFirestore.instance.collection('users')
        .doc(uid)
        .set(({
      'email': FirebaseAuth.instance.currentUser!.email,
      'name': FirebaseAuth.instance.currentUser!.displayName,
      'status_message': "I promise to take the test honestly before GOD.",
      'uid': FirebaseAuth.instance.currentUser!.uid,
    }));
  }

}