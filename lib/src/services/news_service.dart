import 'package:flutter/material.dart';
import 'package:newsapp/src/models/category_model.dart';
import 'package:newsapp/src/models/news_models.dart';
import 'package:http/http.dart' as http;
final _URL_NEWS = 'https://newsapi.org/v2';
final _APIKEY = 'f49f882a7f7246c9847f8e830534610a';
class NewService with ChangeNotifier{

  List<Article> headlines = [];
  String _selectedCategory = 'business';
  bool _isLoading = true;

  List<Category> categories = [
    Category(Icons.business_sharp, 'business'),
    Category(Icons.headset_rounded, 'entertainment'),
    Category(Icons.escalator_warning_outlined, 'general'),
    Category(Icons.healing, 'health'),
    Category(Icons.science, 'science'),
    Category(Icons.sports_baseball_outlined, 'sports'),
    Category(Icons.tablet_mac_sharp, 'technology'),
  ];

  Map<String, List<Article>> categoryArticles = {};

  NewService(){
    this.getTopHeadLines();
    categories.forEach((item) {
      this.categoryArticles[item.name] = [];
     });
     this.getArticlesByCategory( this._selectedCategory );
  }

  get selectedCategory => this._selectedCategory;

  set selectCategory(String valor){
    this._selectedCategory = valor;
    this.getArticlesByCategory(valor);
    notifyListeners();
  }

  List<Article> get getArticulosCategoriaSeleccionada => this.categoryArticles[this.selectedCategory];

  getTopHeadLines() async{
    final url = Uri.parse('$_URL_NEWS/top-headlines?country=us&apiKey=$_APIKEY');
    final resp = await http.get(url);

    final newResponse = newResponseFromJson(resp.body);
    this.headlines.addAll(newResponse.articles);
    
    notifyListeners();
  }

  getArticlesByCategory(String category) async{

    print('..Iniciando ');
    if(this.categoryArticles[category].length > 0){
      return this.categoryArticles[category];
    }

    final url = Uri.parse('$_URL_NEWS/top-headlines?country=us&category=$category&apiKey=$_APIKEY');
    final resp = await http.get(url);

    final newResponse = newResponseFromJson(resp.body);
    this.categoryArticles[category].addAll(newResponse.articles);
    
    notifyListeners();
  }

}