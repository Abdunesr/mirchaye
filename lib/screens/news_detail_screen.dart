import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:mirchaye/model/news.dart';

class NewsDetailScreen extends StatefulWidget {
  final News news;

  const NewsDetailScreen({Key? key, required this.news}) : super(key: key);

  @override
  State<NewsDetailScreen> createState() => _NewsDetailScreenState();
}

class _NewsDetailScreenState extends State<NewsDetailScreen> {
  late List<YoutubePlayerController> _youtubeControllers;

  @override
  void initState() {
    super.initState();
    _initializeVideoControllers();
  }

  void _initializeVideoControllers() {
    _youtubeControllers = [];

    if (widget.news.videoUrl.isEmpty) {
      print("No video URLs found");
      return;
    }

    for (final url in widget.news.videoUrl) {
      try {
        final videoId = YoutubePlayer.convertUrlToId(url);
        print("Extracted Video ID: $videoId");

        if (videoId != null) {
          _youtubeControllers.add(
            YoutubePlayerController(
              initialVideoId: videoId,
              flags: const YoutubePlayerFlags(
                autoPlay: false,
                mute: false,
              ),
            ),
          );
        } else {
          print("Could not extract video ID from URL: $url");
        }
      } catch (e) {
        print("Error processing video URL $url: $e");
      }
    }

    print("Initialized ${_youtubeControllers.length} video controllers");
  }

  @override
  void dispose() {
    for (final controller in _youtubeControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Hero(
                tag: widget.news.id,
                child: CachedNetworkImage(
                  imageUrl: widget.news.imageUrl,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Container(
                    color: Colors.grey[200],
                    child: const Center(child: CircularProgressIndicator()),
                  ),
                  errorWidget: (context, url, error) => Container(
                    color: Colors.grey[200],
                    child: const Icon(Icons.broken_image),
                  ),
                ),
              ),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.share),
                onPressed: () => _shareNews(context),
              ),
              IconButton(
                icon: const Icon(Icons.bookmark_border),
                onPressed: () {},
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  // Date and reading time
                  Row(
                    children: [
                      const Icon(Icons.calendar_today,
                          size: 16, color: Colors.grey),
                      const SizedBox(width: 8),
                      Text(
                        _formatDate(widget.news.date),
                        style: const TextStyle(color: Colors.grey),
                      ),
                      const SizedBox(width: 16),
                      const Icon(Icons.timer, size: 16, color: Colors.grey),
                      const SizedBox(width: 8),
                      Text(
                        '${_calculateReadTime(widget.news.body)} min read',
                        style: const TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  // Title
                  Text(
                    widget.news.title,
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),

                  const SizedBox(height: 24),

                  // Body content
                  Text(
                    widget.news.body,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontSize: 16,
                          height: 1.6,
                        ),
                  ),

                  const SizedBox(height: 24),

                  // YouTube Videos
                  if (_youtubeControllers.isNotEmpty)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Videos',
                          style:
                              Theme.of(context).textTheme.titleLarge?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                        const SizedBox(height: 12),
                        ..._youtubeControllers.map(
                          (controller) => Padding(
                            padding: const EdgeInsets.only(bottom: 16),
                            child: YoutubePlayer(
                              controller: controller,
                              showVideoProgressIndicator: true,
                              progressColors: const ProgressBarColors(
                                playedColor: Colors.blueAccent,
                                handleColor: Colors.blue,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                  if (widget.news.videoUrl.isNotEmpty)
                    const Padding(
                      padding: EdgeInsets.only(bottom: 16),
                      child: Text(
                        'Could not load videos',
                        style: TextStyle(color: Colors.red),
                      ),
                    ),

                  const SizedBox(height: 30),

                  // Tags
                  Wrap(
                    spacing: 8,
                    children: [
                      _buildTag('Election'),
                      _buildTag('Politics'),
                      _buildTag('News'),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.comment),
        backgroundColor: Colors.blueAccent,
      ),
    );
  }

  Widget _buildTag(String text) {
    return Chip(
      label: Text(text),
      backgroundColor: Colors.blueAccent.withOpacity(0.1),
      labelStyle: const TextStyle(color: Colors.blueAccent),
      shape: StadiumBorder(
        side: BorderSide(color: Colors.blueAccent.withOpacity(0.3)),
      ),
    );
  }

  String _formatDate(String dateString) {
    try {
      final dateTime = DateTime.parse(dateString);
      final month = _getMonthName(dateTime.month);
      return '$month ${dateTime.day}, ${dateTime.year}';
    } catch (e) {
      return dateString;
    }
  }

  String _getMonthName(int month) {
    const months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December'
    ];
    return months[month - 1];
  }

  int _calculateReadTime(String text) {
    final wordCount = text.split(RegExp(r'\s+')).length;
    return (wordCount / 200).ceil();
  }

  void _shareNews(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Sharing "${widget.news.title}"')),
    );
  }
}
