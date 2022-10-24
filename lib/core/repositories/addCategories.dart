import 'package:bookstolook/core/services/requiestHandler.dart';
import 'package:dio/dio.dart';

abstract class GetCategoriesRepo {
  Future<Response> requestCategories();
}

class GetCategories extends GetCategoriesRepo {
  @override
  Future<Response> requestCategories() async {
    try {
      final response = await RequestHandler().getCategories();
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
