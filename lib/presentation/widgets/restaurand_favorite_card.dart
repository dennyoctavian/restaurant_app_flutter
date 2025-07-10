part of 'widgets.dart';

class RestaurandFavoriteCard extends StatelessWidget {
  final Restaurant restaurant;
  const RestaurandFavoriteCard({super.key, required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.goNamed(
          'detail',
          pathParameters: {'id': restaurant.id.toString()},
        );
      },
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Hero(
              tag: restaurant.name ?? '',
              child: ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                child: Image.network(
                  'https://restaurant-api.dicoding.dev/images/medium/${restaurant.pictureId}',
                  height: 200,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      height: 300,
                      color: Colors.grey[300],
                      alignment: Alignment.center,
                      child: Icon(
                        Icons.broken_image,
                        color: Colors.grey[700],
                        size: 64,
                      ),
                    );
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    restaurant.name ?? '',
                    style: context.textTheme.headlineSmall,
                  ),
                  4.height,
                  Text(
                    restaurant.description ?? '',
                    style: context.textTheme.bodyLarge?.copyWith(
                      color: context.colorScheme.primary,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  4.height,
                  Row(
                    children: [
                      Icon(Icons.location_on, color: context.colorScheme.error),
                      8.width,
                      Text(
                        restaurant.city ?? '',
                        style: context.textTheme.bodyLarge?.copyWith(
                          color: context.colorScheme.error,
                        ),
                      ),
                    ],
                  ),
                  4.height,
                  Row(
                    children: [
                      Icon(Icons.star, color: context.colorScheme.secondary),
                      8.width,
                      Text(
                        restaurant.rating.toString(),
                        style: context.textTheme.bodyLarge?.copyWith(
                          color: context.colorScheme.secondary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
