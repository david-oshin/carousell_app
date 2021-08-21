part of './models.dart';

/// La estructura del endpoint del recurso '/filtering/media'.
class BaseMedia extends Equatable {
  /// La página actual de la paginación de [docs].
  final int? currentPage;

  /// Los recursos que consumirá el usuario
  final List<Doc>? docs;

  /// La longitud de [docs].
  final int? limit;

  /// El número totales de paginaciones
  final int? pages;

  /// El total de [docs] que tiene el API.
  final int? total;

  const BaseMedia._({
    required this.currentPage,
    required this.docs,
    required this.limit,
    required this.pages,
    required this.total,
  });

  BaseMedia copyWith({
    int? currentPage,
    List<Doc>? docs,
    int? limit,
    int? pages,
    int? total,
  }) =>
      BaseMedia._(
        currentPage: currentPage ?? this.currentPage,
        docs: docs ?? this.docs,
        limit: limit ?? this.limit,
        pages: pages ?? this.pages,
        total: total ?? this.total,
      );

  /// Convierte [source] a un objeto [BaseMedia].
  ///
  /// Asegúrate de que [source] tenga formato JSON.
  factory BaseMedia._fromJson(String source) =>
      BaseMedia._fromMap(json.decode(source));

  factory BaseMedia._fromMap(Map<String, dynamic> map) => BaseMedia._(
        currentPage: map['current_page'],
        docs: List<Doc>.from(map['docs']?.map((x) => Doc.fromMap(x))),
        limit: map['limit'],
        pages: map['pages'],
        total: map['total'],
      );

  /// Convierte esto a un texto con formato JSON.
  String toJson() => json.encode(toMap());

  /// Convierte esto a un `Map<String, dynamic>`.
  Map<String, dynamic> toMap() => {
        'current_page': currentPage,
        'docs': docs?.map((x) => x.toMap()).toList(),
        'limit': limit,
        'pages': pages,
        'total': total,
      };

  @override
  List<Object?> get props => [
        currentPage,
        docs,
        limit,
        pages,
        total,
      ];
}

class Doc extends Equatable {
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
  final double? price;
  final int? likes;
  final List<Comment>? comments;

  Doc({
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
    this.likes,
    this.comments,
  });

  Doc copyWith({
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
    double? price,
    int? likes,
    List<Comment>? comments,
  }) =>
      Doc(
          youLikedThis: youLikedThis ?? this.youLikedThis,
          type: type ?? this.type,
          userId: userId ?? this.userId,
          youBoughtThis: youBoughtThis ?? this.youBoughtThis,
          youFollowThisProfile:
              youFollowThisProfile ?? this.youFollowThisProfile,
          duration: duration ?? this.duration,
          thumbnail: thumbnail ?? this.thumbnail,
          visibility: visibility ?? this.visibility,
          youHaveThisProfileInFavorites: youHaveThisProfileInFavorites ??
              this.youHaveThisProfileInFavorites,
          id: id ?? this.id,
          youAreSubscribedToThisProfile: youAreSubscribedToThisProfile ??
              this.youAreSubscribedToThisProfile,
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
          likes: likes ?? this.likes,
          comments: comments ?? this.comments);

  factory Doc.empty() => Doc();

  Map<String, dynamic> toMap() => {
        'you_liked_this': youLikedThis,
        'type': type,
        'user_id': userId,
        'you_bought_this': youBoughtThis,
        'you_follow_this_profile': youFollowThisProfile,
        'duration': duration,
        'thumbnail': thumbnail,
        'visibility': visibility,
        'you_have_this_profile_in_favorites': youHaveThisProfileInFavorites,
        'id': id,
        'you_are_subscribed_to_this_profile': youAreSubscribedToThisProfile,
        'you_commented_this': youCommentedThis,
        'this_profile_has_you_in_favorites': thisProfileHasYouInFavorites,
        'you_saved_this': youSavedThis,
        'this_profile_follows_you': thisProfileFollowsYou,
        'this_profile_is_subscribed_to_you': thisProfileIsSubscribedToYou,
        'is_paid': isPaid,
        'price': price,
        'likes': likes,
        'comments': comments?.map((x) => x.toMap()).toList(),
      };

  factory Doc.fromMap(Map<String, dynamic> map) => Doc(
        youLikedThis: map['you_liked_this'],
        type: map['type'],
        userId: map['user_id'],
        youBoughtThis: map['you_bought_this'],
        youFollowThisProfile: map['you_follow_this_profile'],
        duration: map['duration'],
        thumbnail: map['thumbnail'],
        visibility: map['visibility'],
        youHaveThisProfileInFavorites:
            map['you_have_this_profile_in_favorites'],
        id: map['id'],
        youAreSubscribedToThisProfile:
            map['you_are_subscribed_to_this_profile'],
        youCommentedThis: map['you_commented_this'],
        thisProfileHasYouInFavorites: map['this_profile_has_you_in_favorites'],
        youSavedThis: map['you_saved_this'],
        thisProfileFollowsYou: map['this_profile_follows_you'],
        thisProfileIsSubscribedToYou: map['this_profile_is_subscribed_to_you'],
        isPaid: map['is_paid'],
        price: map['price'],
        likes: map['likes'],
        comments: map['comments'],
      );

  String toJson() => json.encode(toMap());

  factory Doc.fromJson(String source) => Doc.fromMap(json.decode(source));

  @override
  List<Object?> get props => [
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
        likes,
        comments
      ];
}

class Comment extends Equatable {
  final int? id;
  final String? comment;
  final String? avatarUrl;
  final String? fullName;

  Comment._({
    required this.id,
    required this.comment,
    required this.avatarUrl,
    required this.fullName,
  });

  Comment copyWith({
    int? id,
    String? comment,
    String? avatarUrl,
    String? fullName,
  }) =>
      Comment._(
        id: id ?? this.id,
        comment: comment ?? this.comment,
        avatarUrl: avatarUrl ?? this.avatarUrl,
        fullName: fullName ?? this.fullName,
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'avatarUrl': avatarUrl,
        'fullName': fullName,
        'comment': comment,
      };

  factory Comment.fromMap(Map<String, dynamic> map) => Comment._(
        id: map['id'],
        comment: map['comment'],
        fullName: map['fullName'],
        avatarUrl: map['avatarUrl'],
      );

  String toJson() => json.encode(toMap());

  factory Comment.fromJson(String source) =>
      Comment.fromMap(json.decode(source));

  @override
  List<Object?> get props => [id, comment, fullName, avatarUrl];
}

class Media extends Equatable {
  final TypeOfMedia type;
  final BaseMedia baseMedia;

  const Media._({
    required this.type,
    required this.baseMedia,
  });

  factory Media.fromJson(TypeOfMedia type, String source) =>
      Media.fromMap(type, json.decode(source));

  factory Media.fromMap(TypeOfMedia type, Map<String, dynamic> map) =>
      Media._(type: type, baseMedia: BaseMedia._fromMap(map));

  Media copyWith({TypeOfMedia? type, BaseMedia? baseMedia}) =>
      Media._(type: type ?? this.type, baseMedia: baseMedia ?? this.baseMedia);

  @override
  List<Object?> get props => [type, baseMedia];
}
