import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  const Product({
    required this.picUrl,
    required this.ownerId,
    required this.ownerName,
    required this.productCreated,
    required this.productModified,
    required this.docId,
    required this.productName,
    required this.productPrice,
    required this.productDesc,
    required this.productLikes,

  });

  final String picUrl;
  final String ownerId;
  final String ownerName;
  final Timestamp? productCreated;
  final Timestamp? productModified;
  final String docId;
  final String productName;
  final String productPrice;
  final String productDesc;
  final String productLikes;
}