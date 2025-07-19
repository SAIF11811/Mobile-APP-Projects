import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class NewsScreen extends StatefulWidget {
  final String query;

  const NewsScreen({required this.query});

  @override
  _NewsScreenState createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  final Dio _dio = Dio();
  final String _apiKey = 'cbf28408ceb3440495a6267403ea7b7c';
  List<dynamic> _articles = [];
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    fetchNews();
  }

  Future<void> fetchNews() async {
    const url = 'https://newsapi.org/v2/everything';
    try {
      final response = await _dio.get(url, queryParameters: {
        'q': widget.query,
        'language': 'ar',
        'sortBy': 'publishedAt',
        'apiKey': _apiKey,
      });

      if (response.statusCode == 200) {
        setState(() {
          _articles = response.data['articles'];
          _isLoading = false;
        });
      } else {
        setState(() {
          _error = 'فشل تحميل الأخبار';
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _error = 'حدث خطأ: $e';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text('أخبار ${widget.query}'),
          backgroundColor: Colors.teal[400],
        ),
        body: _isLoading
            ? Center(child: CircularProgressIndicator())
            : _error != null
            ? Center(child: Text(_error!))
            : RefreshIndicator(
          onRefresh: fetchNews,
          child: _articles.isEmpty
              ? Center(child: Text('لا توجد أخبار حالياً'))
              : ListView.builder(
            itemCount: _articles.length,
            itemBuilder: (context, index) {
              final article = _articles[index];
              return NewsCard(
                title: article['title'] ?? 'بدون عنوان',
                description:
                article['description'] ?? 'لا يوجد وصف',
                imageUrl: article['urlToImage'] ??
                    'https://via.placeholder.com/150',
              );
            },
          ),
        ),
      ),
    );
  }
}

class NewsCard extends StatelessWidget {
  final String title;
  final String description;
  final String imageUrl;

  const NewsCard({
    required this.title,
    required this.description,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    final hasImage = imageUrl.isNotEmpty && imageUrl != 'null';

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.teal[100],
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.teal.withOpacity(0.2),
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            child: hasImage
                ? Image.network(
              imageUrl,
              height: 180,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                height: 180,
                color: Colors.grey[300],
                child: Icon(Icons.broken_image,
                    size: 40, color: Colors.grey[700]),
              ),
            )
                : Container(
              height: 180,
              width: double.infinity,
              color: Colors.grey[300],
              child: Icon(Icons.image_not_supported,
                  size: 40, color: Colors.grey[700]),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.teal[900],
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.teal[800],
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
}
