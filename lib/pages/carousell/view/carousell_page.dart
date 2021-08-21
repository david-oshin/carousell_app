part of './carousell.dart';

/// La página del Carousell.
class CarousellPage extends StatelessWidget {
  /// El índice de donde comenzará el Carousell.
  final int index;

  /// {@macro type_of_media}
  final TypeOfMedia type;

  const CarousellPage(
    this.index,
    this.type,
  );

  @override
  Widget build(BuildContext context) {
    /// Esta widget se rearmará cada vez que se cambie la variable `docs`.
    final docs = context.watch<DiscoverCubit>().state.media?.baseMedia.docs;
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: PageView.builder(
          controller: PageController(initialPage: index),
          itemBuilder: (context, index) => _Carousell(
            index: index,
            doc: docs?[index],
          ),
          itemCount: docs?.length,
          scrollDirection: Axis.vertical,
        ),
      ),
    );
  }
}

/// Maneja los posibles estados del Carousell.
class _Carousell extends StatefulWidget {
  final int index;
  final Doc? doc;

  const _Carousell({required this.index, required this.doc});

  @override
  _CarousellState createState() => _CarousellState();
}

class _CarousellState extends State<_Carousell> {
  /// El estado de que si las opciones de la foto son visibles.
  bool _isOptionsVisible = true;

  /// El estado de que si el modal de información es visible.
  bool _isInformationModalShown = false;

  @override
  void initState() {
    super.initState();
    context.read<DiscoverCubit>().getLikes(widget.index).then(
          (_) => context.read<DiscoverCubit>().getComments(widget.index),
        );
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<DiscoverCubit>().state;
    return ModalContentNotifier(
      openModal: _notifyInformationModalChanges,
      closeModal: _notifyInformationModalChanges,
      child: Stack(
        fit: StackFit.expand,
        children: [
          GestureDetector(
            onTap: _onOutsideModalClicked,
            child: WidgetWithZoom(
              child: CarousellMedia(
                type: state.media?.type,
                doc: state.media?.baseMedia.docs?[widget.index],
              ),
            ),
          ),
          if (_isOptionsVisible)
            CarousellOptions(
              doc: state.media?.baseMedia.docs?[widget.index],
              index: widget.index,
            ),
          if (_isInformationModalShown) ..._modal()
        ],
      ),
    );
  }

  List<Widget> _modal() {
    return [
      GestureDetector(
        child: Container(color: Colors.black38),
        onTap: _onOutsideModalClicked,
      ),
      ExpandableScrollableModal(
        onModalDismiss: _notifyInformationModalChanges,
        child: InformationContent(),
      )
    ];
  }

  void _onOutsideModalClicked() {
    setState(() {
      if (_isInformationModalShown) {
        _notifyInformationModalChanges();
        return;
      }
      _isOptionsVisible = !_isOptionsVisible;
    });
  }

  void _notifyInformationModalChanges() {
    setState(() {
      _isInformationModalShown = !_isInformationModalShown;
    });
  }
}
