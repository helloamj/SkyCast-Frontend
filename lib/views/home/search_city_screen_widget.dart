import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:skycast/constants/graphic_constants.dart';
import 'package:skycast/controllers/search_city_providers.dart';
import 'package:skycast/services/local_db/city_table_sql_services.dart';
import 'package:skycast/views/global/responsive_text_widget.dart';
import 'package:skycast/views/theme/app_pallete.dart';
import 'package:skycast/views/weather_report/weather_screen.dart';

// Widget that builds the city suggestion list
class CitySuggestionBuilder extends StatefulWidget {
  const CitySuggestionBuilder({
    Key? key, // Key is used for widget identification and comparison
  }) : super(key: key);

  @override
  State<CitySuggestionBuilder> createState() => _CitySuggestionBuilderState();
}

class _CitySuggestionBuilderState extends State<CitySuggestionBuilder> {
  @override
  void initState() {
    // This method is called when the state is initialized
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) async {
      // Executes the callback after the frame is rendered
      Provider.of<SearchCityProvider>(context, listen: false).cities =
          await CitySqlService
              .getAllCities(); // Fetches all cities from the database
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SearchCityProvider>(
        builder: (context, cityProvider, child) {
      if (cityProvider.isLoading) {
        // If the cityProvider is still loading, show a loading animation
        return SearchExceptionHandler(
            upper: Lottie.asset(
              GraphicConstants.loadingAnimation,
              height: 200,
              width: 200,
            ),
            message: 'Loading...');
      }

      return cityProvider.cities.isEmpty
          ? const SizedBox
              .shrink() // If there are no cities, return an empty SizedBox
          : Column(
              children: [
                cityProvider.isSearchingEmpty
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const SizedBox(width: 10),
                          Icon(Icons.history,
                              color: AppPallete.primaryWhite.level1),
                          const SizedBox(width: 10),
                          ResponsiveText('Recent Searches',
                              style: TextStyle(
                                  color: AppPallete.primaryWhite.level1,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w300)),
                        ],
                      )
                    : const SizedBox(),
                ListView.separated(
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
                ),
              ],
            );
    });
  }
}

// Widget that handles exceptions during city search
class SearchExceptionHandler extends StatelessWidget {
  const SearchExceptionHandler({
    Key? key,
    required this.upper,
    required this.message,
  }) : super(key: key);

  final Widget upper; // Widget to be displayed at the top
  final String message; // Error message to be displayed

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

// Widget that represents a city tile in the suggestion list
class CityTile extends StatelessWidget {
  const CityTile({
    Key? key,
    required this.index,
  }) : super(key: key);
  final int index; // Index of the city in the list

  @override
  Widget build(BuildContext context) {
    final cityProvider =
        Provider.of<SearchCityProvider>(context, listen: false);
    return ListTile(
      onTap: () {
        // When a city tile is tapped, insert the city into the database and navigate to the weather screen
        CitySqlService.insertCity(cityProvider.cities[index]);
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
          '${cityProvider.cities[index].state}${cityProvider.cities[index].state == '' ? '' : ', '}${cityProvider.cities[index].country}',
          style: TextStyle(
              color: AppPallete.primaryWhite.level2,
              fontSize: 10,
              fontWeight: FontWeight.w200)),
    );
  }
}

// Widget that represents the city search box
class CitySearchBox extends StatelessWidget {
  const CitySearchBox({
    Key? key,
    required FocusNode focusNode,
    required TextEditingController searchController,
  })  : _focusNode = focusNode,
        _searchController = searchController;

  final FocusNode _focusNode; // FocusNode to handle focus events
  final TextEditingController
      _searchController; // Controller for the search text field

  @override
  Widget build(BuildContext context) {
    final cityProvider =
        Provider.of<SearchCityProvider>(context, listen: false);
    _searchController.addListener(() {
      cityProvider.searchCity(_searchController
          .text); // Update the search query in the cityProvider
    });
    return TextField(
      focusNode: _focusNode,
      controller: _searchController,
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
                    cityProvider.emptySearch(true);
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
                    cityProvider.emptySearch(true);
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
