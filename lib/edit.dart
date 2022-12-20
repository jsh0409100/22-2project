import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'applicationState.dart';
import 'model/product.dart';

class EditPage extends StatefulWidget{
  const EditPage({Key? key, required this.name, required this.price, required this.desc, required this.product}) : super(key: key);

  final Product product;
  final String name;
  final String price;
  final String desc;

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage>{
  final _productName = TextEditingController();
  final _price = TextEditingController();
  final _description = TextEditingController();

  final _formKey = GlobalKey<FormState>(debugLabel: '_EditPageState');

  @override
  void initState(){
    super.initState();
    _productName.text = widget.name;
    _price.text = widget.price;
    _description.text = widget.desc;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit"),
        actions: <Widget>[
          Consumer<ApplicationState>(
            builder: (context, appState, _) => TextButton(
              style: TextButton.styleFrom(
                textStyle: const TextStyle(fontSize: 17),
              ),
              onPressed: () async{
                if(_formKey.currentState!.validate()){
                  await appState.updateProduct(
                      widget.product.docId,
                      _productName.text,
                      _price.text,
                      _description.text);
                }
                print('Save button');
                Navigator.pop(context);
              },
              child: const Text(
                'Save',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
      body: ListView(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(15),
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    controller: _productName,
                    decoration: const InputDecoration(
                      filled: true,
                      labelText: '제목',
                    ),
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    controller: _price,
                    maxLines: 10,
                    decoration: const InputDecoration(
                      filled: true,
                      labelText: '내용',
                    ),
                  ),
                  SizedBox(height: 16),

                  TextFormField(
                    controller: _description,
                    decoration: const InputDecoration(
                      filled: true,
                      labelText: '카테고리',
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 10, 10, 0),
            child: Align(
              alignment: Alignment.centerRight,
              child: IconButton(
                icon: const Icon(Icons.camera_enhance),
                onPressed: () {
                  print("image pressed");
                },
              ),
            ),
          ),
          Image.network(
            'https://handong.edu/site/handong/res/img/logo.png',
            width: 600,
            height: 240,
            fit: BoxFit.fill,
          ),
        ],
      ),
    );
  }

}
