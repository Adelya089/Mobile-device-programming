import '../../models/card.dart';

abstract class ApiInterface {
  Future<List<CardData>?> loadData({String? q});
}