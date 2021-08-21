part of 'discover.dart';

class DiscoverThumbnail extends StatelessWidget {
  final String thumbnail;
  
  const DiscoverThumbnail({
    required this.thumbnail,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.33,
      height: MediaQuery.of(context).size.height * 0.33,
      margin: EdgeInsets.all(2),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(thumbnail),
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
