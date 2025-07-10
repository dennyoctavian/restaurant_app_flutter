part of 'screens.dart';

class DetailScreen extends StatefulWidget {
  final String id;
  const DetailScreen({super.key, required this.id});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _reviewController = TextEditingController();

  void _showReviewDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Leave a Review'),
          content: SingleChildScrollView(
            child: SizedBox(
              width: double.maxFinite,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      hintText: 'Enter your name...',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  12.height,
                  TextFormField(
                    controller: _reviewController,
                    maxLines: 4,
                    decoration: InputDecoration(
                      hintText: 'Enter your review...',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                context.pop();
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () async {
                try {
                  var response = await ApiRestaurant.addReviewRestaurant(
                    id: widget.id,
                    name: _nameController.text,
                    review: _reviewController.text,
                  );
                  if (response.error == true) {
                    if (!context.mounted) return;
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(response.message ?? ''),
                        backgroundColor: context.colorScheme.error,
                      ),
                    );
                  } else {
                    _nameController.clear();
                    _reviewController.clear();
                    if (!context.mounted) return;
                    Provider.of<DetailRestaurantNotifier>(
                      context,
                      listen: false,
                    ).fetchDetailRestaurant(id: widget.id);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(response.message ?? ''),
                        backgroundColor: Colors.lightGreenAccent,
                      ),
                    );
                    context.pop();
                  }
                } catch (e) {
                  if (!context.mounted) return;
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(e.toString()),
                      backgroundColor: context.colorScheme.error,
                    ),
                  );
                }
              },
              child: Text('Submit'),
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<DetailRestaurantNotifier>(
        context,
        listen: false,
      ).fetchDetailRestaurant(id: widget.id);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Restaurant Details')),
      body: SingleChildScrollView(
        child: Consumer<DetailRestaurantNotifier>(
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
                      Provider.of<DetailRestaurantNotifier>(
                        context,
                        listen: false,
                      ).fetchDetailRestaurant(id: widget.id);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: context.colorScheme.error,
                    ),
                    child: Text("Retry", style: context.textTheme.bodyLarge),
                  ),
                ],
              );
            }
            if (value.isLoading) {
              return Center(child: const CircularProgressIndicator());
            }

            if (value.restaurant != null) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Hero(
                    tag: value.restaurant?.name ?? '',
                    child: Image.network(
                      'https://restaurant-api.dicoding.dev/images/medium/${value.restaurant?.pictureId ?? ''}',
                      height: 300,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 24,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          value.restaurant?.name ?? '',
                          style: context.textTheme.headlineLarge,
                        ),

                        9.height,
                        Row(
                          children: [
                            Icon(
                              Icons.star,
                              color: context.colorScheme.secondary,
                            ),
                            8.width,
                            Text(
                              value.restaurant?.rating.toString() ?? '',
                              style: context.textTheme.bodyLarge?.copyWith(
                                color: context.colorScheme.secondary,
                              ),
                            ),
                          ],
                        ),
                        9.height,
                        Text(
                          value.restaurant?.address ?? '',
                          style: context.textTheme.bodyLarge,
                        ),
                        9.height,
                        Text(
                          value.restaurant?.city ?? '',
                          style: context.textTheme.bodyMedium,
                        ),
                        9.height,

                        Center(
                          child: ElevatedButton(
                            onPressed: () async {
                              try {
                                if (value.isFavorite) {
                                  await LocalFavoriteDbHelper().deleteFavorite(
                                    value.restaurant!.id ?? '',
                                  );
                                } else {
                                  await LocalFavoriteDbHelper().insertFavorite(
                                    value.restaurant!,
                                  );
                                }
                                if (!context.mounted) return;
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      value.isFavorite
                                          ? 'Remove Favorite Success'
                                          : 'Add Favorite Success',
                                      style: context.textTheme.bodyLarge
                                          ?.copyWith(
                                            color: context.colorScheme.primary,
                                          ),
                                    ),
                                    backgroundColor: Colors.lightGreenAccent,
                                  ),
                                );
                                Provider.of<DetailRestaurantNotifier>(
                                  context,
                                  listen: false,
                                ).fetchDetailRestaurant(id: widget.id);
                              } catch (e) {
                                if (!context.mounted) return;
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      value.isFavorite
                                          ? 'Remove Favorite Failed'
                                          : 'Add Favorite Failed',
                                      style: context.textTheme.bodyLarge
                                          ?.copyWith(
                                            color: context.colorScheme.primary,
                                          ),
                                    ),
                                    backgroundColor: Colors.redAccent,
                                  ),
                                );
                              }
                            },
                            child: Text(
                              value.isFavorite
                                  ? 'Remove Favorite'
                                  : 'Add Favorite',
                            ),
                          ),
                        ),
                        9.height,
                        Text(
                          value.restaurant?.description ?? '',
                          style: context.textTheme.bodySmall,
                        ),
                        10.height,
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Foods",
                                    style: context.textTheme.headlineSmall,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children:
                                        value.restaurant?.menus?.foods
                                            ?.asMap()
                                            .entries
                                            .map((entry) {
                                              final index = entry.key + 1;
                                              final food = entry.value;
                                              return Text(
                                                '$index. ${food.name ?? ''}',
                                              );
                                            })
                                            .toList() ??
                                        [],
                                  ),
                                  10.height,
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Drinks",
                                    style: context.textTheme.headlineSmall,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children:
                                        value.restaurant?.menus?.drinks
                                            ?.asMap()
                                            .entries
                                            .map((entry) {
                                              final index = entry.key + 1;
                                              final drink = entry.value;
                                              return Text(
                                                '$index. ${drink.name ?? ''}',
                                              );
                                            })
                                            .toList() ??
                                        [],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),

                        24.height,
                        SizedBox(
                          height: 200,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount:
                                value.restaurant?.customerReviews?.length ?? 0,
                            itemBuilder: (context, index) => Container(
                              width: 200,
                              margin: EdgeInsets.only(right: 20),
                              child: Card(
                                elevation: 4,
                                color: context.colorScheme.secondary,
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        value
                                                .restaurant
                                                ?.customerReviews?[index]
                                                .name ??
                                            '',
                                        style: context.textTheme.bodyLarge,
                                      ),
                                      4.height,
                                      Text(
                                        "${value.restaurant?.customerReviews?[index].date ?? ''} - ${value.restaurant?.customerReviews?[index].review ?? ''}",
                                        style: context.textTheme.bodySmall,
                                        textAlign: TextAlign.center,
                                        maxLines: 3,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),

                        24.height,
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  context.colorScheme.errorContainer,
                            ),
                            onPressed: () => {_showReviewDialog(context)},
                            child: Text(
                              "Add Review",
                              style: context.textTheme.bodyLarge,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }

            return SizedBox();
          },
        ),
      ),
    );
  }
}
