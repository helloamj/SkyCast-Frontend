import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skycast/controllers/search_city_providers.dart';
import 'package:skycast/views/global/glass_scaffold.dart';
import 'package:skycast/views/global/responsive_text_widget.dart';
import 'package:skycast/views/global/responsive_widget.dart';
import 'package:skycast/views/home/search_city_screen_widget.dart';
import 'package:skycast/views/theme/app_pallete.dart';

class SearchCityScreen extends StatelessWidget {
  SearchCityScreen({super.key});

  final TextEditingController _searchController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    final searchBoxProvider =
        Provider.of<SearchBoxProvider>(context, listen: false);
    _focusNode.addListener(() {
      searchBoxProvider.isFocused = _focusNode.hasFocus;
    });

    return GlassScaffold(
        body: Center(
      child: SingleChildScrollView(
        child: Center(
          child: ResponsiveWidget(
            mobile: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: _mainScreen(context),
            ),
            tablet: SizedBox(
              width: 600,
              child: _mainScreen(context),
            ),
          ),
        ),
      ),
    ));
  }

  Column _mainScreen(BuildContext context) {
    return Column(
      mainAxisAlignment:
          Provider.of<SearchBoxProvider>(context, listen: true).isFocused
              ? MainAxisAlignment.start
              : MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Consumer<SearchBoxProvider>(
            builder: (context, searchBoxProvider, child) {
          return searchBoxProvider.isFocused ||
                  _searchController.text.isNotEmpty
              ? const SizedBox.shrink()
              : Column(
                  children: [
                    ResponsiveText('SKYCAST',
                        style: TextStyle(
                          color: AppPallete.primaryWhite.level1,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 25,
                        )),
                    const SizedBox(height: 20),
                    ResponsiveText(
                        "Which city's forecast are you curious about?",
                        style: TextStyle(
                            color: AppPallete.primaryWhite.level1,
                            fontSize: 12,
                            fontWeight: FontWeight.w300)),
                    const SizedBox(height: 20),
                  ],
                );
        }),
        Column(
          children: [
            CitySearchBox(
                focusNode: _focusNode, searchController: _searchController),
            const SizedBox(height: 20),
            Consumer<SearchBoxProvider>(
                builder: (context, searchBoxProvider, child) {
              return !searchBoxProvider.isFocused &&
                      _searchController.text.isEmpty
                  ? const SizedBox.shrink()
                  : const CitySuggestionBuilder();
            }),
          ],
        ),
      ],
    );
  }
}
