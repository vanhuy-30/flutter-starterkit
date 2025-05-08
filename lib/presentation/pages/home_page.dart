import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_starter_kit/core/theme/colors.dart';
import 'package:flutter_starter_kit/data/models/locale_model.dart';
import 'package:flutter_starter_kit/presentation/components/atoms/app_drop_down_field.dart';
import 'package:flutter_starter_kit/presentation/components/atoms/app_text.dart';
import 'package:flutter_starter_kit/presentation/components/mocules/navigation/appbar.dart';
import 'package:flutter_starter_kit/presentation/view_model/language_view_model.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: widget.title,
        actions: [
          Consumer<LanguageViewModel>(
              builder: (context, languageViewModel, child) {
            return AppDropdownField(
              width: 120,
              items: languageViewModel.availableLanguages,
              value: languageViewModel.getCurrentLanguage(),
              isExpanded: false,
              onChanged: (LocaleModel? selectedLocale) {
                if (selectedLocale != null) {
                  context.setLocale(selectedLocale.locale);
                  languageViewModel.changeLanguage(selectedLocale.locale);
                }
              },
              itemBuilder: (LocaleModel localeModel) {
                return Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      localeModel.flagPath,
                      width: 24,
                      height: 24,
                      fit: BoxFit.cover,
                    ),
                    const SizedBox(width: 8),
                    Text(localeModel.locale.languageCode.toUpperCase()),
                  ],
                );
              },
              dropdownColor: AppColors.whiteColor,
              dropdownIcon: const Icon(Icons.arrow_drop_down,
                  color: AppColors.primaryColor),
              iconEnabledColor: AppColors.primaryColor,
              isCompactMode: true,
              readOnly: false,
            );
          }),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppText('wellcome_message'.tr()),
          ],
        ),
      ),
    );
  }
}
