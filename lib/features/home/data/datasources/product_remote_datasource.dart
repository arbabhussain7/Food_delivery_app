import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_delivery_app/core/error/exceptions.dart';
import 'package:food_delivery_app/features/home/data/models/product_model.dart';

abstract interface class ProductRemoteDataSource {
  Future<List<ProductModel>> getProducts();
}

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  final FirebaseFirestore _firestore;

  const ProductRemoteDataSourceImpl({required FirebaseFirestore firestore})
      : _firestore = firestore;

  @override
  Future<List<ProductModel>> getProducts() async {
    try {
      final snapshot = await _firestore.collection('product').get();
      return snapshot.docs
          .map((doc) => ProductModel.fromFirestore(doc))
          .toList();
    } on FirebaseException catch (e) {
      throw ServerException(e.message ?? 'Failed to fetch products.');
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
