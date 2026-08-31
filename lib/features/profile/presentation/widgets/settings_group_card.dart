import 'package:flutter/material.dart';
import 'package:resumely/app/components/card_container.dart';
import 'package:resumely/app/constants/app_colors.dart';
import 'package:resumely/app/constants/app_spacing.dart';
import 'package:resumely/app/constants/app_textstyles.dart';

class SettingsGroupCard extends StatelessWidget {
  final String title;
  final List<Widget> tiles;

  const SettingsGroupCard({
    super.key,
    required this.title,
    required this.tiles,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title.toUpperCase(),
          style: AppTextStyles.overline,
        ),
        AppSpacing.v8,
        CardContainer(
          padding: EdgeInsets.zero,
          child: Column(
            children: [
              for (int i = 0; i < tiles.length; i++) ...[
                tiles[i],
                if (i < tiles.length - 1)
                  const Divider(color: AppColors.border, height: 1),
              ],
            ],
          ),
        ),
      ],
    );
  }
}
