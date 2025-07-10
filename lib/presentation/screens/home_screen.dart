part of 'screens.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final queryController = TextEditingController();
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<RestaurantListNotifier>(
        context,
        listen: false,
      ).fetchListRestaurant();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Restaurant App"),
        actions: [
          IconButton(
            onPressed: () {
              context.goNamed('settings');
            },
            icon: const Icon(Icons.settings),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Restaurant", style: context.textTheme.headlineLarge),
            4.height,
            Text(
              "Recommended restaurant for you!",
              style: context.textTheme.bodyLarge,
            ),
            24.height,
            DarkModeToggle(),
            24.height,
            TextFormField(
              controller: queryController,
              decoration: InputDecoration(
                hintText: 'Search...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 12,
                  horizontal: 16,
                ),
              ),
              onEditingComplete: () {
                FocusScope.of(context).unfocus();
                Provider.of<RestaurantListNotifier>(
                  context,
                  listen: false,
                ).fetchSearchRestaurant(query: queryController.text.trim());
              },
            ),
            24.height,
            Expanded(
              child: RefreshIndicator(
                onRefresh: () {
                  queryController.clear();
                  return Provider.of<RestaurantListNotifier>(
                    context,
                    listen: false,
                  ).fetchListRestaurant();
                },
                child: Consumer<RestaurantListNotifier>(
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
                              if (queryController.text.isNotEmpty) {
                                Provider.of<RestaurantListNotifier>(
                                  context,
                                  listen: false,
                                ).fetchSearchRestaurant(
                                  query: queryController.text.trim(),
                                );
                              } else {
                                Provider.of<RestaurantListNotifier>(
                                  context,
                                  listen: false,
                                ).fetchListRestaurant();
                              }
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
                          return RestaurantCard(
                            restaurant: value.restaurants[index],
                          );
                        },
                      );
                    } else {
                      return Center(
                        child: Text(
                          "Data not found",
                          style: context.textTheme.headlineSmall,
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
      floatingActionButton: FloatingActionButton(
        backgroundColor: context.colorScheme.primary,
        onPressed: () {
          context.goNamed('favorite');
        },
        child: const Icon(Icons.favorite),
      ),
    );
  }
}
