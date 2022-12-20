import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';

import 'applicationState.dart';

final ImagePicker _picker = ImagePicker();

class AddPage extends StatefulWidget{
  const AddPage({Key? key}) : super(key: key);

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  final _productName = TextEditingController();
  final _price = TextEditingController();
  final _description = TextEditingController();

  final _formKey = GlobalKey<FormState>(debugLabel: '_AddPageState');

  final ImagePicker imagePicker = ImagePicker();

  List<XFile>? imageFileList = [];

  void selectImages() async {
    final List<XFile>? selectedImages = await imagePicker.pickMultiImage();
    if (selectedImages!.isNotEmpty) {
      imageFileList!.addAll(selectedImages);
    }
    setState(() {
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add"),
        actions: <Widget>[
          Consumer<ApplicationState>(
            builder: (context, appState, _) => TextButton(
              style: TextButton.styleFrom(
                textStyle: const TextStyle(fontSize: 17),
              ),
              onPressed: () async{
                if(_formKey.currentState!.validate()){
                  await appState.addProductToMarket(
                      _productName.text,
                      int.parse(_price.text),
                      _description.text);
                  _productName.clear();
                  _price.clear();
                  _description.clear();
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
          Image.network(
            'https://handong.edu/site/handong/res/img/logo.png',
            width: 600,
            height: 240,
            fit: BoxFit.fill,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 10, 10, 0),
            child: Align(
              alignment: Alignment.centerRight,
              child: IconButton(
                icon: const Icon(Icons.camera_enhance),
                onPressed: () {
                  print("image pressed");
                  selectImages();
                },
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(30),
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    controller: _productName,
                    decoration: const InputDecoration(
                      filled: true,
                      labelText: 'Product Name',
                    ),
                  ),
                  TextFormField(
                    controller: _price,
                    decoration: const InputDecoration(
                      filled: true,
                      labelText: 'Price',
                    ),
                  ),
                  TextFormField(
                    controller: _description,
                    decoration: const InputDecoration(
                      filled: true,
                      labelText: 'Description',
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }


}