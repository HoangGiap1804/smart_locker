import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/user.dart';
import '../services/api_service.dart';
import '../repositories/user_repository.dart';

final apiServiceProvider = Provider((ref) => ApiService());

final userRepositoryProvider = Provider((ref) {
  final apiService = ref.read(apiServiceProvider);
  return UserRepository(apiService);
});

final userListProvider = FutureProvider<List<User>>((ref) async {
  final repository = ref.read(userRepositoryProvider);
  return repository.fetchUsers();
});
