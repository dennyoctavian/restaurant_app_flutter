import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/presentation/extensions/extensions.dart';
import 'package:restaurant_app/presentation/provider/favorite_restaurant_notifier.dart';
import 'package:restaurant_app/presentation/widgets/widgets.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<FavoriteRestaurantNotifier>(
        context,
        listen: false,
      ).fetchListFavoriteRestaurant();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Favorite Restaurant")),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: RefreshIndicator(
                onRefresh: () {
                  return Provider.of<FavoriteRestaurantNotifier>(
                    context,
                    listen: false,
                  ).fetchListFavoriteRestaurant();
                },
                child: Consumer<FavoriteRestaurantNotifier>(
                  builder: (context, value, child) {
                    if (value.isError) {
                      return Column(
                        children: [
                          32.height,
                          Center(
                            child: Text(
                              value.message,
                              style: context.textTheme.headlineSmall?.copyWith(
                                color: context.colorScheme.error,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          32.height,
                          ElevatedButton(
                            onPressed: () {
                              Provider.of<FavoriteRestaurantNotifier>(
                                context,
                                listen: false,
                              ).fetchListFavoriteRestaurant();
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: context.colorScheme.error,
                            ),
                            child: Text(
                              "Retry",
                              style: context.textTheme.bodyLarge,
                            ),
                          ),
                        ],
                      );
                    }
                    if (value.isLoading) {
                      return Center(child: const CircularProgressIndicator());
                    }
                    if (value.restaurants.isNotEmpty) {
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: value.restaurants.length,
                        itemBuilder: (context, index) {
                          return RestaurandFavoriteCard(
                            restaurant: value.restaurants[index],
                          );
                        },
                      );
                    } else {
                      return Center(
                        child: Text(
                          "No favorite restaurant",
                          style: context.textTheme.bodyLarge,
                        ),
                      );
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
