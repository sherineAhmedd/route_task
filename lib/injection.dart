import 'package:get_it/get_it.dart';
import 'package:recycle_app/services/product_service.dart';
import 'blocs/product_cubit.dart';


final getIt = GetIt.instance;

void setup() {
  getIt.registerLazySingleton<ProductService>(() => ProductService());
  getIt.registerFactory(() => ProductCubit(getIt<ProductService>()));
}
