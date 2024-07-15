import 'package:flutter_bloc/flutter_bloc.dart';
import '../services/product_service.dart';


class ProductCubit extends Cubit<ProductState> {
  final ProductService productService;

  ProductCubit(this.productService) : super(ProductInitial());

  Future<void> fetchProducts() async {
    try {
      emit(ProductLoading());
      final products = await productService.fetchProducts();
      emit(ProductLoaded(products));
    } catch (e) {
      emit(ProductError(e.toString()));
    }
  }
  //void loadProducts() async {
    //try {
      //emit(ProductLoading());
      //final response = await Dio().get('https://dummyjson.com/products');
      //final products = (response.data['products'] as List)
        //  .map((json) => Product.fromJson(json))
          //.toList();
      //emit(ProductLoaded(products));
    //} catch (e) {
      //emit(ProductError(e.toString()));
    //}
  //}
  void searchProducts(String query) {
    if (state is ProductLoaded) {
      final currentState = state as ProductLoaded;
      final filteredProducts = currentState.products.where((product) {
        return product.title.toLowerCase().contains(query.toLowerCase());
      }).toList();
      emit(ProductLoaded(filteredProducts));
    }
  }

}

abstract class ProductState {
  List<Product> products = [];
}

class ProductInitial extends ProductState {}

class ProductLoading extends ProductState {}

class ProductLoaded extends ProductState {
  final List<Product> products;
  ProductLoaded(this.products);
}

class ProductError extends ProductState {
  final String message;
  ProductError(this.message);
}








