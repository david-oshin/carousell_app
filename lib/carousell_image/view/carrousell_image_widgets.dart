part of './carousell_image.dart';

/// La imagen el usuario ha seleccionado en el "Discover".
///
/// Cuando [imageUrl] es `null` entonces el usuario no tiene permiso de verla.
/// Este widget maneja el estado de la imagen cuando:
/// * Se esta cargando
/// * Falla la imagen al cargar
/// * Cuando ya ha cargado
class SelectedImageWidget extends StatelessWidget {
  /// La URL de la imagen.
  final String? imageUrl;

  const SelectedImageWidget({
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        color: Colors.black,
        child: imageUrl == null
            ? Text(
                'No tienes permiso de ver esta imagen',
                style: TextStyle(
                  color: Colors.white,
                ),
              )
            : Image.network(
                imageUrl!,
                errorBuilder: (context, exceptioin, stacktrace) {
                  return Text('No se pudo cargar la imagen');
                },
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) {
                    return child;
                  }
                  return Center(
                    child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                              loadingProgress.expectedTotalBytes!
                          : null,
                    ),
                  );
                },
              ),
      ),
    );
  }
}

/// Todas las acciones extras que se podrá someter tener la imagen.
class Actions extends StatelessWidget {
  /// Se ejecuta esta función al presionar el icono del menú.
  final void Function() onPressedMenu;

  const Actions({required this.onPressedMenu});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.10,
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          IconButton(
            onPressed: onPressedMenu,
            icon: Icon(
              Icons.more_vert,
              color: Colors.white,
            ),
          )
        ],
      ),
    );
  }
}

/// El contador de vistas de la foto.
class ViewCount extends StatelessWidget {
  /// La cantidad de vistas que tiene la foto.
  final int count;

  const ViewCount({required this.count});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.04,
      width: MediaQuery.of(context).size.width * 0.23,
      decoration: BoxDecoration(
        color: Colors.grey[600],
        borderRadius: BorderRadius.horizontal(
          left: Radius.circular(20),
          right: Radius.circular(20),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.remove_red_eye_sharp,
            color: Colors.white,
          ),
          SizedBox(width: 8),
          Text(
            count.toString(), // TODO: Redondear el contador de vistas.
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }
}

/// Detalles del usuario que subió la imagen.
class UserImageDetails extends StatelessWidget {
  /// La URL de la imagen del usuario.
  final String? userProfilImageUrl;

  /// El nombre del usuario.
  final String userName;

  /// Se ejecuta al presionar el botón de seguir.
  final void Function() onFollowPressed;

  const UserImageDetails({
    required this.userProfilImageUrl,
    required this.userName,
    required this.onFollowPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          child: userProfilImageUrl == null
              ? Icon(Icons.visibility_off)
              : CircleAvatar(
                  radius: 16,
                  backgroundImage: NetworkImage(
                    userProfilImageUrl!,
                  ),
                ),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: Colors.blue,
            ),
          ),
        ),
        SizedBox(width: 16),
        Text(
          userName,
          style: TextStyle(color: Colors.white),
        ),
        SizedBox(width: 16),
        TextButton(
          onPressed: onFollowPressed,
          child: Text(
            'Follow',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        )
      ],
    );
  }
}

/// Las actividades sociales que puedes someter sobre la imagen
class SocialActivities extends StatelessWidget {
  /// Se ejecuta cuando se presiona el botón de me gusta.
  final void Function() onLikedPressed;

  /// Se ejecuta cuando se presiona el botón de comentar.
  final void Function() onCommentPressed;

  /// Se ejecuta cuando se presiona el botón de compartir.
  final void Function() onSharePressed;

  /// El título de la imagen.
  final String imageCaption;

  const SocialActivities({
    required this.onLikedPressed,
    required this.onCommentPressed,
    required this.onSharePressed,
    required this.imageCaption,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: onLikedPressed,
          icon: Icon(
            Icons.thumb_up_alt_outlined,
            color: Colors.white,
          ),
        ),
        SizedBox(width: 8),
        IconButton(
          onPressed: onCommentPressed,
          icon: Icon(
            Icons.insert_comment,
            color: Colors.white,
          ),
        ),
        SizedBox(width: 8),
        IconButton(
          onPressed: onSharePressed,
          icon: Icon(
            Icons.share,
            color: Colors.white,
          ),
        ),
        SizedBox(width: 8),
        AnimatedImageCaption(imageCaption: imageCaption),
      ],
    );
  }
}

/// El título de la imagen animado.
class AnimatedImageCaption extends StatefulWidget {
  /// El título de la imagen.
  final String imageCaption;

  const AnimatedImageCaption({required this.imageCaption});

  @override
  _AnimatedImageCaptionState createState() => _AnimatedImageCaptionState();
}

class _AnimatedImageCaptionState extends State<AnimatedImageCaption>
    with SingleTickerProviderStateMixin {
  /// El controlador que se usará para ejecutar la animación.
  late final AnimationController _animationController;

  /// La duración en segundos que la animación va a tener.
  late final int _animationDuration;

  // La distancia en el eje "x" que va a recorrer la animación.
  late final double _xDistance;

  /// Indica si la segunda animación ha empezado o no.
  ///
  /// La segunda animación empieza después de que la primera
  /// animación se complete, la diferencias de estas dos es que
  /// están en dos eje "x" diferentes, o mejor dicho el
  /// parámetro `left` de [RelativeRect.fromLTRB] son diferentes.
  bool _hasSecondAnimationStarted = false;

  /// Indica si el texto es muy largo o no.
  ///
  /// Si el texto es muy largo se hará la animación, sino no se hará.
  bool _isTextTooLong = false;

  /// La animación y el tipo de animación que se hará
  late Animation<RelativeRect> _offsetAnimation;

  /// Calcula la animación basado en la longitud de [widget.imageCaption].
  ///
  /// Modifica el valor de [_animationDuration] y de [_xDistance].
  void _calculateAnimation() {
    final captionLen = widget.imageCaption.length;
    _animationDuration = captionLen ~/ 9.82;
    _xDistance = captionLen * 6.28;
  }

  /// Revisa si el [widget.imageCaption] puede caber en la pantalla.
  ///
  /// Modifica el valor de [_isTextTooLong].
  void _checkIfCanFit(double width) {
    final captionLen = widget.imageCaption.length;
    final maxLen = width / 12;
    _isTextTooLong = maxLen < captionLen;
  }

  /// Comienza la primera animación de [widget.imageCaption].
  ///
  /// Al completar la primera animación se ejecuta la segunda animación hasta
  /// por siempre.
  void _beginFirstAnimation(CurvedAnimation animationType) {
    if (!mounted) return;
    setState(() {
      _animationController.forward();
      _offsetAnimation.addStatusListener((status) {
        if (status == AnimationStatus.completed &&
            !_hasSecondAnimationStarted) {
          _beginSecondAnimation(animationType);
        }
      });
    });
  }

  /// Se modifica la 'primera animación' para crear la 'segunda animación'.
  ///
  /// La segunda animación se ejecuta por siempre y no una vez como la primera
  /// animación.
  void _beginSecondAnimation(CurvedAnimation animationType) {
    setState(() {
      // La distancia se duplica. Si _xDistance es 400 ahora recorrerá 800.
      _offsetAnimation = RelativeRectTween(
        begin: RelativeRect.fromLTRB(_xDistance, 0, 0, 0),
        end: RelativeRect.fromLTRB(-_xDistance, 0, 0, 0),
      ).animate(animationType);
      _hasSecondAnimationStarted = true;
      // Para mantener la velocidad constante se duplica además el tiempo.
      _animationController.duration = Duration(
        seconds: _animationDuration * 2,
      );
      _animationController.repeat();
    });
  }

  @override
  void initState() {
    super.initState();
    _calculateAnimation();
    _animationController = AnimationController(
      duration: Duration(seconds: _animationDuration),
      vsync: this,
    );
    final animationType = CurvedAnimation(
      parent: _animationController,
      curve: Curves.linear,
    );
    _offsetAnimation = RelativeRectTween(
      begin: RelativeRect.fromLTRB(0, 0, 0, 0),
      end: RelativeRect.fromLTRB(-_xDistance, 0, 0, 0),
    ).animate(animationType);
    Future.delayed(
      Duration(seconds: _animationDuration ~/ 2),
      () => _beginFirstAnimation(animationType),
    );
  }

  @override
  Widget build(BuildContext context) {
    _checkIfCanFit(MediaQuery.of(context).size.width);
    return Stack(
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.02,
          width: MediaQuery.of(context).size.width * 0.50,
        ),
        _isTextTooLong
            ? PositionedTransition(
                rect: _offsetAnimation,
                child: Text(
                  widget.imageCaption,
                  softWrap: false,
                  style: TextStyle(color: Colors.white),
                ),
              )
            : Text(
                widget.imageCaption,
                softWrap: false,
                style: TextStyle(color: Colors.white),
              ),
      ],
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
