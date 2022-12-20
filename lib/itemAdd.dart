import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';

import 'applicationState.dart';


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
                      _price.text,
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
              alignment: Alignment.centerLeft,
              child: IconButton(
                icon: const Icon(Icons.camera_enhance),
                onPressed: () {
                  print("image pressed");
                  selectImages();
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

/*
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
        title: const Text("글쓰기"),
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
                      _price.text,
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
          Container(
            padding: const EdgeInsets.all(15),
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    controller: _productName,
                    decoration: const InputDecoration(
                      labelText: '제목',
                    ),
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    maxLines: 10,
                    controller: _price,
                    decoration: const InputDecoration(
                      labelText: '내용',
                    ),
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    controller: _description,
                    decoration: const InputDecoration(
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
                  selectImages();
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

 */