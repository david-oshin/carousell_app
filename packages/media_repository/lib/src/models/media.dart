part of './models.dart';

/// La estructura del endpoint del recurso '/filtering/media'.
/// 
/// Esta clase es pura e inmutable, por lo tanto sus propiedades son 
/// "read-only".
class Media extends Equatable {
  /// La longitud de [docs].
  final int? limit;
  /// El total de [docs] que tiene el API.
  final int? total;
  /// El número totales de paginaciones
  final int? pages;
  /// Los recursos que consumirá el usuario
  final List<Docs> docs;
  /// La página actual de la paginación de [docs].
  final int? currentPage;

  Media({
    required this.limit,
    required this.total,
    required this.pages,
    required this.docs,
    required this.currentPage,
  });

  /// Devuelve una copia del objeto actual con los nuevos parámetros dados.
  Media copyWith({
    int? limit,
    int? total,
    int? pages,
    List<Docs>? docs,
    int? currentPage,
  }) {
    return Media(
      limit: limit ?? this.limit,
      total: total ?? this.total,
      pages: pages ?? this.pages,
      docs: docs ?? this.docs,
      currentPage: currentPage ?? this.currentPage,
    );
  }

  /// Convierte a un mapa el objeto actual.
  Map<String, dynamic> toMap() {
    return {
      'limit': limit,
      'total': total,
      'pages': pages,
      'docs': docs.map((x) => x.toMap()).toList(),
      'currentPage': currentPage,
    };
  }

  /// Convirte [map] a un objeto [Media].
  factory Media.fromMap(Map<String, dynamic> map) {
    return Media(
      limit: map['limit'],
      total: map['total'],
      pages: map['pages'],
      docs: List<Docs>.from(map['docs']?.map((x) => Docs.fromMap(x))),
      currentPage: map['currentPage'],
    );
  }

  /// Convierte la clase actual a una String con formato JSON.
  String toJson() => json.encode(toMap());

  /// Convierte [jsonResponse] a un objeto [Media].
  factory Media.fromJson(String jsonResponse) => Media.fromMap(json.decode(jsonResponse));

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      limit,
      total,
      pages,
      docs,
      currentPage,
    ];
  }
}

class Docs extends Equatable {
  final bool? youLikedThis;
  final String? type;
  final int? userId;
  final bool? youBoughtThis;
  final bool? youFollowThisProfile;
  final int? duration;
  final String? thumbnail;
  final String? visibility;
  final bool? youHaveThisProfileInFavorites;
  final int? id;
  final bool? youAreSubscribedToThisProfile;
  final bool? youCommentedThis;
  final bool? thisProfileHasYouInFavorites;
  final bool? youSavedThis;
  final bool? thisProfileFollowsYou;
  final bool? thisProfileIsSubscribedToYou;
  final bool? isPaid;
  final int? price;

  Docs({
    this.youLikedThis,
    this.type,
    this.userId,
    this.youBoughtThis,
    this.youFollowThisProfile,
    this.duration,
    this.thumbnail,
    this.visibility,
    this.youHaveThisProfileInFavorites,
    this.id,
    this.youAreSubscribedToThisProfile,
    this.youCommentedThis,
    this.thisProfileHasYouInFavorites,
    this.youSavedThis,
    this.thisProfileFollowsYou,
    this.thisProfileIsSubscribedToYou,
    this.isPaid,
    this.price,
  });

  Docs copyWith({
    bool? youLikedThis,
    String? type,
    int? userId,
    bool? youBoughtThis,
    bool? youFollowThisProfile,
    int? duration,
    String? thumbnail,
    String? visibility,
    bool? youHaveThisProfileInFavorites,
    int? id,
    bool? youAreSubscribedToThisProfile,
    bool? youCommentedThis,
    bool? thisProfileHasYouInFavorites,
    bool? youSavedThis,
    bool? thisProfileFollowsYou,
    bool? thisProfileIsSubscribedToYou,
    bool? isPaid,
    int? price,
  }) {
    return Docs(
      youLikedThis: youLikedThis ?? this.youLikedThis,
      type: type ?? this.type,
      userId: userId ?? this.userId,
      youBoughtThis: youBoughtThis ?? this.youBoughtThis,
      youFollowThisProfile: youFollowThisProfile ?? this.youFollowThisProfile,
      duration: duration ?? this.duration,
      thumbnail: thumbnail ?? this.thumbnail,
      visibility: visibility ?? this.visibility,
      youHaveThisProfileInFavorites:
          youHaveThisProfileInFavorites ?? this.youHaveThisProfileInFavorites,
      id: id ?? this.id,
      youAreSubscribedToThisProfile:
          youAreSubscribedToThisProfile ?? this.youAreSubscribedToThisProfile,
      youCommentedThis: youCommentedThis ?? this.youCommentedThis,
      thisProfileHasYouInFavorites:
          thisProfileHasYouInFavorites ?? this.thisProfileHasYouInFavorites,
      youSavedThis: youSavedThis ?? this.youSavedThis,
      thisProfileFollowsYou:
          thisProfileFollowsYou ?? this.thisProfileFollowsYou,
      thisProfileIsSubscribedToYou:
          thisProfileIsSubscribedToYou ?? this.thisProfileIsSubscribedToYou,
      isPaid: isPaid ?? this.isPaid,
      price: price ?? this.price,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'youLikedThis': youLikedThis,
      'type': type,
      'userId': userId,
      'youBoughtThis': youBoughtThis,
      'youFollowThisProfile': youFollowThisProfile,
      'duration': duration,
      'thumbnail': thumbnail,
      'visibility': visibility,
      'youHaveThisProfileInFavorites': youHaveThisProfileInFavorites,
      'id': id,
      'youAreSubscribedToThisProfile': youAreSubscribedToThisProfile,
      'youCommentedThis': youCommentedThis,
      'thisProfileHasYouInFavorites': thisProfileHasYouInFavorites,
      'youSavedThis': youSavedThis,
      'thisProfileFollowsYou': thisProfileFollowsYou,
      'thisProfileIsSubscribedToYou': thisProfileIsSubscribedToYou,
      'isPaid': isPaid,
      'price': price,
    };
  }

  factory Docs.fromMap(Map<String, dynamic> map) {
    return Docs(
      youLikedThis: map['youLikedThis'],
      type: map['type'],
      userId: map['userId'],
      youBoughtThis: map['youBoughtThis'],
      youFollowThisProfile: map['youFollowThisProfile'],
      duration: map['duration'],
      thumbnail: map['thumbnail'],
      visibility: map['visibility'],
      youHaveThisProfileInFavorites: map['youHaveThisProfileInFavorites'],
      id: map['id'],
      youAreSubscribedToThisProfile: map['youAreSubscribedToThisProfile'],
      youCommentedThis: map['youCommentedThis'],
      thisProfileHasYouInFavorites: map['thisProfileHasYouInFavorites'],
      youSavedThis: map['youSavedThis'],
      thisProfileFollowsYou: map['thisProfileFollowsYou'],
      thisProfileIsSubscribedToYou: map['thisProfileIsSubscribedToYou'],
      isPaid: map['isPaid'],
      price: map['price'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Docs.fromJson(String source) => Docs.fromMap(json.decode(source));

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      youLikedThis,
      type,
      userId,
      youBoughtThis,
      youFollowThisProfile,
      duration,
      thumbnail,
      visibility,
      youHaveThisProfileInFavorites,
      id,
      youAreSubscribedToThisProfile,
      youCommentedThis,
      thisProfileHasYouInFavorites,
      youSavedThis,
      thisProfileFollowsYou,
      thisProfileIsSubscribedToYou,
      isPaid,
      price,
    ];
  }
}

/// El tipo de [Media].
enum MediaType { image, video, audio }

/// Métodos que se puede ejecutar sobre el [MediaType].
extension MediaTypeMethods on MediaType {
  /// Retorna el [MediaType] elegido como un `Stirng`.
  String get name => this.toString().split('.')[1];
}

/// Documentar [Docs]