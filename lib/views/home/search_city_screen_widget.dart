import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:skycast/constants/graphic_constants.dart';
import 'package:skycast/controllers/search_city_providers.dart';
import 'package:skycast/views/global/responsive_text_widget.dart';
import 'package:skycast/views/theme/app_pallete.dart';
import 'package:skycast/views/weather_report/weather_screen.dart';

class CitySuggestionBuilder extends StatelessWidget {
  const CitySuggestionBuilder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<SearchCityProvider>(
        builder: (context, cityProvider, child) {
      if (cityProvider.isSearchingEmpty) {
        return SizedBox(
          height: MediaQuery.of(context).size.height * 0.5,
        );
      }
      if (cityProvider.isLoading) {
        return SearchExceptionHandler(
            upper: Lottie.asset(
              GraphicConstants.loadingAnimation,
              height: 200,
              width: 200,
            ),
            message: 'Loading...');
      }

      if (cityProvider.cities.isEmpty) {
        return SearchExceptionHandler(
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
          return CityTile(
            index: index,
          );
        },
      );
    });
  }
}

class SearchExceptionHandler extends StatelessWidget {
  const SearchExceptionHandler({
    super.key,
    required this.upper,
    required this.message,
  });

  final Widget upper;
  final String message;

  @override
  Widget build(BuildContext context) {
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
}

class CityTile extends StatelessWidget {
  const CityTile({
    super.key,
    required this.index,
  });
  final int index;

  @override
  Widget build(BuildContext context) {
    final cityProvider =
        Provider.of<SearchCityProvider>(context, listen: false);
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
}

class CitySearchBox extends StatelessWidget {
  const CitySearchBox({
    super.key,
    required FocusNode focusNode,
    required TextEditingController searchController,
  })  : _focusNode = focusNode,
        _searchController = searchController;

  final FocusNode _focusNode;
  final TextEditingController _searchController;

  @override
  Widget build(BuildContext context) {
    final cityProvider =
        Provider.of<SearchCityProvider>(context, listen: false);
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
