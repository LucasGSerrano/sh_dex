import 'package:flutter/material.dart';
import 'package:sh_dex/models/models.dart';
import 'package:sh_dex/widgets/widgets.dart';

class HeroList extends StatefulWidget {
  final List<HeroModel> heroList;

  HeroList(this.heroList);

  @override
  _HeroListState createState() => _HeroListState(heroList);
}

class _HeroListState extends State<HeroList> {
  Icon _searchIcon = Icon(Icons.search);
  Widget _appBarTitle = Text("Heroes");

  List<HeroModel> filteredHeroes;

  _HeroListState(this.filteredHeroes);

  onItemChanged(String value) {
    setState(() => filteredHeroes = filteredHeroes
        .where((element) =>
            element.name?.toLowerCase().contains(value.toLowerCase()) ?? false)
        .toList());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _appBarTitle,
        actions: [IconButton(icon: _searchIcon, onPressed: _searchPressed)],
      ),
      body: HeroListView(heroList: filteredHeroes),
    );
  }

  void _searchPressed() {
    setState(() {
      if (this._searchIcon.icon == Icons.search) {
        this._searchIcon = Icon(Icons.close);
        this._appBarTitle = TextField(
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
              hintStyle: TextStyle(color: Colors.white),
              prefixIcon: Icon(
                Icons.search,
                color: Colors.white,
              ),
              hintText: 'Search...'),
          onChanged: onItemChanged,
        );
      } else {
        this._searchIcon = Icon(Icons.search);
        this._appBarTitle = Text('Heroes');
        filteredHeroes = List.from(widget.heroList);
      }
    });
  }
}
