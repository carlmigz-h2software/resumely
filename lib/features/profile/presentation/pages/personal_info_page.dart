import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:resumely/app/components/custom_text_field.dart';
import 'package:resumely/app/components/gradient_button.dart';
import 'package:resumely/app/components/sub_page_scaffold.dart';
import 'package:resumely/app/constants/app_spacing.dart';
import 'package:resumely/app/constants/app_strings.dart';
import 'package:resumely/features/auth/presentation/bloc/auth_bloc.dart';

class PersonalInfoPage extends StatefulWidget {
  static const path = '/personal-info';
  const PersonalInfoPage({super.key});

  @override
  State<PersonalInfoPage> createState() => _PersonalInfoPageState();
}

class _PersonalInfoPageState extends State<PersonalInfoPage> {
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _titleController;

  @override
  void initState() {
    super.initState();
    final user = context.read<AuthBloc>().state.user;
    _nameController = TextEditingController(text: user?.name ?? 'Alex Carter');
    _emailController = TextEditingController(text: user?.email ?? 'alex.carter@resumely.app');
    _titleController = TextEditingController(text: 'Senior Product Designer');
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SubPageScaffold(
      title: 'Personal information',
      subtitle: 'Account',
      body: Column(
        children: [
          CustomTextField(
            label: AppStrings.fullName,
            controller: _nameController,
          ),
          AppSpacing.v14,
          CustomTextField(
            label: AppStrings.email,
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
          ),
          AppSpacing.v14,
          CustomTextField(
            label: AppStrings.jobTitle,
            controller: _titleController,
          ),
          AppSpacing.v24,
          GradientButton(
            onPressed: () {
              Navigator.pop(context);
            },
            text: 'Save changes',
            height: 48.h,
          ),
        ],
      ),
    );
  }
}
