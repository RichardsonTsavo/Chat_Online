abstract class ISharedPreferencesRepositoryInterface {
  Future getInfo({required String key});
  Future deleteInfo();
  Future save({required String key, required List<String> item});
}
