// // ignore_for_file: use_build_context_synchronously

// import 'dart:convert';
// import 'dart:developer';
// import 'dart:io';
// import 'dart:typed_data';

// import 'package:flutter/foundation.dart' hide Category;
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:image_picker/image_picker.dart';

// import '../../../core/data/data_provider.dart';
// import '../../../models/api_response.dart';
// import '../../core/services/http_services.dart';

// final dashBoardProvider = NotifierProvider<DashBoardNotifier, void>(
//   DashBoardNotifier.new,
// );

// class DashBoardNotifier extends Notifier<void> {
//   final HttpService _service = HttpService();
//   final formKey = GlobalKey<FormState>();

//   // Text controllers
//   final productNameCtrl = TextEditingController();
//   final productDescCtrl = TextEditingController();
//   final productQntCtrl = TextEditingController();
//   final productPriceCtrl = TextEditingController();
//   final productOffPriceCtrl = TextEditingController();

//   // Selections
//   Category? selectedCategory;
//   SubCategory? selectedSubCategory;
//   Brand? selectedBrand;
//   VariantType? selectedVariantType;
//   List<String> selectedVariants = [];

//   Product? productForUpdate;
//   File? selectedMainImage,
//       selectedSecondImage,
//       selectedThirdImage,
//       selectedFourthImage,
//       selectedFifthImage;
//   XFile? mainImgXFile,
//       secondImgXFile,
//       thirdImgXFile,
//       fourthImgXFile,
//       fifthImgXFile;

//   List<SubCategory> subCategoriesByCategory = [];
//   List<Brand> brandsBySubCategory = [];
//   List<String> variantsByVariantType = [];

//   @override
//   void build() {}

//   Future<void> addProduct(WidgetRef ref) async {
//     final dataState = await ref.read(dataProviderAsync.future);
//     if (selectedMainImage == null) {
//       SnackBarHelper.showErrorSnackBar('Please Choose A Image!');
//       return;
//     }
//     try {
//       Map<String, dynamic> formDataMap = {
//         'name': productNameCtrl.text,
//         'description': productDescCtrl.text,
//         'proCategoryId': selectedCategory?.sId ?? '',
//         'proSubCategoryId': selectedSubCategory?.sId ?? '',
//         'proBrandId': selectedBrand?.sId ?? '',
//         'price': productPriceCtrl.text,
//         'offerPrice': productOffPriceCtrl.text.isEmpty
//             ? productPriceCtrl.text
//             : productOffPriceCtrl.text,
//         'quantity': productQntCtrl.text,
//         'proVariantTypeId': selectedVariantType?.sId,
//         'proVariantId': selectedVariants,
//       };

//       final form = await _createFormDataForMultipleImage(
//         imgXFiles: [
//           {
//             'image1': mainImgXFile,
//             'image2': secondImgXFile,
//             'image3': thirdImgXFile,
//             'image4': fourthImgXFile,
//             'image5': fifthImgXFile,
//           }
//         ],
//         formData: formDataMap,
//       );

//       final response = await _service.addItem(
//         endpointUrl: 'products',
//         itemData: form,
//       );

//       if (response.isOk) {
//         final apiResponse = ApiResponse.fromJson(response.body, null);
//         if (apiResponse.success == true) {
//           clearFields();
//           SnackBarHelper.showSuccessSnackBar('${apiResponse.message}');
//           dataState.getAllProduct();
//           log('Product added');
//         } else {
//           SnackBarHelper.showErrorSnackBar(
//             'Failed to add Product: ${apiResponse.message}',
//           );
//         }
//       } else {
//         SnackBarHelper.showErrorSnackBar(
//           'Error ${response.body?['message'] ?? response.statusText}',
//         );
//       }
//     } catch (e) {
//       SnackBarHelper.showErrorSnackBar('An Error occured: $e');
//       rethrow;
//     }
//   }

//   Future<void> updateProduct(WidgetRef ref) async {
//     final dataState = await ref.read(dataProviderAsync.future);
//     try {
//       Map<String, dynamic> formDataMap = {
//         'name': productNameCtrl.text,
//         'description': productDescCtrl.text,
//         'proCategoryId': selectedCategory?.sId ?? '',
//         'proSubCategoryId': selectedSubCategory?.sId ?? '',
//         'proBrandId': selectedBrand?.sId ?? '',
//         'price': productPriceCtrl.text,
//         'offerPrice': productOffPriceCtrl.text.isEmpty
//             ? productPriceCtrl.text
//             : productOffPriceCtrl.text,
//         'quantity': productQntCtrl.text,
//         'proVariantTypeId': selectedVariantType?.sId,
//         'proVariantId': selectedVariants,
//       };

//       final form = await _createFormDataForMultipleImage(
//         imgXFiles: [
//           {
//             'image1': mainImgXFile,
//             'image2': secondImgXFile,
//             'image3': thirdImgXFile,
//             'image4': fourthImgXFile,
//             'image5': fifthImgXFile,
//           }
//         ],
//         formData: formDataMap,
//       );

//       final response = await _service.updateItem(
//         endpointUrl: 'products',
//         itemData: form,
//         itemId: productForUpdate?.sId ?? '',
//       );

//       if (response.isOk) {
//         final apiResponse = ApiResponse.fromJson(response.body, null);
//         if (apiResponse.success == true) {
//           clearFields();
//           SnackBarHelper.showSuccessSnackBar('${apiResponse.message}');
//           dataState.getAllProduct();
//           log('Product updated');
//         } else {
//           SnackBarHelper.showErrorSnackBar(
//             'Failed to Update Product: ${apiResponse.message}',
//           );
//         }
//       } else {
//         SnackBarHelper.showErrorSnackBar(
//           'Error ${response.body?['message'] ?? response.statusText}',
//         );
//       }
//     } catch (e) {
//       SnackBarHelper.showErrorSnackBar('An Error occured: $e');
//       rethrow;
//     }
//   }

//   Future<void> deleteProduct(Product product, WidgetRef ref) async {
//     final dataState = await ref.read(dataProviderAsync.future);
//     try {
//       final response = await _service.deleteItem(
//         endpointUrl: 'products',
//         itemId: product.sId ?? '',
//       );
//       if (response.isOk) {
//         final apiResponse = ApiResponse.fromJson(response.body, null);
//         if (apiResponse.success == true) {
//           SnackBarHelper.showSuccessSnackBar('Product Deleted Sucessfully');
//           dataState.getAllProduct();
//         }
//       } else {
//         SnackBarHelper.showErrorSnackBar(
//           'Error ${response.body?['message'] ?? response.statusText}',
//         );
//       }
//     } catch (e) {
//       SnackBarHelper.showErrorSnackBar('An Error occured: $e');
//       rethrow;
//     }
//   }

//   Future<void> pickImage(int imageCardNumber) async {
//     final picker = ImagePicker();
//     final XFile? image = await picker.pickImage(source: ImageSource.gallery);
//     if (image != null) {
//       switch (imageCardNumber) {
//         case 1:
//           selectedMainImage = File(image.path);
//           mainImgXFile = image;
//           break;
//         case 2:
//           selectedSecondImage = File(image.path);
//           secondImgXFile = image;
//           break;
//         case 3:
//           selectedThirdImage = File(image.path);
//           thirdImgXFile = image;
//           break;
//         case 4:
//           selectedFourthImage = File(image.path);
//           fourthImgXFile = image;
//           break;
//         case 5:
//           selectedFifthImage = File(image.path);
//           fifthImgXFile = image;
//           break;
//       }
//     }
//   }

//   Future<FormData> _createFormDataForMultipleImage({
//     required List<Map<String, XFile?>> imgXFiles,
//     required Map<String, dynamic> formData,
//   }) async {
//     for (int i = 0; i < imgXFiles.length; i++) {
//       for (var key in imgXFiles[i].keys) {
//         final XFile? imgXFile = imgXFiles[i][key];
//         if (imgXFile != null) {
//           if (kIsWeb) {
//             final fileName = imgXFile.name;
//             final byteImg = await imgXFile.readAsBytes();
//             formData[key] = MultipartFile(byteImg, filename: fileName);
//           } else {
//             final filePath = imgXFile.path;
//             final fileName = filePath.split('/').last;
//             formData[key] = await MultipartFile(filePath, filename: fileName);
//           }
//         }
//       }
//     }
//     return FormData(formData);
//   }

//   void submitProduct(WidgetRef ref) {
//     if (productForUpdate != null) {
//       updateProduct(ref);
//     } else {
//       addProduct(ref);
//     }
//   }

//   void filterSubcategory(Category category, WidgetRef ref) {
//     selectedSubCategory = null;
//     selectedBrand = null;
//     selectedCategory = category;
//     subCategoriesByCategory = ref
//         .read(dataProviderAsync)
//         .requireValue
//         .subCategories
//         .where((subCat) => subCat.categoryId?.sId == category.sId)
//         .toList();
//   }

//   void filterBrand(SubCategory subCategory, WidgetRef ref) {
//     selectedBrand = null;
//     selectedSubCategory = subCategory;
//     brandsBySubCategory = ref
//         .read(dataProviderAsync)
//         .requireValue
//         .brands
//         .where((brand) => brand.subcategoryId?.sId == subCategory.sId)
//         .toList();
//   }

//   void filterVariant(VariantType variantType, WidgetRef ref) {
//     selectedVariants = [];
//     selectedVariantType = variantType;
//     variantsByVariantType = ref
//         .read(dataProviderAsync)
//         .requireValue
//         .variants
//         .where((variant) => variant.variantTypeId?.sId == variantType.sId)
//         .map((variant) => variant.name ?? '')
//         .toList();
//   }

//   void setDataForUpdateProduct(Product? product, WidgetRef ref) {
//     final data = ref.read(dataProviderAsync).requireValue;
//     if (product != null) {
//       productForUpdate = product;
//       productNameCtrl.text = product.name ?? '';
//       productDescCtrl.text = product.description ?? '';
//       productPriceCtrl.text = '${product.price}';
//       productOffPriceCtrl.text = '${product.offerPrice}';
//       productQntCtrl.text = '${product.quantity}';

//       selectedCategory = data.categories
//           .firstWhereOrNull((cat) => cat.sId == product.proCategoryId?.sId);

//       subCategoriesByCategory = data.subCategories
//           .where((sub) => sub.categoryId?.sId == product.proCategoryId?.sId)
//           .toList();
//       selectedSubCategory = data.subCategories
//           .firstWhereOrNull((sub) => sub.sId == product.proSubCategoryId?.sId);

//       brandsBySubCategory = data.brands
//           .where((brand) =>
//               brand.subcategoryId?.sId == product.proSubCategoryId?.sId)
//           .toList();
//       selectedBrand = data.brands
//           .firstWhereOrNull((brand) => brand.sId == product.proBrandId?.sId);

//       selectedVariantType = data.variantTypes
//           .firstWhereOrNull((vt) => vt.sId == product.proVariantTypeId?.sId);

//       variantsByVariantType = data.variants
//           .where((v) => v.variantTypeId?.sId == product.proVariantTypeId?.sId)
//           .map((v) => v.name ?? '')
//           .toList();
//       selectedVariants = product.proVariantId ?? [];
//     } else {
//       clearFields();
//     }
//   }

//   void clearFields() {
//     productNameCtrl.clear();
//     productDescCtrl.clear();
//     productPriceCtrl.clear();
//     productOffPriceCtrl.clear();
//     productQntCtrl.clear();

//     selectedMainImage = null;
//     selectedSecondImage = null;
//     selectedThirdImage = null;
//     selectedFourthImage = null;
//     selectedFifthImage = null;

//     mainImgXFile = null;
//     secondImgXFile = null;
//     thirdImgXFile = null;
//     fourthImgXFile = null;
//     fifthImgXFile = null;

//     selectedCategory = null;
//     selectedSubCategory = null;
//     selectedBrand = null;
//     selectedVariantType = null;
//     selectedVariants = [];

//     productForUpdate = null;
//     subCategoriesByCategory = [];
//     brandsBySubCategory = [];
//     variantsByVariantType = [];
//   }
// }
