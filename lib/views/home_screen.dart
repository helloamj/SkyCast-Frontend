import 'dart:math';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:skycast/constants/graphic_constants.dart';
import 'package:skycast/controllers/search_city_provider.dart';
import 'package:skycast/views/global/glass_scaffold.dart';
import 'package:skycast/views/global/responsive_text_widget.dart';
import 'package:skycast/views/theme/app_pallete.dart';
import 'package:skycast/views/weather_report/weather_screen.dart';

class MyHomePage extends StatelessWidget {
  MyHomePage({super.key});

  final TextEditingController _searchController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    final cityProvider =
        Provider.of<SearchCityProvider>(context, listen: false);

    final searchBoxProvider =
        Provider.of<SearchBoxProvider>(context, listen: false);
    _focusNode.addListener(() {
      searchBoxProvider.isFocused = _focusNode.hasFocus;
    });

    return GlassScaffold(
        body: Center(
      child: SingleChildScrollView(
        child: Center(
          child: SizedBox(
            width: min(MediaQuery.of(context).size.width, 600),
            child: Column(
              mainAxisAlignment:
                  Provider.of<SearchBoxProvider>(context, listen: true)
                          .isFocused
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
                    _citySearchBox(cityProvider),
                    const SizedBox(height: 20),
                    Consumer<SearchBoxProvider>(
                        builder: (context, searchBoxProvider, child) {
                      return !searchBoxProvider.isFocused &&
                              _searchController.text.isEmpty
                          ? const SizedBox.shrink()
                          : _cityListWidget();
                    }),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    ));
  }

  Widget _cityListWidget() {
    return Consumer<SearchCityProvider>(
        builder: (context, cityProvider, child) {
      if (cityProvider.isSearchingEmpty) {
        return SizedBox(
          height: MediaQuery.of(context).size.height * 0.5,
        );
      }
      if (cityProvider.isLoading) {
        return _searchExceptionHandler(
            upper: Lottie.asset(
              GraphicConstants.loadingAnimation,
              height: 200,
              width: 200,
            ),
            context: context,
            message: 'Loading...');
      }

      if (cityProvider.cities.isEmpty) {
        return _searchExceptionHandler(
            context: context,
            upper: Icon(Icons.not_listed_location_outlined,
                color: AppPallete.primaryWhite.level1, size: 100),
            message: 'No city found');
      }
      return ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: cityProvider.cities.length + 1,
        separatorBuilder: (context, index) =>
            index < cityProvider.cities.length - 1
                ? Divider(
                    color: AppPallete.primaryWhite.level2,
                  )
                : const SizedBox(),
        itemBuilder: (context, index) {
          if (index == cityProvider.cities.length) {
            return Divider(
              color: AppPallete.primaryWhite.level2,
            );
          }
          return _cityTile(cityProvider, index, context);
        },
      );
    });
  }

  Widget _searchExceptionHandler(
      {required Widget upper,
      required String message,
      required BuildContext context}) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.5,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Spacer(),
          upper,
          const SizedBox(height: 20),
          ResponsiveText(message,
              style: TextStyle(
                  color: AppPallete.primaryWhite.level1, fontSize: 15)),
          const Spacer(),
        ],
      ),
    );
  }

  ListTile _cityTile(
      SearchCityProvider cityProvider, int index, BuildContext context) {
    return ListTile(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return WeatherScreen(
            city: cityProvider.cities[index],
          );
        }));
      },
      trailing:
          Icon(Icons.arrow_forward_ios, color: AppPallete.primaryWhite.level1),
      leading: Icon(Icons.location_city_outlined,
          color: AppPallete.primaryWhite.level1),
      title: ResponsiveText(cityProvider.cities[index].name,
          style: TextStyle(
              color: AppPallete.primaryWhite.level1,
              fontSize: 15,
              fontWeight: FontWeight.w300)),
      subtitle: ResponsiveText(
          '${cityProvider.cities[index].state}${cityProvider.cities[index].country}',
          style: TextStyle(
              color: AppPallete.primaryWhite.level2,
              fontSize: 10,
              fontWeight: FontWeight.w200)),
    );
  }

  TextField _citySearchBox(dynamic cityProvider) {
    return TextField(
      focusNode: _focusNode,
      controller: _searchController,
      onChanged: (value) => cityProvider.searchCity(value),
      style: TextStyle(color: AppPallete.primaryWhite.level4),
      cursorColor: AppPallete.primaryWhite.level3,
      cursorOpacityAnimates: true,
      decoration: InputDecoration(
        hintText: 'Search City',
        hintStyle:
            TextStyle(color: AppPallete.primaryWhite.level4!.withAlpha(100)),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
        prefixIcon: Consumer<SearchBoxProvider>(
            builder: (context, searchBoxProvider, child) {
          return searchBoxProvider.isFocused
              ? IconButton(
                  onPressed: () {
                    _focusNode.unfocus();
                    _searchController.clear();
                    Provider.of<SearchCityProvider>(context, listen: false)
                        .isSearchingEmpty = true;
                  },
                  icon: Icon(Icons.arrow_back,
                      color: AppPallete.primaryWhite.level4!.withAlpha(100)))
              : Icon(Icons.location_city,
                  color: AppPallete.primaryWhite.level4!.withAlpha(100));
        }),
        suffixIcon: Consumer<SearchCityProvider>(
            builder: (context, cityProvider, child) {
          return cityProvider.isSearchingEmpty
              ? Icon(Icons.search,
                  color: AppPallete.primaryWhite.level4!.withAlpha(100))
              : IconButton(
                  icon: Icon(Icons.close,
                      color: AppPallete.primaryWhite.level4!.withAlpha(100)),
                  onPressed: () {
                    _searchController.clear();
                  },
                );
        }),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: AppPallete.primaryWhite.level2,
          ),
          borderRadius: const BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppPallete.primaryWhite.level1),
          borderRadius: const BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        filled: true,
        fillColor: AppPallete.primaryWhite.level1.withOpacity(0.8),
      ),
    );
  }
}
