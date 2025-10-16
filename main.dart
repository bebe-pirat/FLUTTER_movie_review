import 'package:flutter/material.dart';

void main() {
  runApp(RottenCucumbersApp());
}

class RottenCucumbersApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rotten Cucumbers',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: MovieHomePage(),
    );
  }
}

class MovieHomePage extends StatelessWidget {
  final List<Movie> movies = [
    Movie(
      title: 'Интерстеллар',
      rating: 85,
      imageUrl: 'https://avatars.mds.yandex.net/get-kinopoisk-image/1600647/430042eb-ee69-4818-aed0-a312400a26bf/600x900',
      reviews: 234,
    ),
    Movie(
      title: 'Начало',
      rating: 74,
      imageUrl: 'https://avatars.mds.yandex.net/get-kinopoisk-image/1629390/8ab9a119-dd74-44f0-baec-0629797483d7/600x900',
      reviews: 189,
    ),
    Movie(
      title: 'Матрица',
      rating: 92,
      imageUrl: 'https://avatars.mds.yandex.net/get-kinopoisk-image/4774061/cf1970bc-3f08-4e0e-a095-2fb57c3aa7c6/220x330',
      reviews: 312,
    ),
    Movie(
      title: 'Белоснежка',
      rating: 39,
      imageUrl: 'https://avatars.mds.yandex.net/get-kinopoisk-image/4716873/0b7ed711-c519-4c65-9a0b-0dd8cf86d88f/220x330',
      reviews: 279,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CircleAvatar(
              radius: 20,
              backgroundColor: Colors.white,
              child: Text(
                '🥒',
                style: TextStyle(fontSize: 20),
              ),
            ),
            Text(
              'Rotten Cucumbers',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            CircleAvatar(
              radius: 20,
              backgroundColor: Colors.white,
              child: Text(
                '👤',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
        backgroundColor: Colors.green[700],
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(16),
            color: Colors.green[50],
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildInfoItem('Фильмы', '250+'),
                _buildInfoItem('Рецензии', '1.2K'),
                _buildInfoItem('Пользователи', '5.4K'),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: movies.length,
              itemBuilder: (context, index) {
                return _buildMovieCard(movies[index]);
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddReviewDialog(context);
        },
        backgroundColor: Colors.green,
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildInfoItem(String title, String value) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.green[800],
          ),
        ),
        Text(
          title,
          style: TextStyle(
            fontSize: 12,
            color: Colors.green[600],
          ),
        ),
      ],
    );
  }

  Widget _buildMovieCard(Movie movie) {
    return Container(
      margin: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.green[100]!,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 80,
            height: 120,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                bottomLeft: Radius.circular(12),
              ),
              image: DecorationImage(
                image: NetworkImage(movie.imageUrl),
              ),
            ),
          ),
          
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          movie.title,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.green[900],
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      _buildRatingIndicator(movie.rating),
                    ],
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Рецензии: ${movie.reviews}',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.green[600],
                    ),
                  ),
                  SizedBox(height: 8),
                  Container(
                    height: 4,
                    child: LinearProgressIndicator(
                      value: movie.rating / 100,
                      backgroundColor: Colors.green[100],
                      valueColor: AlwaysStoppedAnimation<Color>(
                        movie.rating >= 60 ? Colors.green : Colors.red,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRatingIndicator(int rating) {
    Color color = rating >= 60 ? Colors.green : Colors.red;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color),
      ),
      child: Text(
        '$rating%',
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: color,
        ),
      ),
    );
  }

  void _showAddReviewDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Добавить рецензию'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Название фильма',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              decoration: InputDecoration(
                labelText: 'Ваша оценка (0-100)',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Отмена'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
            child: Text('Добавить'),
          ),
        ],
      ),
    );
  }
}

class Movie {
  final String title;
  final int rating;
  final String imageUrl;
  final int reviews;

  Movie({
    required this.title,
    required this.rating,
    required this.imageUrl,
    required this.reviews,
  });
}
