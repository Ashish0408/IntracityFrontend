import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../constants/constants.dart';
import '../constants/color.dart';

class SubmitCancelButtons extends StatelessWidget {
  final VoidCallback onCancel;
  final Future<void> Function() onSubmit;
  final GlobalKey<FormState> formKey;

  const SubmitCancelButtons({
    super.key,
    required this.onCancel,
    required this.onSubmit,
    required this.formKey,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: secondaryColor,
          ),
          onPressed: onCancel,
          child: const Text('Cancel'),
        ),
        const Gap(defaultPadding),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: primaryColor,
          ),
          onPressed: () async {
            if (formKey.currentState!.validate()) {
              formKey.currentState!.save();
              await onSubmit();
              if (context.mounted) {
                Navigator.of(context).pop();
              }
            }
          },
          child: const Text('Submit'),
        ),
      ],
    );
  }
}
