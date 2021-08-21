part of 'utils.dart';

/// Le da funcionalidad de zoom a un [Widget].
class WidgetWithZoom extends StatefulWidget {
  /// El hijo que va a tener zoom.
  final Widget? child;

  const WidgetWithZoom({
    required this.child,
  });

  @override
  _WidgetWithZoomState createState() => _WidgetWithZoomState();
}

class _WidgetWithZoomState extends State<WidgetWithZoom>
    with TickerProviderStateMixin {
  late final TransformationController _transformationController;
  late final Animation<Matrix4> _animationReset;
  late final AnimationController _controllerReset;

  void _onAnimateReset() {
    _transformationController.value = _animationReset.value;
    if (!_controllerReset.isAnimating) {
      _animationReset.removeListener(_onAnimateReset);
      _controllerReset.reset();
    }
  }

  void _onInteractionStart(ScaleStartDetails details) {
    if (_controllerReset.status == AnimationStatus.forward) {
      _controllerReset.stop();
      _animationReset.removeListener(_onAnimateReset);
      _controllerReset.reset();
    }
  }

  void _onInteractionEnd(ScaleEndDetails details) {
    _controllerReset.reset();
    _animationReset = Matrix4Tween(
      begin: _transformationController.value,
      end: Matrix4.identity(),
    ).animate(_controllerReset);
    _animationReset.addListener(_onAnimateReset);
    _controllerReset.forward();
  }

  @override
  void initState() {
    super.initState();
    _controllerReset = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _transformationController = TransformationController();
  }

  @override
  void dispose() {
    _controllerReset.dispose();
    _transformationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: InteractiveViewer(
        transformationController: _transformationController,
        minScale: 1.0,
        maxScale: 2.5,
        onInteractionStart: _onInteractionStart,
        onInteractionEnd: _onInteractionEnd,
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: Colors.black,
          child: widget.child == null ? const ChildIsNull() : widget.child,
        ),
      ),
    );
  }
}

/// Se debe usar este widget cuando el hijo de un widget sea nulo.
///
///
/// Como por ejemplo:
/// ```dart
/// imageUrl == null ? ChildIsNull() : Image.network(imageUrl)
/// ```
class ChildIsNull extends StatelessWidget {
  /// Se ejecuta cuando el usuario quiere reintentar una acción que ha fallado o
  /// fue inesperada.
  final void Function()? onReloadPressed;

  const ChildIsNull({this.onReloadPressed});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.error,
          color: Colors.white,
          size: 50,
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.02),
        Text(
          'Ha pasado un error interno en la app, intente nuevamente...',
          style: Theme.of(context).textTheme.headline3,
        ),
        TextButton(
          onPressed: onReloadPressed,
          child: Text(
            'Reintentar',
            style: Theme.of(context).textTheme.headline3,
          ),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.resolveWith<Color>((states) {
              return Colors.blue;
            }),
          ),
        ),
      ],
    );
  }
}

/// En texto animado para cuando el text no puede cubrir en pantalla.
///
/// TODO: Probar este test individualmente.
class AnimatedTextWhenCantFit extends StatefulWidget {
  /// El texto a animar.
  final String str;

  const AnimatedTextWhenCantFit({required this.str});

  @override
  _AnimatedTextWhenCantFitState createState() =>
      _AnimatedTextWhenCantFitState();
}

class _AnimatedTextWhenCantFitState extends State<AnimatedTextWhenCantFit>
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

  /// La animación y el tipo de animación que se hará
  late Animation<RelativeRect> _offsetAnimation;

  /// Calcula la animación basado en la longitud de [widget.str].
  ///
  /// Modifica el valor de [_animationDuration] y de [_xDistance].
  void _calculateAnimation() {
    final captionLen = widget.str.length;
    _animationDuration = captionLen ~/ 9.82;
    _xDistance = captionLen * 6.28;
  }

  /// Comienza la primera animación de [widget.str].
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
      // La distancia crece un 50%.
      _offsetAnimation = RelativeRectTween(
        begin: RelativeRect.fromLTRB(_xDistance * 0.5, 0, 0, 0),
        end: RelativeRect.fromLTRB(-_xDistance, 0, 0, 0),
      ).animate(animationType);
      _hasSecondAnimationStarted = true;
      // Para mantener la velocidad constante se duplica además el tiempo.
      _animationController.duration = Duration(
        seconds: _animationDuration * 2,
      );
      // Cuando se acabe la primera animación, la segunda "repite" por siempre.
      _animationController.repeat();
    });
  }

  @override
  void initState() {
    super.initState();
    _calculateAnimation();
    _animationController = AnimationController(
      duration: Duration(seconds: (_animationDuration * 1.6).toInt()),
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
    return Stack(
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.02,
          width: MediaQuery.of(context).size.width * 0.40,
        ),
        PositionedTransition(
          rect: _offsetAnimation,
          child: Text(
            widget.str,
            softWrap: false,
            style: TextStyle(color: Colors.white),
          ),
        )
      ],
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}

/// Un modal que puede crecer y disminuir en el eje y.
class ExpandableScrollableModal extends StatefulWidget {
  /// El contenido de esto.
  final Widget child;

  /// Se ejecuta al cerrar este modal.
  final void Function()? onModalDismiss;

  const ExpandableScrollableModal({
    required this.child,
    this.onModalDismiss,
  });

  @override
  _ExpandableScrollableModalState createState() =>
      _ExpandableScrollableModalState();
}

class _ExpandableScrollableModalState extends State<ExpandableScrollableModal> {
  bool scrollControllerHasNoListeners = true;

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      expand: true,
      minChildSize: 0.00,
      builder: (context, scrollController) {
        if (scrollControllerHasNoListeners) {
          scrollControllerHasNoListeners = false;
          scrollController.addListener(() {
            if (scrollController.position.pixels == -1.0) {
              final e = widget.onModalDismiss;
              if (e != null) e();
            }
          });
        }
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.horizontal(
              left: Radius.circular(20),
              right: Radius.circular(20),
            ),
          ),
          child: Column(
            children: [
              SingleChildScrollView(
                controller: scrollController,
                physics: const ClampingScrollPhysics(),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.20,
                      height: MediaQuery.of(context).size.height * 0.008,
                      decoration: const BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.horizontal(
                          left: Radius.circular(25),
                          right: Radius.circular(25),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              widget.child,
            ],
          ),
        );
      },
    );
  }
}

/// Un borde circular discontinuo que se le puede agregar a cualquier widget.
///
/// TODO: Hacer que [child] se comporte como un círculo.
class CircularBorder extends StatelessWidget {
  ///  El color del borde.
  final Color color;

  /// El diámetro del círculo.
  final double diameter;

  /// El grosor del borde.
  final double strokeWidth;

  /// El hijo del que tendrá esto.
  final Widget child;

  /// El número de ocurrencias de arcos que tendrá el borde.
  ///
  /// El espaciado entre los arcos es calculado automáticamente.
  final int arcOcurrences;

  /// El tamaño que hay entre [child] y la circuferencia del borde.
  final int borderPadding;

  /// El margen del borde.
  final EdgeInsetsGeometry margin;

  const CircularBorder({
    this.color = Colors.amber,
    this.diameter = 70,
    this.strokeWidth = 4.0,
    this.margin = const EdgeInsets.symmetric(horizontal: 16),
    this.borderPadding = 8,
    this.arcOcurrences = 16,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: diameter,
      width: diameter,
      alignment: Alignment.center,
      margin: margin,
      child: Stack(
        alignment: Alignment.center,
        children: [
          child,
          CustomPaint(
            size: Size(diameter, diameter),
            foregroundPainter: _DashedBorderPaint(
              color: color,
              strokeWidth: strokeWidth,
              ocurrences: arcOcurrences,
              borderPadding: borderPadding,
            ),
          ),
        ],
      ),
    );
  }
}

/// Un pintado customizado que crea un borde discontinuo.
class _DashedBorderPaint extends CustomPainter {
  /// El color del borde
  final Color color;

  /// El grosor del borde.
  final double strokeWidth;

  /// El número de líneas discontinuas que tendrá el borde.
  ///
  /// El espacio entre ellas es automáticamente calculado, comienza a crearse
  /// desde `pi` radian.
  final int ocurrences;

  /// Se le agrega al radio calculado para dar la ilusión de un "padding".
  final int borderPadding;

  const _DashedBorderPaint({
    required this.color,
    required this.strokeWidth,
    required this.ocurrences,
    required this.borderPadding,
  });

  @override
  void paint(Canvas canvas, Size size) {
    Paint p1 = Paint()
      ..color = color
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    final origin = Offset(size.width / 2, size.height / 2);
    final radius = min(size.width / 2, size.height / 2) + borderPadding;
    final arcLen = pi / ocurrences;
    var radianAngle = pi - arcLen;
    for (var i = 0; i < (ocurrences * 2); i++) {
      radianAngle += arcLen;
      if (i % 2 != 0) continue;
      canvas.drawArc(
        Rect.fromCircle(center: origin, radius: radius),
        radianAngle,
        arcLen,
        false,
        p1,
      );
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

// TODO: Implement Play/Pause button and finish this widget
class OshinVideo extends StatefulWidget {
  @override
  _OshinVideoState createState() => _OshinVideoState();
}

class _OshinVideoState extends State<OshinVideo>
    with SingleTickerProviderStateMixin {
  late final VideoPlayerController _controller;
  late final AnimationController _progress;
  var _isDragging = false;
  var _hasEnded = false;

  @override
  void initState() {
    super.initState();
    _progress = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 450),
    );
    _controller = VideoPlayerController.network(
      'https://d38oxbb75e38f6.cloudfront.net/uploads/user_1769/video/c2a03ebf-739b-4bca-8de4-5c5b17f9275c.mp4',
    )..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized,
        // even before the play button has been pressed.
        setState(() {});
      });
    _controller.addListener(() {
      //custom Listner
      setState(() {
        if (!_controller.value.isPlaying &&
            _controller.value.isInitialized &&
            (_controller.value.duration == _controller.value.position)) {
          //Video Completed//
          setState(() {
            _hasEnded = true;
          });
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_controller.value.isInitialized) {
      return Stack(
        alignment: AlignmentDirectional.center,
        children: [
          GestureDetector(
            onHorizontalDragStart: (_) {
              setState(() {
                _isDragging = true;
              });
            },
            onHorizontalDragEnd: (_) {
              setState(() {
                _isDragging = false;
              });
            },
            child: AspectRatio(
              aspectRatio: _controller.value.aspectRatio,
              child: VideoPlayer(_controller),
            ),
          ),
          OshinVideoProgressIndicator(
            height: _isDragging ? 16 : 8,
            controller: _controller,
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                var isPlaying = _controller.value.isPlaying;
                if (isPlaying) {
                  _controller.pause();
                } else {
                  _controller.play();
                }
                isPlaying ? _progress.reverse() : _progress.forward();
              });
            },
            child: Container(
              height: MediaQuery.of(context).size.height * 0.1,
              width: MediaQuery.of(context).size.height * 0.1,
              child: _hasEnded
                  ? IconButton(
                      icon: Icon(
                        Icons.replay,
                        color: Colors.white,
                        size: MediaQuery.of(context).size.height * 0.05,
                      ),
                      onPressed: () {
                        setState(() {
                          _hasEnded = false;
                          _controller.play();
                        });
                      },
                    )
                  : Center(
                      child: AnimatedIcon(
                        icon: AnimatedIcons.play_pause,
                        progress: _progress,
                        color: Colors.white,
                        size: MediaQuery.of(context).size.height * 0.05,
                      ),
                    ),
              decoration: BoxDecoration(
                color: Colors.white54,
                shape: BoxShape.circle,
              ),
            ),
          )
        ],
      );
    }
    // TODO: Replace with OshinProgressIndicator.
    return Center(child: CircularProgressIndicator());
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class OshinVideoProgressIndicator extends StatelessWidget {
  final VideoPlayerController controller;
  final double? height;
  final EdgeInsets? padding;

  const OshinVideoProgressIndicator(
      {required this.controller, this.height, this.padding});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 8,
      child: VideoProgressIndicator(
        controller,
        allowScrubbing: true,
        padding: padding ?? EdgeInsets.symmetric(horizontal: 16),
        colors: VideoProgressColors(
          backgroundColor: Colors.white,
          bufferedColor: Colors.blue[100]!,
          playedColor: Colors.blue,
        ),
      ),
    );
  }
}

/// El diseño que debe tener un [showModalBottomSheet].
///
/// Nota: Esto **no** es un [BottomSheet].
class OshinBottomModalSheet extends StatelessWidget {
  /// El hijo del que tendrá esto.
  final Widget child;

  const OshinBottomModalSheet({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.80,
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        top: 24,
        left: 16,
        right: 16,
      ),
      child: child,
    );
  }
}
