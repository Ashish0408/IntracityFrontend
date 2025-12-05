// // Converted: ProductSubmitForm using Riverpod

// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// import '../../core/data/data_provider.dart';
// import 'DashBoardNotifier.dart';

// class ProductSubmitForm extends ConsumerWidget {
//   final Product? product;

//   const ProductSubmitForm({super.key, this.product});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final dashProvider = ref.watch(dashBoardProvider);
//     final dashNotifier = ref.read(dashBoardProvider.notifier);
//     final dataState = ref.watch(dataProviderAsync);

//     // Set update data only once (if not already set)
//     if (product != null && !dashProvider.isInitializedForEdit) {
//       dashNotifier.setDataForUpdateProduct(product);
//     }

//     return SingleChildScrollView(
//       child: Form(
//         key: dashNotifier.addProductFormKey,
//         child: Container(
//           width: MediaQuery.of(context).size.width * 0.7,
//           padding: const EdgeInsets.all(defaultPadding),
//           decoration: BoxDecoration(
//             color: bgColor,
//             borderRadius: BorderRadius.circular(12.0),
//           ),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               const SizedBox(height: defaultPadding),
//               Row(
//                 crossAxisAlignment: CrossAxisAlignment.end,
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: List.generate(5, (index) {
//                   return ProductImageCard(
//                     labelText:
//                         '${index + 1}${index == 0 ? ' (Main)' : ''} Image',
//                     imageFile: dashProvider.selectedImages[index],
//                     imageUrlForUpdateImage:
//                         product?.images.safeElementAt(index)?.url,
//                     onTap: () =>
//                         dashNotifier.pickImage(imageCardNumber: index + 1),
//                     onRemoveImage: () {
//                       dashNotifier.removeImage(index);
//                     },
//                   );
//                 }),
//               ),
//               const SizedBox(height: defaultPadding),
//               CustomTextField(
//                 controller: dashProvider.productNameCtrl,
//                 labelText: 'Product Name',
//                 validator: (value) => (value == null || value.isEmpty)
//                     ? 'Please enter name'
//                     : null,
//               ),
//               const SizedBox(height: defaultPadding),
//               CustomTextField(
//                 controller: dashProvider.productDescCtrl,
//                 labelText: 'Product Description',
//                 lineNumber: 3,
//               ),
//               const SizedBox(height: defaultPadding),
//               dataState.when(
//                 data: (data) => Row(
//                   children: [
//                     Expanded(
//                       child: CustomDropdown<Category>(
//                         key: ValueKey(dashProvider.selectedCategory?.sId),
//                         initialValue: dashProvider.selectedCategory,
//                         hintText: dashProvider.selectedCategory?.name ??
//                             'Select category',
//                         items: data.categories,
//                         displayItem: (c) => c?.name ?? '',
//                         onChanged: (newValue) {
//                           if (newValue != null) {
//                             dashNotifier.filterSubcategory(newValue);
//                           }
//                         },
//                         validator: (value) =>
//                             value == null ? 'Please select a category' : null,
//                       ),
//                     ),
//                     Expanded(
//                       child: CustomDropdown<SubCategory>(
//                         key: ValueKey(dashProvider.selectedSubCategory?.sId),
//                         hintText: dashProvider.selectedSubCategory?.name ??
//                             'Sub category',
//                         items: dashProvider.subCategoriesByCategory,
//                         initialValue: dashProvider.selectedSubCategory,
//                         displayItem: (s) => s?.name ?? '',
//                         onChanged: (newValue) {
//                           if (newValue != null) {
//                             dashNotifier.filterBrand(newValue);
//                           }
//                         },
//                         validator: (value) =>
//                             value == null ? 'Please select sub category' : null,
//                       ),
//                     ),
//                     Expanded(
//                       child: CustomDropdown<Brand>(
//                         key: ValueKey(dashProvider.selectedBrand?.sId),
//                         initialValue: dashProvider.selectedBrand,
//                         items: dashProvider.brandsBySubCategory,
//                         hintText:
//                             dashProvider.selectedBrand?.name ?? 'Select Brand',
//                         displayItem: (b) => b?.name ?? '',
//                         onChanged: (newValue) {
//                           if (newValue != null) {
//                             dashNotifier.setSelectedBrand(newValue);
//                           }
//                         },
//                         validator: (value) =>
//                             value == null ? 'Please select brand' : null,
//                       ),
//                     ),
//                   ],
//                 ),
//                 orElse: () => const SizedBox(),
//               ),
//               const SizedBox(height: defaultPadding),
//               Row(
//                 children: [
//                   Expanded(
//                     child: CustomTextField(
//                       controller: dashProvider.productPriceCtrl,
//                       labelText: 'Price',
//                       inputType: TextInputType.number,
//                       validator: (value) =>
//                           value == null ? 'Please enter price' : null,
//                     ),
//                   ),
//                   Expanded(
//                     child: CustomTextField(
//                       controller: dashProvider.productOffPriceCtrl,
//                       labelText: 'Offer price',
//                       inputType: TextInputType.number,
//                     ),
//                   ),
//                   Expanded(
//                     child: CustomTextField(
//                       controller: dashProvider.productQntCtrl,
//                       labelText: 'Quantity',
//                       inputType: TextInputType.number,
//                       validator: (value) =>
//                           value == null ? 'Please enter quantity' : null,
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: defaultPadding),
//               dataState.when(
//                 data: (data) => Row(
//                   children: [
//                     Expanded(
//                       child: CustomDropdown<VariantType>(
//                         key: ValueKey(dashProvider.selectedVariantType?.sId),
//                         initialValue: dashProvider.selectedVariantType,
//                         items: data.variantTypes,
//                         hintText: 'Select Variant type',
//                         displayItem: (v) => v?.name ?? '',
//                         onChanged: (newValue) {
//                           if (newValue != null) {
//                             dashNotifier.filterVariant(newValue);
//                           }
//                         },
//                       ),
//                     ),
//                     Expanded(
//                       child: MultiSelectDropDown(
//                         items: dashProvider.variantsByVariantType,
//                         onSelectionChanged: (newValue) {
//                           dashNotifier.setSelectedVariants(newValue);
//                         },
//                         displayItem: (item) => item,
//                         selectedItems: dashProvider.selectedVariants,
//                       ),
//                     ),
//                   ],
//                 ),
//                 orElse: () => const SizedBox(),
//               ),
//               const SizedBox(height: defaultPadding),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                       foregroundColor: Colors.white,
//                       backgroundColor: secondaryColor,
//                     ),
//                     onPressed: () => Navigator.of(context).pop(),
//                     child: const Text('Cancel'),
//                   ),
//                   const SizedBox(width: defaultPadding),
//                   ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                       foregroundColor: Colors.white,
//                       backgroundColor: primaryColor,
//                     ),
//                     onPressed: () {
//                       final form = dashNotifier.addProductFormKey.currentState!;
//                       if (form.validate()) {
//                         form.save();
//                         dashNotifier.submitProduct();
//                         Navigator.of(context).pop();
//                       }
//                     },
//                     child: const Text('Submit'),
//                   ),
//                 ],
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// void showAddProductForm(BuildContext context, Product? product) {
//   showDialog(
//     context: context,
//     builder: (context) => AlertDialog(
//       backgroundColor: bgColor,
//       title: const Center(
//         child: Text('ADD PRODUCT', style: TextStyle(color: primaryColor)),
//       ),
//       content: ProductSubmitForm(product: product),
//     ),
//   );
// }
