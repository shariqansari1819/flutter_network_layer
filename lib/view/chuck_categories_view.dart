import 'package:flutter/material.dart';
import 'package:flutter_network_layer/blocs/chuck_category_bloc.dart';
import 'package:flutter_network_layer/models/chuck_category.dart';
import 'package:flutter_network_layer/networking/response.dart';
import 'package:flutter_network_layer/view/chuck_joke_view.dart';

class GetChuckCategories extends StatefulWidget {
  @override
  _GetChuckCategoriesState createState() => _GetChuckCategoriesState();
}

class _GetChuckCategoriesState extends State<GetChuckCategories> {
  ChuckCategoryBloc _chuckCategoryBloc;

  @override
  void initState() {
    super.initState();
    _chuckCategoryBloc = ChuckCategoryBloc();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        automaticallyImplyLeading: false,
        title: Text('Chucky Categories',
            style: TextStyle(color: Colors.white, fontSize: 20)),
        backgroundColor: Color(0xFF333333),
      ),
      backgroundColor: Color(0xFF333333),
      body: RefreshIndicator(
        onRefresh: () => _chuckCategoryBloc.fetchCategories(),
        child: StreamBuilder<Response<ChuckCategory>>(
          stream: _chuckCategoryBloc.chuckListStream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              switch (snapshot.data.status) {
                case Status.LOADING:
                  return Loading(loadingMessage: snapshot.data.message);
                case Status.ERROR:
                  return Error(
                    errorMessage: snapshot.data.message,
                    onRetryPressed: () => _chuckCategoryBloc.fetchCategories(),
                  );
                  break;
                case Status.COMPLETED:
                  return CategoryList(
                    chuckCategory: snapshot.data.data,
                  );
                  break;
              }
            }
            return Container();
          },
        ),
      ),
    );
  }
}

class CategoryList extends StatelessWidget {
  final ChuckCategory chuckCategory;

  CategoryList({this.chuckCategory});

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Color(0xFF202020),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 0.0,
                vertical: 1.0,
              ),
              child: InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ShowChuckJoke(
                            category: chuckCategory.categories[index])));
                  },
                  child: SizedBox(
                    height: 65,
                    child: Container(
                      color: Color(0xFF333333),
                      alignment: Alignment.center,
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(4, 0, 0, 0),
                        child: Text(
                          chuckCategory.categories[index],
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w100,
                              fontFamily: 'Roboto'),
                          textAlign: TextAlign.left,
                        ),
                      ),
                    ),
                  )));
        },
        itemCount: chuckCategory.categories.length,
        shrinkWrap: true,
        physics: ClampingScrollPhysics(),
      ),
    );
  }
}

class Error extends StatelessWidget {
  final String errorMessage;
  final Function onRetryPressed;

  Error({Key key, this.errorMessage, this.onRetryPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            errorMessage,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
            ),
          ),
          SizedBox(height: 8),
          RaisedButton(
            color: Colors.white,
            child: Text('Retry', style: TextStyle(color: Colors.black)),
            onPressed: onRetryPressed,
          )
        ],
      ),
    );
  }
}

class Loading extends StatelessWidget {
  final String loadingMessage;

  Loading({this.loadingMessage});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            loadingMessage,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
            ),
          ),
          SizedBox(height: 24),
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          ),
        ],
      ),
    );
  }
}
