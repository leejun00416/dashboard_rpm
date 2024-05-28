import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dashboard_rpm/firebase_options.dart';
import 'package:dashboard_rpm/providers/auth_provider.dart';
import 'package:dashboard_rpm/providers/auth_state.dart';
import 'package:dashboard_rpm/repositories/auth_repository.dart';
import 'package:dashboard_rpm/screens/splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_state_notifier/flutter_state_notifier.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart' show GlobalCupertinoLocalizations, GlobalMaterialLocalizations, GlobalWidgetsLocalizations;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    //FirebaseAuth.instance.signOut();
    return MultiProvider(
      providers: [
        Provider<AuthRepository>(
          create: (context) => AuthRepository(
            firebaseAuth: FirebaseAuth.instance,
            firebaseStorage: FirebaseStorage.instance,
            firebaseFirestore: FirebaseFirestore.instance,
          ),
        ),
        StreamProvider<User?>(
          create: (context) => FirebaseAuth.instance.authStateChanges(),
          initialData: null,
        ),
        StateNotifierProvider<AuthProvideres, AuthState>(
          create: (context) => AuthProvideres(),
        ),
      ],
      child: MaterialApp(
        localizationsDelegates: <LocalizationsDelegate<Object>>[
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: [
          Locale('ko', 'KR'),
        ],
        locale: const Locale('ko'),
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
      ),
    );
  }
}