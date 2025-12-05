// // Converted DataProvider using Riverpod
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:admin/utility/snack_bar_helper.dart';
// import 'package:get/get.dart';

// import '../../models/api_response.dart';
// import '../../models/coupon.dart';
// import '../../models/my_notification.dart';
// import '../../models/order.dart';
// import '../../models/poster.dart';
// import '../../models/product.dart';
// import '../../models/variant_type.dart';
// import '../../services/http_services.dart';
// import '../../../models/category.dart';
// import '../../models/brand.dart';
// import '../../models/sub_category.dart';
// import '../../models/variant.dart';

// class DataState {
//   final List<Category> allCategories;
//   final List<Category> filteredCategories;
//   final List<SubCategory> allSubCategories;
//   final List<SubCategory> filteredSubCategories;
//   final List<Brand> allBrands;
//   final List<Brand> filteredBrands;
//   final List<VariantType> allVariantTypes;
//   final List<VariantType> filteredVariantTypes;
//   final List<Variant> allVariants;
//   final List<Variant> filteredVariants;
//   final List<Product> allProducts;
//   final List<Product> filteredProducts;
//   final List<Coupon> allCoupons;
//   final List<Coupon> filteredCoupons;
//   final List<Poster> allPosters;
//   final List<Poster> filteredPosters;
//   final List<Order> allOrders;
//   final List<Order> filteredOrders;
//   final List<MyNotification> allNotifications;
//   final List<MyNotification> filteredNotifications;

//   const DataState({
//     this.allCategories = const [],
//     this.filteredCategories = const [],
//     this.allSubCategories = const [],
//     this.filteredSubCategories = const [],
//     this.allBrands = const [],
//     this.filteredBrands = const [],
//     this.allVariantTypes = const [],
//     this.filteredVariantTypes = const [],
//     this.allVariants = const [],
//     this.filteredVariants = const [],
//     this.allProducts = const [],
//     this.filteredProducts = const [],
//     this.allCoupons = const [],
//     this.filteredCoupons = const [],
//     this.allPosters = const [],
//     this.filteredPosters = const [],
//     this.allOrders = const [],
//     this.filteredOrders = const [],
//     this.allNotifications = const [],
//     this.filteredNotifications = const [],
//   });

//   DataState copyWith({
//     List<Category>? allCategories,
//     List<Category>? filteredCategories,
//     List<SubCategory>? allSubCategories,
//     List<SubCategory>? filteredSubCategories,
//     List<Brand>? allBrands,
//     List<Brand>? filteredBrands,
//     List<VariantType>? allVariantTypes,
//     List<VariantType>? filteredVariantTypes,
//     List<Variant>? allVariants,
//     List<Variant>? filteredVariants,
//     List<Product>? allProducts,
//     List<Product>? filteredProducts,
//     List<Coupon>? allCoupons,
//     List<Coupon>? filteredCoupons,
//     List<Poster>? allPosters,
//     List<Poster>? filteredPosters,
//     List<Order>? allOrders,
//     List<Order>? filteredOrders,
//     List<MyNotification>? allNotifications,
//     List<MyNotification>? filteredNotifications,
//   }) {
//     return DataState(
//       allCategories: allCategories ?? this.allCategories,
//       filteredCategories: filteredCategories ?? this.filteredCategories,
//       allSubCategories: allSubCategories ?? this.allSubCategories,
//       filteredSubCategories:
//           filteredSubCategories ?? this.filteredSubCategories,
//       allBrands: allBrands ?? this.allBrands,
//       filteredBrands: filteredBrands ?? this.filteredBrands,
//       allVariantTypes: allVariantTypes ?? this.allVariantTypes,
//       filteredVariantTypes: filteredVariantTypes ?? this.filteredVariantTypes,
//       allVariants: allVariants ?? this.allVariants,
//       filteredVariants: filteredVariants ?? this.filteredVariants,
//       allProducts: allProducts ?? this.allProducts,
//       filteredProducts: filteredProducts ?? this.filteredProducts,
//       allCoupons: allCoupons ?? this.allCoupons,
//       filteredCoupons: filteredCoupons ?? this.filteredCoupons,
//       allPosters: allPosters ?? this.allPosters,
//       filteredPosters: filteredPosters ?? this.filteredPosters,
//       allOrders: allOrders ?? this.allOrders,
//       filteredOrders: filteredOrders ?? this.filteredOrders,
//       allNotifications: allNotifications ?? this.allNotifications,
//       filteredNotifications:
//           filteredNotifications ?? this.filteredNotifications,
//     );
//   }
// }

// class DataNotifier extends StateNotifier<DataState> {
//   DataNotifier() : super(const DataState()) {
//     _init();
//   }

//   final HttpService _service = HttpService();

//   Future<void> _init() async {
//     await Future.wait([
//       getAllProduct(),
//       getAllCategory(),
//       getAllSubCategory(),
//       getAllBrands(),
//       getAllVariantType(),
//       getAllVariant(),
//       getAllCoupons(),
//       getAllPosters(),
//       getAllOrders(),
//     ]);
//   }

//   Future<void> getAllCategory({bool showSnack = false}) async {
//     try {
//       final response = await _service.getItems(endpointUrl: 'categories');
//       if (response.isOk) {
//         final apiResponse = ApiResponse<List<Category>>.fromJson(
//           response.body,
//           (json) => (json as List).map((e) => Category.fromJson(e)).toList(),
//         );
//         state = state.copyWith(
//           allCategories: apiResponse.data,
//           filteredCategories: apiResponse.data,
//         );
//         if (showSnack) SnackBarHelper.showSuccessSnackBar(apiResponse.message);
//       }
//     } catch (e) {
//       print(e);
//       if (showSnack) SnackBarHelper.showErrorSnackBar(e.toString());
//       rethrow;
//     }
//   }

//   void filterCategories(String keyword) {
//     final filtered = keyword.isEmpty
//         ? state.allCategories
//         : state.allCategories
//             .where((e) =>
//                 (e.name ?? '').toLowerCase().contains(keyword.toLowerCase()))
//             .toList();
//     state = state.copyWith(filteredCategories: filtered);
//   }

//   // TODO: Add rest of the fetch and filter methods similarly
// }

// final dataProvider = StateNotifierProvider<DataNotifier, DataState>((ref) {
//   return DataNotifier();
// });
