import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:movie_recommend/bloc/movie_bloc.dart';
import 'package:movie_recommend/model/item.dart';
import 'package:movie_recommend/screens/card_back_screen.dart';
import 'package:movie_recommend/screens/card_front_screen.dart';
import 'package:movie_recommend/style/theme.dart' as Style;

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  GlobalKey<FlipCardState> cardKey = GlobalKey<FlipCardState>();
  bool clicked = false;
  ItemModel _selectedGenre;
  ItemModel _selectedScore;
  List<ItemModel> genres;
  List<ItemModel> scores;

  @override
  void initState() {
    scores = [
      ItemModel(title: "Any Score",value: null),
      ItemModel(title: "5",value: 5),
      ItemModel(title: "6",value: 6),
      ItemModel(title: "7",value: 7),
      ItemModel(title: "8",value: 8),
    ];
    genres = [
      ItemModel(title: "All Genres",value: null),
      ItemModel(title: "Action",value: 5),
      ItemModel(title: "Animation",value: 6),
      ItemModel(title: "Anime",value: 39),
      ItemModel(title: "Comedy",value: 9),
      ItemModel(title: "Drama",value: 8),
      ItemModel(title: "Horror",value: 19),
    ];
    _selectedGenre = genres[0];
    _selectedScore = scores[0];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Style.Colors.mainColor,
        title: Center(
          child: Text(
            "What Should I Watch",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: Container(
          child: FlipCard(
            key: cardKey,
            flipOnTouch: false,
            front: CardFront(),
            back: CardBack(),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 100,
        padding: EdgeInsets.all(15),
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            clicked
            ? Container() :
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Genre",
                          style: TextStyle(
                            color: Style.Colors.mainColor,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 5,),
                        Container(
                          padding: EdgeInsets.only(left: 5,),
                          height: 30,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            border: Border.all(color: Style.Colors.mainColor,width: 1,),
                          ),
                          child: Theme(
                            data: ThemeData(
                              canvasColor: Colors.white,
                            ),
                            child: DropdownButton<ItemModel>(
                              icon: Icon(
                                Icons.arrow_drop_down,
                                color: Style.Colors.mainColor,
                              ),
                              isExpanded: false,
                              underline: Container(

                              ),
                              hint: Text(
                                "",
                                style: TextStyle(),
                              ),
                              value: _selectedGenre,
                              onChanged: (ItemModel newValue){
                                setState(() {
                                  _selectedGenre = newValue;
                                });
                              },
                              items: genres.map((ItemModel filter){
                                return DropdownMenuItem<ItemModel>(
                                  value: filter,
                                  child: Row(
                                    children: [
                                      Text(
                                        filter.title,
                                        style: TextStyle(
                                          color: Style.Colors.mainColor,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: 10,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Min Score",
                          style: TextStyle(
                            color: Style.Colors.mainColor,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 5,),
                        Container(
                          padding: EdgeInsets.only(left: 5,),
                          height: 30,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            border: Border.all(color: Style.Colors.mainColor,width: 1,),
                          ),
                          child: Theme(
                            data: ThemeData(
                              canvasColor: Colors.white,
                            ),
                            child: DropdownButton<ItemModel>(
                              icon: Icon(
                                Icons.arrow_drop_down,
                                color: Style.Colors.mainColor,
                              ),
                              isExpanded: false,
                              underline: Container(

                              ),
                              hint: Text(
                                "",
                                style: TextStyle(),
                              ),
                              value: _selectedScore,
                              onChanged: (ItemModel newValue){
                                setState(() {
                                  _selectedScore = newValue;
                                });
                              },
                              items: scores.map((ItemModel filter){
                                return DropdownMenuItem<ItemModel>(
                                  value: filter,
                                  child: Row(
                                    children: [
                                      Text(
                                        filter.title,
                                        style: TextStyle(
                                          color: Style.Colors.mainColor,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
            clicked?Container(
              height: 40,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Style.Colors.mainColor),
                  shape: MaterialStateProperty.all<OutlinedBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8))))
                ),
                onPressed: (){
                  setState(() {
                    clicked = false;
                  });
                  movieBloc..drainStream();
                  cardKey.currentState.toggleCard();
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(EvaIcons.arrowBackOutline,color: Style.Colors.mainColor,),
                    SizedBox(width: 5,),
                    Text(
                      "Back",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            )
                :Container(
              height: 40,
              child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Style.Colors.mainColor),
                    shape: MaterialStateProperty.all<OutlinedBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8))))
                ),
                onPressed: (){
                  movieBloc..getMovie(_selectedGenre.value, _selectedScore.value);
                  setState(() {
                    clicked = true;
                  });
                  cardKey.currentState.toggleCard();
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      EvaIcons.search,
                      color: Colors.white,
                    ),
                    SizedBox(width: 5,),
                    Text(
                      "Suggest",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
