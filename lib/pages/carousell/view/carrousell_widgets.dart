part of './carousell.dart';

/// La imagen actual que se ve el [CarousellPage].
///
/// TODO: Probar posibles estados de la imagen.
class CarousellMedia extends StatelessWidget {
  final Doc? doc;
  final TypeOfMedia? type;

  const CarousellMedia({required this.doc, required this.type});

  @override
  Widget build(BuildContext context) {
    if (type?.isImage ?? false) {
      return FittedBox(
        fit: BoxFit.contain,
        child: Image.network(
          doc?.thumbnail ?? '',
          errorBuilder: _onErrorMedia,
          loadingBuilder: _onLoadingMedia,
        ),
      );
    }
    if (type?.isVideo ?? false) {
      return OshinVideo();
    }
    return Container();
  }

  Widget _onErrorMedia(context, exception, stacktrace) {
    return Row(
      children: [
        Icon(Icons.error),
        Text('No se ha podido cargar la imagen.'),
        ElevatedButton(
          onPressed: () {},
          child: Text('Cargar de nuevo'),
        ),
      ],
    );
  }

  Widget _onLoadingMedia(context, child, loadingProgress) {
    if (loadingProgress == null) return child;
    // TODO: Remplazar con el logo de progreso Oshinstar.
    return Center(
      child: CircularProgressIndicator(
        value: loadingProgress.expectedTotalBytes != null
            ? loadingProgress.cumulativeBytesLoaded /
                loadingProgress.expectedTotalBytes!
            : null,
      ),
    );
  }
}

/// Notifica y actualiza los cambios de abrir y cerrar el modal que pasen en
/// [ExpandableScrollableModal].
class ModalContentNotifier extends InheritedWidget {
  /// Notifica que se abrió el modal.
  final void Function() openModal;

  /// Notificia que se cerró el modal.
  final void Function() closeModal;

  const ModalContentNotifier({
    required Widget child,
    required this.openModal,
    required this.closeModal,
  }) : super(child: child);

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => true;

  static ModalContentNotifier of(BuildContext context) {
    var result =
        context.dependOnInheritedWidgetOfExactType<ModalContentNotifier>();
    assert(result != null, 'No InformationModalNotifier found in context');
    return result!;
  }
}

/// Todas las acciones que se podrá someter en la imagen del carousell.
///
/// Nota: El termino "acciones" viene de "actions" del componente [AppBar].
class CarousellActions extends StatelessWidget {
  final Doc? doc;

  const CarousellActions({
    required this.doc,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.10,
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          ),
          Row(
            children: [
              IconButton(
                onPressed: () => ModalContentNotifier.of(context).openModal(),
                icon: Icon(
                  Icons.info,
                  color: Colors.white,
                ),
              ),
              doc?.visibility == "all_oshinstar"
                  ? IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.public,
                        color: Colors.white,
                      ),
                    )
                  : Container(),
              doc?.youBoughtThis != null
                  ? IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.monetization_on,
                        color: doc!.youBoughtThis! ? Colors.blue : Colors.white,
                      ),
                    )
                  : Container(),
              (doc?.youAreSubscribedToThisProfile ?? false)
                  ? IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                    )
                  : Container(),
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.more_vert,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _InformationTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Titulo del media',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Text(
          InformationData.titleContent,
          softWrap: true,
          textAlign: TextAlign.justify,
          style: TextStyle(height: 1.5),
        ),
      ],
    );
  }
}

class _InformationAdditionial extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Additional information',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Text('Categories: ${InformationData.category}'),
        SizedBox(height: 8),
        Text('Skills: ${InformationData.skills}'),
        SizedBox(height: 8),
        Text('Location: ${InformationData.location}'),
        SizedBox(height: 8),
        Text('Premiere date: ${InformationData.date}'),
      ],
    );
  }
}

class _InformationLinks extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Website & Social Links',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 16),
        Column(
          children: [
            Row(
              children: [
                Icon(Icons.public),
                SizedBox(width: 8),
                Text(
                  'website: wwww.oshinstar.com',
                  style: TextStyle(color: Colors.blue),
                ),
              ],
            ),
            SizedBox(
              height: 16,
            ),
            Row(
              children: [
                Icon(Icons.facebook, color: Colors.blue),
                SizedBox(width: 8),
                Text('Facebook: Oshinstar_'),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

class _InformationActors extends StatelessWidget {
  final images = InformationData.images;
  final users = InformationData.names;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Actor or Talents',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Container(
          height: 140.0,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            physics: ClampingScrollPhysics(),
            itemCount: images.length,
            itemBuilder: (context, index) {
              return Container(
                width: 120,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularBorder(
                      child: Container(
                        width: 75.0,
                        height: 75.0,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(images[index]),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(50.0)),
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      users[index],
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              );
            },
          ),
        )
      ],
    );
  }
}

class InformationContent extends StatelessWidget {
  const InformationContent();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        padding: EdgeInsets.all(16),
        children: [
          _InformationTitle(),
          SizedBox(height: 24),
          _InformationAdditionial(),
          SizedBox(height: 24),
          _InformationLinks(),
          SizedBox(height: 24),
          _InformationActors(),
        ],
      ),
    );
  }
}

/// Detalles del usuario que subió la imagen.
class CarousellUserProfile extends StatelessWidget {
  final Doc? doc;
  final int index;

  const CarousellUserProfile({this.doc, required this.index});

  @override
  Widget build(BuildContext context) {
    final userProfilImageUrl = doc?.thumbnail;
    final isFollowing = doc?.youFollowThisProfile;
    return Row(
      children: [
        Container(
          child: userProfilImageUrl == null
              ? Icon(Icons.visibility_off)
              : CircleAvatar(
                  radius: 16,
                  backgroundImage: NetworkImage(
                    userProfilImageUrl,
                  ),
                ),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: Colors.blue,
              width: 3.0,
            ),
          ),
        ),
        SizedBox(width: 16),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
          child: Text(
            'Daniel',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        Container(
          width: 5,
          height: 5,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            color: Colors.white,
          ),
        ),
        SizedBox(width: 8),
        GestureDetector(
          onTap: () => context.read<DiscoverCubit>().followUser(index),
          child: Text(
            (isFollowing ?? false) ? 'Following' : 'Follow',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }
}

/// Las actividades sociales que puedes someter sobre la imagen.
class SocialActivities extends StatelessWidget {
  final Doc? doc;
  final int index;

  SocialActivities({
    this.doc,
    required this.index,
  });

  Widget commentContentBuilder(DiscoverCubit cubit) {
    return OshinBottomModalSheet(
      child: CommentContent(
        doc: doc,
        index: index,
        onAddedComment: (text) => cubit.commentMedia(
          index,
          text,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    bool isOnlyFans = (doc?.visibility == "only_my_fans" &&
        !(doc?.youAreSubscribedToThisProfile ?? false));
    bool isBought = (doc?.youBoughtThis ?? true);
    return isOnlyFans || doc?.youBoughtThis != null
        ? Column(
            children: [
              isOnlyFans
                  ? ElevatedButton(
                      onPressed: () {},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          Text('Become a fan'),
                        ],
                      ),
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.resolveWith((states) {
                          return Colors.blue[400];
                        }),
                      ),
                    )
                  : Container(),
              isBought
                  ? Container()
                  : ElevatedButton(
                      onPressed: () {},
                      child: Text('Buy this image ${doc?.price}'),
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.resolveWith((states) {
                          return Colors.blue[400];
                        }),
                      ),
                    )
            ],
          )
        : Row(
            children: [
              Column(
                children: [
                  Text(
                    '${doc?.likes ?? ''}',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  IconButton(
                    onPressed: () => context.read<DiscoverCubit>().likeMedia(
                          index,
                        ),
                    icon: Icon(
                      Icons.thumb_up_alt_outlined,
                      color: doc?.youLikedThis ?? false
                          ? Colors.blue
                          : Colors.white,
                    ),
                  ),
                ],
              ),
              SizedBox(width: 8),
              Column(
                children: [
                  Text(
                    '${doc?.comments?.length ?? ''}',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      showModalBottomSheet(
                        isScrollControlled: true,
                        context: context,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                          ),
                        ),
                        builder: (_) {
                          final cubit = context.read<DiscoverCubit>();
                          return StreamBuilder<DiscoverState>(
                              stream: cubit.stream,
                              builder: (context, snapshot) {
                                var doc = null;
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  doc = this.doc;
                                } else if (snapshot.connectionState ==
                                    ConnectionState.active) {
                                  doc = snapshot
                                      .data?.media?.baseMedia.docs?[index];
                                }
                                return OshinBottomModalSheet(
                                  child: CommentContent(
                                    doc: doc,
                                    index: index,
                                    onAddedComment: (text) =>
                                        cubit.commentMedia(
                                      index,
                                      text,
                                    ),
                                  ),
                                );
                              });
                        },
                      );
                    },
                    icon: Icon(
                      Icons.comment,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              SizedBox(width: 8),
              Column(
                children: [
                  Text(
                    '2.3k',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.share,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Text(
                    '2.3k',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.remove_red_eye,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              SizedBox(width: 8),
              AnimatedTextWhenCantFit(
                  str: 'Sample text, this is a super large. super mega large'),
            ],
          );
  }
}

class CommentContent extends StatelessWidget {
  final Doc? doc;
  final int index;
  final Future<void> Function(String) onAddedComment;

  CommentContent({
    this.doc,
    required this.index,
    required this.onAddedComment,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          '${doc?.comments?.length ?? ''} comments',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 20),
        Expanded(child: _CommentList(doc: doc)),
        SizedBox(height: 8),
        _CommentForm(
          doc: doc,
          index: index,
          onAddedComment: onAddedComment,
        ),
        SizedBox(height: 32),
      ],
    );
  }
}

class _CommentList extends StatelessWidget {
  final Doc? doc;
  const _CommentList({this.doc});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: CircleAvatar(
                radius: 16,
                backgroundImage: NetworkImage(
                  doc?.comments?[index].avatarUrl ?? '',
                ),
              ),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.blue, width: 3.0),
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    doc?.comments?[index].fullName ?? '',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'time',
                    style: TextStyle(color: Colors.grey[500]),
                  ),
                  SizedBox(height: 4),
                  Text(
                    doc?.comments?[index].comment ?? '',
                    softWrap: true,
                    textAlign: TextAlign.justify,
                  ),
                  SizedBox(height: 8),
                  InkWell(
                    onTap: () {},
                    child: Text(
                      'Reply',
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 24,
                  ),
                ],
              ),
            ),
          ],
        );
      },
      itemCount: (doc?.comments?.length ?? 1),
    );
  }
}

class _CommentForm extends StatefulWidget {
  final Doc? doc;
  final int index;
  final Future<void> Function(String) onAddedComment;
  const _CommentForm({
    this.doc,
    required this.index,
    required this.onAddedComment,
  });

  @override
  _CommentFormState createState() => _CommentFormState();
}

class _CommentFormState extends State<_CommentForm> {
  final commentController = TextEditingController();

  @override
  void dispose() {
    commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: TextField(
            controller: commentController,
            decoration: InputDecoration(
              isDense: true,
              floatingLabelBehavior: FloatingLabelBehavior.never,
              contentPadding: EdgeInsets.all(8),
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white54),
                borderRadius: BorderRadius.all(
                  Radius.circular(25.0),
                ),
              ),
              labelText: 'Type something',
            ),
          ),
        ),
        IconButton(
          onPressed: () {
            widget.onAddedComment(commentController.text);
            commentController.clear();
          },
          icon: Icon(
            Icons.send,
            color: Colors.blue[400],
          ),
        ),
      ],
    );
  }
}

/// Las opciones que tiene la imagen del carousell.
class CarousellOptions extends StatelessWidget {
  final Doc? doc;
  final int index;

  CarousellOptions({this.doc, required this.index});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          child: Column(
            children: [
              CarousellActions(doc: doc),
            ],
          ),
        ),
        Container(
          height: MediaQuery.of(context).size.height * 0.20,
          child: Column(
            children: [
              CarousellUserProfile(
                doc: doc,
                index: index,
              ),
              const SizedBox(height: 8),
              SocialActivities(doc: doc, index: index)
            ],
          ),
        ),
      ],
    );
  }
}
