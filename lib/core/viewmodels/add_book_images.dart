import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../enum/selection_purpose.dart';
import '../model/jobCategories.dart';
import '../repositories/addCategories.dart';

class AddBookImages extends ChangeNotifier {
  int _currentPage = 0;
  int get currentPage => _currentPage;

  bool _isSelected = false;
  bool get isSelected => _isSelected;

  int _select = 0;
  int get select => _select;

  bool _isLongSelected = false;
  bool get isLongSelected => _isLongSelected;

  bool _isFileSelected = false;
  bool get isFileSelected => _isFileSelected;

  BookCatagories? _bookCategories;
  BookCatagories? get bookCategories => _bookCategories;

  List<IndexWithFile>? _imageFile = [];
  List<IndexWithFile>? get imageFile => _imageFile;
  List<int> selectedIndex = [1000000000000];
  String errorString = "";

  bool loading = false;

  String? _catId;
  String? get catId => _catId;

  String? _subCatId;
  String? get subCatId => _subCatId;

  int? _selectedCatIndex;
  int? get selectedCatIndex => _selectedCatIndex;

  int? _selectedSubCatIndex;
  int? get selectedSubCatIndex => _selectedSubCatIndex;

  void setCaiId(String catId, int index) {
    _catId = catId;
    _selectedCatIndex = index;
    notifyListeners();
  }

  void setSubCaiId(String subCatId, int index) {
    _selectedSubCatIndex = index;
    _subCatId = subCatId;
    notifyListeners();
  }

  //api to getCatogries

  Future getCategories() async {
    errorString = "";
    loading = true;
    notifyListeners();
    Response response = await GetCategories().requestCategories();
    try {
      if (response.statusCode == 200 || response.statusCode == 201) {
        _bookCategories = BookCatagories.fromJson(response.data);
        loading = false;
        notifyListeners();
        return;
      } else {
        errorString = "SomeThing went wrong";
        loading = false;
        notifyListeners();
        return;
      }
    } catch (error) {
      loading = false;
      errorString = error.toString();
      notifyListeners();
    }
  }

  addImageWithFile(int index, File file) {
    if (selectedIndex.contains(index)) {
      _imageFile!.removeWhere((element) => element.index == index);
      selectedIndex.remove(index);
      notifyListeners();
      return;
    }
    _imageFile!.add(IndexWithFile(imageFile: file, index: index));
    selectedIndex.add(index);
  }

  setOnLogTabEvent() {
    _isLongSelected = true;
    _isSelected = true;
    notifyListeners();
  }

  changeOnlongTabEvent(int index) {
    _select = index;
    notifyListeners();
  }

  changeOnTabEvent(int index) {
    _select = index;
    notifyListeners();
  }

  isSelectFile(bool value) {
    _isFileSelected = value;
    notifyListeners();
  }

  SelectionPurpose? _selectionStatus;
  SelectionPurpose? get selectionStatus => _selectionStatus;

  changeStatus(SelectionPurpose selectionPurpose) {
    _selectionStatus = selectionPurpose;
    notifyListeners();
  }
}

class IndexWithFile {
  final int index;
  final File imageFile;

  IndexWithFile({required this.index, required this.imageFile});
}
