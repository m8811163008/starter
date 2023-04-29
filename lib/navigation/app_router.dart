import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../models/models.dart';
import '../screens/screens.dart';

/// App router is wraper around Go router.
class AppRouter {
  final AppStateManager appStateManager;
  final ProfileManager profileManager;
  final GroceryManager groceryManager;

  AppRouter(
    this.appStateManager,
    this.profileManager,
    this.groceryManager,
  );

  late final goRouter = GoRouter(
    debugLogDiagnostics: true,
    initialLocation: '/login',
    refreshListenable: appStateManager,
    routes: [
      GoRoute(
        path: '/login',
        name: 'login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        name: 'onboarding',
        path: '/onboarding',
        builder: (context, state) => const OnboardingScreen(),
      ),
      GoRoute(
        // Define a path with tab parameter
        path: '/:tab',
        name: 'home',
        builder: (context, state) {
          // gets the tabs value from the goRouterState params
          final tab = int.tryParse(state.params['tab'] ?? '') ?? 1;
          return Home(
            currentTab: tab,
            key: state.pageKey,
          );
        },
        routes: [
          // Add Item subroute
          GoRoute(
            name: 'item',
            path: 'item/:id',
            builder: (context, state) {
              final itemId = state.params['id'] ?? '';
              final item = groceryManager.getGroceryItem(itemId);
              return GroceryItemScreen(
                originalItem: item,
                onCreate: (item) {
                  groceryManager.addItem(item);
                },
                onUpdate: (item) {
                  groceryManager.updateItem(item);
                },
              );
            },
          ),
          GoRoute(
            path: 'profile',
            name: 'profile',
            builder: (context, state) {
              final tab = int.tryParse(state.params['tab'] ?? '') ?? 0;
              return ProfileScreen(
                user: profileManager.getUser,
                currentTab: tab,
              );
            },
            routes: [
              GoRoute(
                path: 'rw',
                name: 'rw',
                builder: (context, state) => const WebViewScreen(),
              ),
            ],
          )
        ],
      )
    ],
    errorPageBuilder: (context, state) {
      return MaterialPage(
        key: state.pageKey,
        child: Scaffold(
          body: Center(
            child: Text(
              state.error.toString(),
            ),
          ),
        ),
      );
    },
    redirect: (state) {
//       1. Checks to see if the user is logged in.
      final loggedIn = appStateManager.isLoggedIn;
// 2. Checks to see if the user is at the login location.
      final loggingIn = state.subloc == '/login';
// 3. Redirects the user to log in if they haven’t yet.
      if (!loggedIn) return loggingIn ? null : '/login';
// 4. Since the user is already signed in,
// now you check to see if they’ve completed the
// onboarding guide.
      final isOnboardingComplete = appStateManager.isOnboardingComplete;
      final onboarding = state.subloc == '/onboarding';
      if (!isOnboardingComplete) {
        return onboarding ? null : '/onboarding';
      }
// 5. Checks to see if the user is at the onboarding location.
// 6. Redirects the user to onboarding if they haven’t completed it yet.
// 7. The user has signed in and completed onboarding.
// You redirect them to the home
// page, specifically the explore tab. You’ll add the home route in a bit.

      if (loggingIn || onboarding) return '/${FooderlichTab.explore}';
      return null;
    },
  );
}
