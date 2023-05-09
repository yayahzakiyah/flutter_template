import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageHelper {
  final String _key;

  LocalStorageHelper(this._key);

  Future<SharedPreferences> _getPrefs() async {
    return await SharedPreferences.getInstance();
  }

  Future<List<Map<String, dynamic>>> readData() async {
    final prefs = await _getPrefs();
    final data = prefs.getString(_key);

    if (data != null) {
      return List<Map<String, dynamic>>.from(json.decode(data));
    }

    return [];
  }

  Future<void> createData(Map<String, dynamic> item) async {
    final prefs = await _getPrefs();
    final data = await readData();

    data.add(item);

    await prefs.setString(_key, json.encode(data));
  }

  Future<void> updateData(Map<String, dynamic> item, int index) async {
    final prefs = await _getPrefs();
    final data = await readData();

    data[index] = item;

    await prefs.setString(_key, json.encode(data));
  }

  Future<void> deleteData(int index) async {
    final prefs = await _getPrefs();
    final data = await readData();

    data.removeAt(index);

    await prefs.setString(_key, json.encode(data));
  }
}
