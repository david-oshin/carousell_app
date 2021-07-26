part of './carousell_image.dart';

/// La página del carousell.
/// 
/// Esta contiene la lógica que usará [CarousellImageView].
class CarousellImagePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => MediaRepository(),
      child: BlocProvider(
        create: (context) => MediaCubit(context.read<MediaRepository>()),
        child: CarousellImageView(),
      ),
    );
  }
}

/// El frontend/vista del carousell.
class CarousellImageView extends StatefulWidget {
  const CarousellImageView({
    Key? key,
  }) : super(key: key);

  @override
  _CarousellImageViewState createState() => _CarousellImageViewState();
}

class _CarousellImageViewState extends State<CarousellImageView> {

  @override
  void initState() {
    super.initState();
    context.read<MediaCubit>().fetchMedia();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: BlocBuilder<MediaCubit, MediaState>(
        builder: (context, state) {
          print(state.status);
          if (state.status.isInitial) {
            return Container();
          }
          if (state.status.isLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return PageView.builder(
            itemBuilder: (context, index) {
              final imageUrl = state.media?.docs[index].thumbnail;
              return Stack(
                children: [
                  SelectedImageWidget(imageUrl: imageUrl),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height * 0.20,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Actions(
                              onPressedMenu: () {},
                            ),
                            const ViewCount(
                              count: 12,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.20,
                        child: Column(
                          children: [
                            UserImageDetails(
                              userName: 'Data',
                              userProfilImageUrl: imageUrl,
                              onFollowPressed: () {},
                            ),
                            const SizedBox(height: 8),
                            SocialActivities(
                              imageCaption:
                                  'This is a large text, that has a lot of text in it',
                              onCommentPressed: () {},
                              onLikedPressed: () {},
                              onSharePressed: () {},
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              );
            },
            itemCount: state.media?.docs.length,
            scrollDirection: Axis.vertical,
          );
        },
      ),
    );
  }
}

// TODO: [CarousellImageView] Contiene un [StatefulWidget] el cúal debería ser
// un [StatelessWidget] pero no lo es porque no hay ningún evento 
// `context.read<MediaCubit>().fetchMedia()` que lo llame, al implementar esta
// clase debe de removerse el [StatefulWidget] y llamar 
// `context.read<MediaCubit>().fetchMedia()` en la imagen que se haga click
// en el discover.