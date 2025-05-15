import 'package:condutta_med/modules/shared/utils/app_route.dart';
import 'package:condutta_med/modules/home/models/home_item_type.dart';

class HomeItem {
  final String title;
  final HomeItemType type;
  final AppRoute route;

  HomeItem({
    required this.title,
    required this.type,
    required this.route,
  });
}
