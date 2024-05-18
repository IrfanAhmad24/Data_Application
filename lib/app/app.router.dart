// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedNavigatorGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:flutter/material.dart' as _i4;
import 'package:flutter/material.dart';
import 'package:flutter_practice_application/models/user_model.dart' as _i5;
import 'package:flutter_practice_application/screens/home/home_view.dart'
    as _i2;
import 'package:flutter_practice_application/screens/user/user_details_views.dart'
    as _i3;
import 'package:stacked/stacked.dart' as _i1;
import 'package:stacked_services/stacked_services.dart' as _i6;

class Routes {
  static const homePage = '/';

  static const userDetailsPage = '/user-details-page';

  static const all = <String>{
    homePage,
    userDetailsPage,
  };
}

class StackedRouter extends _i1.RouterBase {
  final _routes = <_i1.RouteDef>[
    _i1.RouteDef(
      Routes.homePage,
      page: _i2.HomePage,
    ),
    _i1.RouteDef(
      Routes.userDetailsPage,
      page: _i3.UserDetailsPage,
    ),
  ];

  final _pagesMap = <Type, _i1.StackedRouteFactory>{
    _i2.HomePage: (data) {
      return _i4.MaterialPageRoute<dynamic>(
        builder: (context) => const _i2.HomePage(),
        settings: data,
      );
    },
    _i3.UserDetailsPage: (data) {
      final args = data.getArgs<UserDetailsPageArguments>(
        orElse: () => const UserDetailsPageArguments(),
      );
      return _i4.MaterialPageRoute<dynamic>(
        builder: (context) => _i3.UserDetailsPage(
            key: args.key,
            user: args.user,
            id: args.id,
            icon: args.icon,
            isEditButton: args.isEditButton),
        settings: data,
      );
    },
  };

  @override
  List<_i1.RouteDef> get routes => _routes;

  @override
  Map<Type, _i1.StackedRouteFactory> get pagesMap => _pagesMap;
}

class UserDetailsPageArguments {
  const UserDetailsPageArguments({
    this.key,
    this.user,
    this.id,
    this.icon = false,
    this.isEditButton = false,
  });

  final _i4.Key? key;

  final _i5.UserModel? user;

  final String? id;

  final bool icon;

  final bool isEditButton;

  @override
  String toString() {
    return '{"key": "$key", "user": "$user", "id": "$id", "icon": "$icon", "isEditButton": "$isEditButton"}';
  }

  @override
  bool operator ==(covariant UserDetailsPageArguments other) {
    if (identical(this, other)) return true;
    return other.key == key &&
        other.user == user &&
        other.id == id &&
        other.icon == icon &&
        other.isEditButton == isEditButton;
  }

  @override
  int get hashCode {
    return key.hashCode ^
        user.hashCode ^
        id.hashCode ^
        icon.hashCode ^
        isEditButton.hashCode;
  }
}

extension NavigatorStateExtension on _i6.NavigationService {
  Future<dynamic> navigateToHomePage([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.homePage,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToUserDetailsPage({
    _i4.Key? key,
    _i5.UserModel? user,
    String? id,
    bool icon = false,
    bool isEditButton = false,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.userDetailsPage,
        arguments: UserDetailsPageArguments(
            key: key,
            user: user,
            id: id,
            icon: icon,
            isEditButton: isEditButton),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithHomePage([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.homePage,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithUserDetailsPage({
    _i4.Key? key,
    _i5.UserModel? user,
    String? id,
    bool icon = false,
    bool isEditButton = false,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.userDetailsPage,
        arguments: UserDetailsPageArguments(
            key: key,
            user: user,
            id: id,
            icon: icon,
            isEditButton: isEditButton),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }
}
