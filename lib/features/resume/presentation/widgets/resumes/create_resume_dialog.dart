import 'package:flutter/material.dart';
import 'package:resumely/app/constants/app_colors.dart';
import 'package:resumely/app/constants/app_spacing.dart';
import 'package:resumely/app/constants/app_textstyles.dart';

class CreateResumeDialog extends StatefulWidget {
  final ValueChanged<String> onCreated;

  const CreateResumeDialog({super.key, required this.onCreated});

  static Future<void> show(BuildContext context, {required ValueChanged<String> onCreated}) {
    return showDialog(
      context: context,
      builder: (ctx) => CreateResumeDialog(onCreated: onCreated),
    );
  }

  @override
  State<CreateResumeDialog> createState() => _CreateResumeDialogState();
}

class _CreateResumeDialogState extends State<CreateResumeDialog> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: 'New Resume');
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _submit() {
    final title = _controller.text.trim();
    if (title.isNotEmpty) {
      widget.onCreated(title);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.card,
      shape: RoundedRectangleBorder(borderRadius: AppSpacing.borderRadiusLg),
      title: Text('Create Resume', style: AppTextStyles.h4),
      content: TextField(
        controller: _controller,
        autofocus: true,
        style: AppTextStyles.input,
        decoration: const InputDecoration(labelText: 'Resume Title'),
        onSubmitted: (_) => _submit(),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text('Cancel', style: AppTextStyles.bodySmall),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            foregroundColor: AppColors.primaryForeground,
          ),
          onPressed: _submit,
          child: const Text('Create'),
        ),
      ],
    );
  }
}
