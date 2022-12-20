import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'model/product.dart';
import 'detail.dart';
import 'myPage.dart';
import 'itemAdd.dart';
import 'applicationState.dart';

class feed extends StatefulWidget {
  const feed({Key? key}) : super(key: key);

  @override
  State<feed> createState() => _feedState();
}

class _feedState extends State<feed> {
  String dropdownValue = 'ASC';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Consumer<ApplicationState>(
            builder: (context, appState, _) => Material(
              child: DropdownButton<String>(
                value: dropdownValue,
                icon: const Icon(Icons.arrow_downward),
                iconSize: 20,
                elevation: 16,
                style: const TextStyle(color: Colors.black),
                underline: Container(
                  height: 1,
                  color: Colors.grey,
                ),
                onChanged: (String? newValue) {
                  setState(() {
                    dropdownValue = newValue!;
                  });
                },
                items: <String>['ASC', 'DESC']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: Consumer<ApplicationState>(
                builder: (context, appState, _) => GridView.count(
                  crossAxisCount: 1,
                  padding: const EdgeInsets.all(16.0),
                  childAspectRatio: 2.5 / 1.0,
                  children: _buildGridCards(context, appState, dropdownValue),
                ),
              ),
            ),
          ),
        ],

      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print('add button');

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddPage(),
            ),
          );
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.lime.shade300,
      ),
    );
  }

  List<Card> _buildGridCards(
      BuildContext context, ApplicationState appState, String dropdownValue) {
    List<Product> products = appState.products;


    if (products.isEmpty) {
      print("no product");
      return const <Card>[];
    }

    if (dropdownValue == "DESC") {
      products = products.reversed.toList();
    } else {
      products = appState.products;
    }

    return products.map((product) {
      //var time = new DateFormat.yMMMd().format(product.productCreated);
      Timestamp? date = product.productCreated;

      return Card(
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            /*
            AspectRatio(
              aspectRatio: 2 / 1,
              child: Image.asset('assets/launcher_icon/students.png',
                fit: BoxFit.fill,
              ),
            ),*/
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 8.0),
                child:
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5), //모서리를 둥글게
                                    color: Colors.lime.shade100,), //테두리
                                child: Text(
                                  product.productDesc,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w100,
                                  ),
                                  maxLines: 1,
                                ),
                              ),
                              Expanded(

                                child: Container(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                      DateFormat('MMM dd HH:mm').format(date!.toDate()),
                                    style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black54,
                                    ),
                                    maxLines: 1,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8.0),
                          Text(
                            product.productName,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                            maxLines: 1,
                          ),
                          const SizedBox(height: 8.0),
                          Text(
                            product.productPrice,
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w300,
                            ),
                            maxLines: 2,
                          ),
                        Row(
                          children: [
                            Container(
                              alignment: Alignment.bottomLeft,
                              width: 30,
                              height: 30,
                              child: Icon(Icons.favorite, color: Colors.redAccent,),
                            ),
                            Container(
                              alignment: Alignment.bottomLeft,
                              width: 30,
                              height: 30,
                              child: Icon(Icons.bookmark, color: Colors.redAccent,),
                            ),
                            Expanded(
                              child: Container(
                                alignment: Alignment.bottomLeft,
                                width: 30,
                                height: 30,
                                child: Icon(Icons.comment, color: Colors.redAccent,),
                              ),
                            ),

                            Align(
                              alignment: Alignment.bottomRight,
                              child: TextButton(
                                onPressed: () {
                                  print("More button");

                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => DetailPage(
                                        product: product,
                                      ),
                                    ),
                                  );
                                },
                                child: const Text(
                                  'more',
                                  style: TextStyle(
                                    fontSize: 10,
                                  ),
                                ),
                                style: TextButton.styleFrom(
                                  // padding: const EdgeInsets.all(0.0),
                                  minimumSize: const Size(5, 3),
                                ),
                              ),
                            ),
                          ],
                        )
                          ],
                      ),
                    ),
                ),
              ),
        ],),
      );
    }).toList();
  }
}
