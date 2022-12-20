import 'package:flutter/material.dart';

class FavoriteHotels extends StatefulWidget {
  const FavoriteHotels({Key? key}) : super(key: key);

  @override
  State<FavoriteHotels> createState() => _FavoriteHotelsState();
}

class _FavoriteHotelsState extends State<FavoriteHotels> {
  //final List<Product> favHotelList = favList.toList();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fav Hotels',
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              semanticLabel: 'menu',
            ),
            onPressed: () {
              Navigator.pop(context);
              print('Menu button');
            },
          ),

          title: const Text('Favorite Hotels'),
          actions: <Widget>[
            IconButton(
              icon: const Icon(
                Icons.search,
                semanticLabel: 'search',
              ),
              onPressed: () {
                print('Search button');
                Navigator.pushNamed(context, '/search');
              },
            ),
          ],
        ),
        /*
        body: ListView.builder(
          //itemCount: favList.length,
          itemBuilder: (context, index) {
            final item = favHotelList[index].name;
            return Dismissible(
              // Each Dismissible must contain a Key. Keys allow Flutter to
              // uniquely identify widgets.
              key: Key(item),
              // Provide a function that tells the app
              // what to do after an item has been swiped away.
              onDismissed: (direction) {
                // Remove the item from the data source.
                setState(() {
                  favList.remove(favHotelList[index]);
                  favHotelList.removeAt(index);
                });

                // Then show a snackbar.
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text('$item dismissed')));
              },
              // Show a red background as the item is swiped away.
              background: Container(color: Colors.red),
              child: ListTile(
                title: Text(item),
              ),
            );
          },
        ),

         */
      ),
    );
  }
}
