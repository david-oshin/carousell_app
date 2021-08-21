part of 'models.dart';

class User extends Equatable {
  final int? id;
  final String? birthDate;
  final String? firstName;
  final String? lastName;
  final String? email;
  final bool? emailIsVerified;
  final String? userName;
  final String? url;
  final int? age;
  final String? gender;
  final String? type;
  final String? name;
  final String? companyName;
  final String? phoneNumber;
  final String? phoneNumberDialCode;
  final bool? phoneIsVerified;
  final String? aboutMe;
  final String? homeTown;
  final String? createdAt;
  final int? birthDay;
  final int? birthYear;
  final String? birthMonth;
  final String? emailVisibility;
  final String? phoneNumberVisibility;
  final String? foundationDateVisibility;
  final String? ceoVisibility;
  final bool? canUpdateName;
  final bool? canUpdateBirthdate;
  final String? foundationDate;
  final String? ceo;
  final String? isCurrentlyOpen;
  final Type? currentlyIn;
  final String? address;
  final int? roleID;
  final String? orginallyForm;
  final int? totalFollowers;
  final int? totalFollowing;
  final int? totalFavorites;
  final bool? hasTwoFactor;
  final bool? membershipIsActive;
  final bool? hasTiers;
  final bool? canUpdateUsername;
  final bool? canUpdateCompanyName;
  final String? insightsVisibility;
  final String? displayName;
  final bool? youFollowThisPrfile;
  final bool? thisProfileFollowsYou;
  final bool? youHaveThisProfileInFavorites;
  final bool? thisProfileHasYouInFavorites;
  final bool? youAreSubscribedToThisProfile;
  final bool? thisProfileIsSubscribedToYou;
  final bool? hasProfile;

  User({
    required this.id,
    required this.birthDate,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.emailIsVerified,
    required this.userName,
    required this.url,
    required this.age,
    required this.gender,
    required this.type,
    required this.name,
    required this.companyName,
    required this.phoneNumber,
    required this.phoneNumberDialCode,
    required this.phoneIsVerified,
    required this.aboutMe,
    required this.homeTown,
    required this.createdAt,
    required this.birthDay,
    required this.birthYear,
    required this.birthMonth,
    required this.emailVisibility,
    required this.phoneNumberVisibility,
    required this.foundationDateVisibility,
    required this.ceoVisibility,
    required this.canUpdateName,
    required this.canUpdateBirthdate,
    required this.foundationDate,
    required this.ceo,
    required this.isCurrentlyOpen,
    required this.currentlyIn,
    required this.address,
    required this.roleID,
    required this.orginallyForm,
    required this.totalFollowers,
    required this.totalFollowing,
    required this.totalFavorites,
    required this.hasTwoFactor,
    required this.membershipIsActive,
    required this.hasTiers,
    required this.canUpdateUsername,
    required this.canUpdateCompanyName,
    required this.insightsVisibility,
    required this.displayName,
    required this.youFollowThisPrfile,
    required this.thisProfileFollowsYou,
    required this.youHaveThisProfileInFavorites,
    required this.thisProfileHasYouInFavorites,
    required this.youAreSubscribedToThisProfile,
    required this.thisProfileIsSubscribedToYou,
    required this.hasProfile,
  });

  User copyWith({
    int? id,
    String? birthDate,
    String? firstName,
    String? lastName,
    String? email,
    bool? emailIsVerified,
    String? userName,
    String? url,
    int? age,
    String? gender,
    String? type,
    String? name,
    String? companyName,
    String? phoneNumber,
    String? phoneNumberDialCode,
    bool? phoneIsVerified,
    String? aboutMe,
    String? homeTown,
    String? createdAt,
    int? birthDay,
    int? birthYear,
    String? birthMonth,
    String? emailVisibility,
    String? phoneNumberVisibility,
    String? foundationDateVisibility,
    String? ceoVisibility,
    bool? canUpdateName,
    bool? canUpdateBirthDate,
    String? foundationDate,
    String? ceo,
    String? isCurrentlyOpen,
    Type? currentlyIn,
    String? address,
    int? roleId,
    int? totalFollowers,
    int? totalFollowing,
    int? totalFavorites,
    bool? hasTwoFactor,
    bool? membershipIsActive,
    bool? hasTiers,
    bool? canUpdateUsername,
    bool? canUpdateCompanyName,
    String? insightsVisibility,
    String? displayName,
    bool? youFollowThisProfile,
    bool? thisProfileFollowsYou,
    bool? youHaveThisProfileInFavorites,
    bool? thisProfileHasYouInFavorites,
    bool? youAreSubscribedToThisProfile,
    bool? thisProfileIsSubscribedToYou,
    bool? hasProfile,
    String? orginallyForm,
  }) {
    return User(
      id: id ?? this.id,
      birthDate: birthDate ?? this.birthDate,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      emailIsVerified: emailIsVerified ?? this.emailIsVerified,
      userName: userName ?? this.userName,
      url: url ?? this.url,
      age: age ?? this.age,
      gender: gender ?? this.gender,
      type: type ?? this.type,
      name: name ?? this.name,
      companyName: companyName ?? this.companyName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      phoneNumberDialCode: phoneNumberDialCode ?? this.phoneNumberDialCode,
      phoneIsVerified: phoneIsVerified ?? this.phoneIsVerified,
      aboutMe: aboutMe ?? this.aboutMe,
      homeTown: homeTown ?? this.homeTown,
      createdAt: createdAt ?? this.createdAt,
      birthDay: birthDay ?? this.birthDay,
      birthYear: birthYear ?? this.birthYear,
      birthMonth: birthMonth ?? this.birthMonth,
      emailVisibility: emailVisibility ?? this.emailVisibility,
      phoneNumberVisibility:
          phoneNumberVisibility ?? this.phoneNumberVisibility,
      foundationDateVisibility:
          foundationDateVisibility ?? this.foundationDateVisibility,
      ceoVisibility: ceoVisibility ?? this.ceoVisibility,
      canUpdateName: canUpdateName ?? this.canUpdateName,
      canUpdateBirthdate: canUpdateBirthDate ?? this.canUpdateBirthdate,
      foundationDate: foundationDate ?? this.foundationDate,
      ceo: ceo ?? this.ceo,
      isCurrentlyOpen: isCurrentlyOpen ?? this.isCurrentlyOpen,
      currentlyIn: currentlyIn ?? this.currentlyIn,
      address: address ?? this.address,
      roleID: roleId ?? this.roleID,
      totalFollowers: totalFollowers ?? this.totalFollowers,
      totalFollowing: totalFollowing ?? this.totalFollowing,
      totalFavorites: totalFavorites ?? this.totalFavorites,
      hasTwoFactor: hasTwoFactor ?? this.hasTwoFactor,
      membershipIsActive: membershipIsActive ?? this.membershipIsActive,
      hasTiers: hasTiers ?? this.hasTiers,
      canUpdateUsername: canUpdateUsername ?? this.canUpdateUsername,
      canUpdateCompanyName: canUpdateCompanyName ?? this.canUpdateCompanyName,
      insightsVisibility: insightsVisibility ?? this.insightsVisibility,
      displayName: displayName ?? this.displayName,
      youFollowThisPrfile: youFollowThisProfile ?? this.youFollowThisPrfile,
      thisProfileFollowsYou:
          thisProfileFollowsYou ?? this.thisProfileFollowsYou,
      youHaveThisProfileInFavorites:
          youHaveThisProfileInFavorites ?? this.youHaveThisProfileInFavorites,
      thisProfileHasYouInFavorites:
          thisProfileHasYouInFavorites ?? this.thisProfileHasYouInFavorites,
      youAreSubscribedToThisProfile:
          youAreSubscribedToThisProfile ?? this.youAreSubscribedToThisProfile,
      thisProfileIsSubscribedToYou:
          thisProfileIsSubscribedToYou ?? this.thisProfileIsSubscribedToYou,
      hasProfile: hasProfile ?? this.hasProfile,
      orginallyForm: orginallyForm ?? this.orginallyForm,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'birth_date': birthDate,
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'email_is_verified': emailIsVerified,
      'username': userName,
      'url': url,
      'age': age,
      'gender': gender,
      'type': type,
      'name': name,
      'company_name': companyName,
      'phone_number': phoneNumber,
      'phone_number_dial_code': phoneNumberDialCode,
      'phone_is_verified': phoneIsVerified,
      'about_me': aboutMe,
      'home_town': homeTown,
      'created_at': createdAt,
      'birth_day': birthDay,
      'birth_year': birthYear,
      'birth_month': birthMonth,
      'email_visibility': emailVisibility,
      'phone_number_visibility': phoneNumberVisibility,
      'foundation_date_visibility': foundationDateVisibility,
      'ceo_visibility': ceoVisibility,
      'can_update_name': canUpdateName,
      'can_update_birth_date': canUpdateBirthdate,
      'foundation_date': foundationDate,
      'ceo': ceo,
      'is_currently_open': isCurrentlyOpen,
      'currently_in': currentlyIn,
      'address': address,
      'role_id': roleID,
      'originally_from': orginallyForm,
      'total_followers': totalFollowers,
      'total_following': totalFollowing,
      'total_favorites': totalFavorites,
      'has_two_factor': hasTwoFactor,
      'membership_is_active': membershipIsActive,
      'has_tiers': hasTiers,
      'can_update_username': canUpdateUsername,
      'can_update_company_name': canUpdateCompanyName,
      'insights_visibility': insightsVisibility,
      'display_name': displayName,
      'you_follow_this_profile': youFollowThisPrfile,
      'this_profile_follows_you': thisProfileFollowsYou,
      'you_have_this_profile_in_favorites': youHaveThisProfileInFavorites,
      'this_profile_has_you_in_favorites': thisProfileHasYouInFavorites,
      'you_are_subscribed_to_this_profile': youAreSubscribedToThisProfile,
      'this_profile_is_subscribed_to_you': thisProfileIsSubscribedToYou,
      'has_profile': hasProfile,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      birthDate: map['birth_date'],
      firstName: map['first_name'],
      lastName: map['last_name'],
      email: map['email'],
      emailIsVerified: map['email_is_verified'],
      userName: map['username'],
      url: map['url'],
      age: map['age'],
      gender: map['gender'],
      type: map['type'],
      name: map['name'],
      companyName: map['company_name'],
      phoneNumber: map['phone_number'],
      phoneNumberDialCode: map['phone_number_dial_code'],
      phoneIsVerified: map['phone_is_verified'],
      aboutMe: map['about_me'],
      createdAt: map['created_at'],
      birthDay: map['birth_day'],
      birthYear: map['birth_year'],
      birthMonth: map['birth_month'],
      emailVisibility: map['email_visibility'],
      phoneNumberVisibility: map['phone_number_visibility'],
      foundationDateVisibility: map['foundation_date_visibility'],
      ceoVisibility: map['ceo_visibility'],
      canUpdateName: map['can_update_name'],
      canUpdateBirthdate: map['can_update_birth_date'],
      foundationDate: map['foundation_date'],
      ceo: map['ceo'],
      isCurrentlyOpen: map['is_currently_open'],
      currentlyIn: map['currently_in'],
      address: map['address'],
      roleID: map['role_id'],
      orginallyForm: map['originally_from'],
      totalFollowers: map['total_followers'],
      totalFollowing: map['total_following'],
      totalFavorites: map['total_favorites'],
      hasTwoFactor: map['has_two_factor'],
      membershipIsActive: map['membership_is_active'],
      hasTiers: map['has_tiers'],
      canUpdateUsername: map['can_update_username'],
      canUpdateCompanyName: map['can_update_company_name'],
      insightsVisibility: map['insights_visibility'],
      displayName: map['display_name'],
      youFollowThisPrfile: map['you_follow_this_profile'],
      thisProfileFollowsYou: map['this_profile_follows_you'],
      youHaveThisProfileInFavorites: map['you_have_this_profile_in_favorites'],
      thisProfileHasYouInFavorites: map['this_profile_has_you_in_favorites'],
      youAreSubscribedToThisProfile: map['you_are_subscribed_to_this_profile'],
      thisProfileIsSubscribedToYou: map['this_profile_is_subscribed_to_you'],
      hasProfile: map['has_profile'],
      homeTown: '',
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));

  @override
  List<Object?> get props => [
        id,
        birthDate,
        firstName,
        lastName,
        email,
        emailIsVerified,
        userName,
        url,
        age,
        gender,
        type,
        name,
        companyName,
        phoneNumber,
        phoneNumberDialCode,
        phoneIsVerified,
        aboutMe,
        homeTown,
        createdAt,
        birthDay,
        birthYear,
        birthMonth,
        emailVisibility,
        phoneNumberVisibility,
        foundationDateVisibility,
        ceoVisibility,
        canUpdateName,
        canUpdateBirthdate,
        foundationDate,
        ceo,
        isCurrentlyOpen,
        currentlyIn,
        address,
        roleID,
        orginallyForm,
        totalFollowers,
        totalFollowing,
        totalFavorites,
        hasTwoFactor,
        membershipIsActive,
        hasTiers,
        canUpdateUsername,
        canUpdateCompanyName,
        insightsVisibility,
        displayName,
        youFollowThisPrfile,
        thisProfileFollowsYou,
        youHaveThisProfileInFavorites,
        thisProfileHasYouInFavorites,
        youAreSubscribedToThisProfile,
        thisProfileIsSubscribedToYou,
        hasProfile,
      ];
}

class BirthVisibility extends Equatable {
  final String age;
  final String birthDay;
  final String birthYear;

  BirthVisibility({
    required this.age,
    required this.birthDay,
    required this.birthYear,
  });

  BirthVisibility copyWith({
    String? age,
    String? birthDay,
    String? birthYear,
  }) {
    return BirthVisibility(
      age: age ?? this.age,
      birthDay: birthDay ?? this.birthDay,
      birthYear: birthYear ?? this.birthYear,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'age': age,
      'birth_day': birthDay,
      'birth_year': birthYear,
    };
  }

  factory BirthVisibility.fromMap(Map<String, dynamic> map) {
    return BirthVisibility(
      age: map['age'],
      birthDay: map['birth_day'],
      birthYear: map['birth_year'],
    );
  }

  String toJson() => json.encode(toMap());

  factory BirthVisibility.fromJson(String source) =>
      BirthVisibility.fromMap(json.decode(source));

  @override
  List<Object?> get props => [age, birthDay, birthYear];
}

class Type extends Equatable {
  final String country;
  final String city;
  final String country_code;

  Type({
    required this.country,
    required this.city,
    required this.country_code,
  });

  Type copyWith({
    String? country,
    String? city,
    String? country_code,
  }) {
    return Type(
      country: country ?? this.country,
      city: city ?? this.city,
      country_code: country_code ?? this.country_code,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'country': country,
      'city': city,
      'country_code': country_code,
    };
  }

  factory Type.fromMap(Map<String, dynamic> map) {
    return Type(
      country: map['country'],
      city: map['city'],
      country_code: map['country_code'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Type.fromJson(String source) => Type.fromMap(json.decode(source));

  @override
  List<Object?> get props => [country, city, country_code];
}
