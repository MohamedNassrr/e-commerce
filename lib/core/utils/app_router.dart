import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:online_shop_app/core/services/google_auth_services.dart';
import 'package:online_shop_app/core/services/service_locator.dart';
import 'package:online_shop_app/features/auth/presentation/controller/login_cubit/login_cubit.dart';
import 'package:online_shop_app/features/auth/presentation/controller/register_cubit/register_cubit.dart';
import 'package:online_shop_app/features/auth/presentation/views/forget_password_view.dart';
import 'package:online_shop_app/features/auth/presentation/views/login_view.dart';
import 'package:online_shop_app/features/auth/presentation/views/register_view.dart';
import 'package:online_shop_app/features/google_maps/presentation/controller/google_maps_cubit/google_maps_cubit.dart';
import 'package:online_shop_app/features/google_maps/presentation/views/google_maps_view.dart';
import 'package:online_shop_app/features/home/data/models/product_model/product_model.dart';
import 'package:online_shop_app/features/home/presentation/views/home_view.dart';
import 'package:online_shop_app/features/home/presentation/views/product_detail_view.dart';

abstract class AppRouter {
  static const kLoginView = '/';
  static const kRegisterView = '/RegisterView';
  static const kHomeView = '/HomeView';
  static const kForgetPassView = '/ForgetPasswordView';
  static const kGoogleMapsView = '/GoogleMapsView';
  static const kProductDetailsView = '/ProductDetailView';

  static final router = GoRouter(
    initialLocation: initialLocation(),
    routes: [
      GoRoute(
        path: kLoginView,
        builder: (context, state) => BlocProvider(
          create: (context) => LoginCubit(getIt.get<GoogleAuthService>()),
          child: const LoginView(),
        ),
      ),
      GoRoute(
        path: kRegisterView,
        builder: (context, state) => BlocProvider(
          create: (context) => RegisterCubit(),
          child: const RegisterView(),
        ),
      ),
      GoRoute(
        path: kForgetPassView,
        builder: (context, state) => const ForgetPasswordView(),
      ),
      GoRoute(
        path: kHomeView,
        builder: (context, state) => const HomeView(),
      ),
      GoRoute(
        path: kProductDetailsView,
        builder: (context, state) => ProductDetailView(
          productModel: state.extra as ProductModel,
        ),
      ),
      GoRoute(
        path: kGoogleMapsView,
        builder: (context, state) => BlocProvider(
            create: (context) => GoogleMapsCubit(),
            child: const GoogleMapsView()),
      ),
    ],
  );

  static String initialLocation() {
    User? user = FirebaseAuth.instance.currentUser;
    return user != null ? kHomeView : kLoginView;
  }
}
