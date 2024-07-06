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
    // Get the SearchBoxProvider instance using Provider.of
    final searchBoxProvider =
        Provider.of<SearchBoxProvider>(context, listen: false);

    // Add a listener to the focus node to update the isFocused property of SearchBoxProvider
    _focusNode.addListener(() {
      searchBoxProvider.isFocused = _focusNode.hasFocus;
    });

    return GlassScaffold(
      body: Consumer<SearchBoxProvider>(
        builder: (context, searchBoxProvider, child) {
          // If the search box is not focused and the search controller is empty, show the centered responsive widget
          return !searchBoxProvider.isFocused && _searchController.text.isEmpty
              ? Center(
                  child: _responsiveWidget(context),
                )
              // Otherwise, show the responsive widget wrapped in a SingleChildScrollView
              : SingleChildScrollView(
                  child: Center(child: _responsiveWidget(context)),
                );
        },
      ),
    );
  }

  // Returns a ResponsiveWidget based on the screen size
  ResponsiveWidget _responsiveWidget(BuildContext context) {
    return ResponsiveWidget(
      mobile: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: _mainScreen(context),
      ),
      tablet: SizedBox(
        width: 600,
        child: _mainScreen(context),
      ),
    );
  }

  // Returns the main screen widget
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
            // If the search box is focused or the search controller is not empty, show an empty SizedBox
            return searchBoxProvider.isFocused ||
                    _searchController.text.isNotEmpty
                ? const SizedBox.shrink()
                // Otherwise, show the SKYCAST title and description
                : LayoutBuilder(builder: (context, constraints) {
                    return Column(
                      children: [
                        ResponsiveText(
                          'SKYCAST',
                          style: TextStyle(
                            color: AppPallete.primaryWhite.level1,
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            letterSpacing: min(constraints.maxWidth, 600) / 20,
                          ),
                        ),
                        const SizedBox(height: 20),
                        ResponsiveText(
                          "Which city's forecast are you curious about?",
                          style: TextStyle(
                            color: AppPallete.primaryWhite.level1,
                            fontSize: 12,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        const SizedBox(height: 20),
                      ],
                    );
                  });
          },
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CitySearchBox(
              focusNode: _focusNode,
              searchController: _searchController,
            ),
            const SizedBox(height: 20),
            Consumer<SearchBoxProvider>(
              builder: (context, searchBoxProvider, child) {
                // If the search box is not focused and the search controller is empty, show an empty SizedBox
                return !searchBoxProvider.isFocused &&
                        _searchController.text.isEmpty
                    ? const SizedBox.shrink()
                    // Otherwise, show the CitySuggestionBuilder widget
                    : const CitySuggestionBuilder();
              },
            ),
          ],
        ),
      ],
    );
  }
}
