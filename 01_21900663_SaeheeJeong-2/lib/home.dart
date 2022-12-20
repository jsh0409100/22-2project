import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'model/product.dart';
import 'detail.dart';
import 'myPage.dart';
import 'itemAdd.dart';
import 'applicationState.dart';
import 'wishlist.dart';

final isSelected = <bool>[false, true];

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String dropdownValue = 'ASC';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.person,
            semanticLabel: 'profile',
          ),
          onPressed: () {
            print('Profile button');

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ProfilePage(),
              ),
            );

          },
        ),
        title: const Text('Main'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.shopping_cart,
              semanticLabel: 'cart',
            ),
            onPressed: () {
              print('cart button');

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const FavoriteHotels(),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(
              Icons.add,
              semanticLabel: 'add',
            ),
            onPressed: () {
              print('Add button');

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AddPage(),
                ),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          Consumer<ApplicationState>(
            builder: (context, appState, _) => DropdownButton<String>(
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
          Expanded(
            child: Center(
              child: Consumer<ApplicationState>(
                builder: (context, appState, _) => GridView.count(
                  crossAxisCount: 2,
                  padding: const EdgeInsets.all(16.0),
                  childAspectRatio: 8.0 / 9.0,
                  children: _buildGridCards(context, appState, dropdownValue),
                ),
              ),
            ),
          ),
        ],
      ),
      resizeToAvoidBottomInset: false,
    );
  }

  List<Card> _buildGridCards(BuildContext context, ApplicationState appState, String dropdownValue) {
    List<Product> products = appState.products;

    if (products.isEmpty) {
      return const <Card>[];
    }

    if(dropdownValue == "DESC"){
      products = products.reversed.toList();
    }else{
      products = appState.products;
    }

    return products.map((product) {
      return Card(
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            AspectRatio(
              aspectRatio: 18 / 11,
              child: Image.network(
                'https://handong.edu/site/handong/res/img/logo.png',
                fit: BoxFit.fill,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 8.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            product.productName,
                            style: const TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 1,
                          ),
                          const SizedBox(height: 8.0),
                          Text(
                            product.productPrice,
                            style: const TextStyle(
                              fontSize: 8,
                            ),
                          ),
                        ],
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
                              builder: (context) => DetailPage(product: product,),
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
                ),
              ),
            ),
          ],
        ),
      );
    }).toList();
  }

}




