import 'dart:async';
import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';
import 'package:user_repository/user_repository.dart';

class FirebaseUserRepo implements UserRepository {
  final FirebaseAuth _firebaseAuth;
  final usersCollection = FirebaseFirestore.instance.collection('users');

  FirebaseUserRepo({
    FirebaseAuth? firebaseAuth,
  }) : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  @override
  Stream<MyUser?> get user {
    return _firebaseAuth.authStateChanges().flatMap((firebaseUser) async* {
      if (firebaseUser == null) {
        yield MyUser.empty;
      } else {
        // Try to get user data with timeout to prevent blocking
        MyUser? userData;
        
        // First, try to get from cache (instant, no network)
        try {
          final cachedDoc = await usersCollection
              .doc(firebaseUser.uid)
              .get(const GetOptions(source: Source.cache))
              .timeout(const Duration(seconds: 2));
          
          if (cachedDoc.exists && cachedDoc.data() != null) {
            userData = MyUser.fromEntity(MyUserEntity.fromDocument(cachedDoc.data()!));
            log('User data loaded from cache');
          }
        } catch (e) {
          log('Cache fetch failed or timed out: $e');
        }

        // If cache failed, try server with timeout
        if (userData == null) {
          try {
            final serverDoc = await usersCollection
                .doc(firebaseUser.uid)
                .get(const GetOptions(source: Source.server))
                .timeout(const Duration(seconds: 5));
            
            if (serverDoc.exists && serverDoc.data() != null) {
              userData = MyUser.fromEntity(MyUserEntity.fromDocument(serverDoc.data()!));
              log('User data loaded from server');
            }
          } catch (e) {
            log('Server fetch failed or timed out: $e');
          }
        }

        // Fallback: Create user from FirebaseAuth data if Firestore fails
        if (userData == null) {
          log('Using fallback user data from FirebaseAuth');
          userData = MyUser(
            userId: firebaseUser.uid,
            email: firebaseUser.email ?? '',
            name: firebaseUser.displayName ?? firebaseUser.email?.split('@').first ?? 'User',
            hasActiveCart: false,
          );
        }

        yield userData;
      }
    });
  }

  @override
  Future<void> signIn(String email, String password) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<MyUser> signUp(MyUser myUser, String password) async {
    try {
      UserCredential user = await _firebaseAuth.createUserWithEmailAndPassword(
        email: myUser.email,
        password: password
      );

      myUser.userId = user.user!.uid;
      return myUser;
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<void> logOut() async {
    await _firebaseAuth.signOut();
  }

  @override
  Future<void> setUserData(MyUser myUser) async {
    try {
      await usersCollection
          .doc(myUser.userId)
          .set(myUser.toEntity().toDocument())
          .timeout(const Duration(seconds: 5));
    } catch (e) {
      log('setUserData failed: $e');
      rethrow;
    }
  }
}

