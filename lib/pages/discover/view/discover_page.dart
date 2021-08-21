part of 'discover.dart';

class DiscoverPage extends StatefulWidget {
  @override
  _DiscoverPageState createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage> {
  final type = TypeOfMedia.video;

  @override
  void initState() {
    super.initState();
    context.read<DiscoverCubit>().fetchMedia(type);
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<DiscoverCubit>().state;
    final media = state.media?.baseMedia.docs;
    media?.removeWhere((el) => el.thumbnail == null);
    return Scaffold(
      body: GridView.count(
        crossAxisCount: 3,
        children: List.generate(media?.length ?? 0, (index) {
          final thumbnail = media?[index].thumbnail ?? '';
          return GestureDetector(
            onTap: () => Navigator.of(context).pushNamed(
              '/carousell',
              arguments: ScreenArguments(data: {
                'carousell_media_docs_index': index,
                'carousell_type_of_media': type,
              }),
            ),
            child: DiscoverThumbnail(thumbnail: thumbnail),
          );
        }),
      ),
    );
  }
}
