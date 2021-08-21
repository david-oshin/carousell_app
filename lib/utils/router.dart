part of 'utils.dart';

/// El router que usa la applicación.
class AppRouter {
  final _discoverCubit = DiscoverCubit(_mediaRepository, _userRepository);
  static final _mediaRepository = MediaRepository();
  static final _userRepository = UserRepository();

  Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: _discoverCubit,
            child: DiscoverPage(),
          ),
        );
      case '/carousell':
        final args = settings.arguments as ScreenArguments;
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: _discoverCubit,
            child: CarousellPage(
              args.data['carousell_media_docs_index'] as int,
              args.data['carousell_type_of_media'] as TypeOfMedia,
            ),
          ),
        );
      default:
        return null;
    }
  }
}