import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'model/product.dart';
import 'package:firebase_auth/firebase_auth.dart'
    hide EmailAuthProvider, PhoneAuthProvider;

import 'applicationState.dart';
import 'edit.dart';

class DetailPage extends StatefulWidget{
  const DetailPage({Key? key, required this.product}) : super(key: key);

  final Product product;

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  final likeSnackBar = const SnackBar(content: Text('I LIKE IT!'));
  final doublelikeSnackBar = const SnackBar(content: Text('You can only do it once!'));
  final noDelete = const SnackBar(content: Text("You can't delete the product since you're not an owner."));
  final noEdit = const SnackBar(content: Text("You can't edit the product since you're not an owner."));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detail"),
        actions: <Widget>[
          Consumer<ApplicationState>(
            builder: (context, appState, _) => FutureBuilder<DocumentSnapshot>(
              future: FirebaseFirestore.instance.collection('products').doc(widget.product.docId).get(),
              builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                if(snapshot.hasError){
                  return const Text("has error");
                }

                if(snapshot.hasData && !snapshot.data!.exists){
                  return const Text("document does not exist");
                }

                if(snapshot.connectionState == ConnectionState.done){
                  Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;

                  return IconButton(
                    icon: const Icon(
                      Icons.edit,
                      semanticLabel: 'edit',
                    ),
                    onPressed: () {
                      if(widget.product.ownerId.toString() == appState.uid.toString()){
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditPage(
                              name: '${data['productName']}',
                              price: '${data['productPrice']}',
                              desc: '${data['productDesc']}',
                              product: widget.product,
                            ),
                          ),
                        );
                      }else{
                        print("not the owner of this product");
                        ScaffoldMessenger.of(context).showSnackBar(noEdit);
                      }
                      print('Edit button');
                    },
                  );
                }

                return const Text("loading");
              },
            ),
          ),
          Consumer<ApplicationState>(
            builder: (context, appState, _) => IconButton(
              icon: const Icon(
                Icons.delete,
                semanticLabel: 'delete',
              ),
              onPressed: () async {
                if(widget.product.ownerId.toString() == appState.uid.toString()){
                  await appState.deleteProduct(widget.product.docId);
                  Navigator.pop(context);
                }else{
                  ScaffoldMessenger.of(context).showSnackBar(noDelete);
                  print("not the owner of this product");
                }
                print('Delete button');
              },
            ),
          ),
        ],
      ),
      body: Consumer<ApplicationState>(
        builder: (context, appState, _) => ListView(
          children: <Widget>[
            Image.network(
              widget.product.picUrl.toString(),
              width: 600,
              height: 240,
              fit: BoxFit.fill,
            ),
            const SizedBox(height: 50.0),
            Consumer<ApplicationState>(
              builder: (context, appState, _) => FutureBuilder<DocumentSnapshot>(
                future: FirebaseFirestore.instance.collection('products').doc(widget.product.docId).get(),
                builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                  if(snapshot.hasError){
                    return const Text("has error");
                  }

                  if(snapshot.hasData && !snapshot.data!.exists){
                    return const Text("document does not exist");
                  }

                  if(snapshot.connectionState == ConnectionState.done){
                    Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
                    Timestamp? created = data['productCreated'];
                    Timestamp? modified = data['productModified'];

                    return Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5), //모서리를 둥글게
                              color: Colors.lime.shade100,), //테두리
                            child: Text(
                              "${data['productDesc']}",
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w100,
                              ),
                              maxLines: 1,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              IconButton(
                                icon: const Icon(Icons.favorite),
                                onPressed: () {
                                  if(appState.checkExistLike(widget.product.docId, FirebaseAuth.instance.currentUser!.uid)==true)
                                    ScaffoldMessenger.of(context).showSnackBar(doublelikeSnackBar);
                                  else
                                    ScaffoldMessenger.of(context).showSnackBar(likeSnackBar);
                                  appState.addUserLike(
                                      widget.product.docId,
                                      appState.uid.toString()
                                  );

                                  print("like pressed: " + widget.product.docId.toString());
                                },
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      "${data['ownerName']}",
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                      DateFormat('MMM dd HH:mm').format(created!.toDate()),
                                        style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black54,
                                    ),
                                    ),
                                ),
                            ],
                          ),
                          const Divider(
                            height: 40.0,
                            color: Colors.black,
                          ),
                          Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    SizedBox(height: 8.0),
                                    Text(
                                      "${data['productName']}",
                                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                                    ),
                                    SizedBox(height: 8.0),
                                    Text(
                                      "${data['productPrice']}",
                                    ),
                                    SizedBox(height: 8.0),
                                  ],
                                ),
                          const Divider(
                            color: Colors.black,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                child: IconButton(
                                  icon: const Icon(Icons.favorite),
                                  onPressed: () {
                                    if(appState.checkExistLike(widget.product.docId, FirebaseAuth.instance.currentUser!.uid)==true)
                                      ScaffoldMessenger.of(context).showSnackBar(doublelikeSnackBar);
                                    else
                                      ScaffoldMessenger.of(context).showSnackBar(likeSnackBar);
                                    appState.addUserLike(
                                        widget.product.docId,
                                        appState.uid.toString()
                                    );

                                    print("like pressed: " + widget.product.docId.toString());
                                  },
                                ),
                              ),
                              IconButton(
                                  icon: const Icon(Icons.bookmark),
                                  onPressed: () {
                                    if(appState.checkExistLike(widget.product.docId, FirebaseAuth.instance.currentUser!.uid)==true)
                                      ScaffoldMessenger.of(context).showSnackBar(doublelikeSnackBar);
                                    else
                                      ScaffoldMessenger.of(context).showSnackBar(likeSnackBar);
                                    appState.addUserLike(
                                        widget.product.docId,
                                        appState.uid.toString()
                                    );

                                    print("like pressed: " + widget.product.docId.toString());
                                  },
                                ),
                               Flexible(
                               child: IconButton(
                                 icon: const Icon(Icons.comment),
                                 onPressed: () {
                                   if(appState.checkExistLike(widget.product.docId, FirebaseAuth.instance.currentUser!.uid)==true)
                                     ScaffoldMessenger.of(context).showSnackBar(doublelikeSnackBar);
                                   else
                                     ScaffoldMessenger.of(context).showSnackBar(likeSnackBar);
                                   appState.addUserLike(
                                       widget.product.docId,
                                       appState.uid.toString()
                                   );

                                   print("like pressed: " + widget.product.docId.toString());
                                 },
                               ),
                            ),
                            ],
                          ),
                          //Text("creator: ${data['ownerId']}"),
                          ListView(),
                          Text("modified: " + DateFormat('yyyy-MM-dd kk:mm:ss').format(modified!.toDate())),
                        ],
                      ),
                    );
                  }

                  return const Text("loading");
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}