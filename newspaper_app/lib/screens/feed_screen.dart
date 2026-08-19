import 'package:flutter/material.dart';
import '../data/mock_data.dart';
import '../models/models.dart';
import '../theme/app_theme.dart';
import '../widgets/article_card.dart';
import '../widgets/classified_widgets.dart';
import '../widgets/section_header.dart';
import 'ad_detail_screen.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({super.key});

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  final ScrollController _scrollController = ScrollController();
  String _selectedNewsCategory = 'Top Stories';
  String? _selectedClassifiedCategory;
  double _readingProgress = 0;

  @override
  void initState() {
    super.initState();
    // INNOVATION: Reading-progress indicator. A thin bar under the app bar
    // fills up as the user scrolls through the feed — echoes a newspaper's
    // "how much is left to read" feel rather than a generic social feed.
    _scrollController.addListener(() {
      final max = _scrollController.position.maxScrollExtent;
      final offset = _scrollController.offset;
      setState(() {
        _readingProgress = max == 0 ? 0 : (offset / max).clamp(0.0, 1.0);
      });
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  List<Article> get _filteredArticles {
    if (_selectedNewsCategory == 'Top Stories') return MockData.articles;
    return MockData.articles.where((a) => a.category == _selectedNewsCategory).toList();
  }

  List<ClassifiedAd> get _filteredClassifieds {
    if (_selectedClassifiedCategory == null) return MockData.classifieds;
    return MockData.classifieds.where((c) => c.category == _selectedClassifiedCategory).toList();
  }

  void _openAd(ClassifiedAd ad) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => AdDetailScreen(ad: ad)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final featured = MockData.articles.where((a) => a.isFeatured).toList();

    return Scaffold(
      backgroundColor: AppColors.paper,
      body: SafeArea(
        child: Column(
          children: [
            _buildAppBar(context),
            // Reading progress bar
            SizedBox(
              height: 2.5,
              child: LinearProgressIndicator(
                value: _readingProgress,
                backgroundColor: AppColors.divider,
                valueColor: const AlwaysStoppedAnimation(AppColors.accent),
              ),
            ),
            Expanded(
              child: ListView(
                controller: _scrollController,
                padding: const EdgeInsets.only(bottom: 24),
                children: [
                  // Featured stories rail
                  SectionHeader(title: 'Featured Stories'),
                  SizedBox(
                    height: 210,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: featured.length,
                      itemBuilder: (_, i) => FeaturedArticleCard(
                        article: featured[i],
                        onTap: () {},
                      ),
                    ),
                  ),

                  // Classifieds section
                  SectionHeader(title: 'Classifieds', actionLabel: 'View All'),
                  SizedBox(
                    height: 96,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: MockData.classifiedCategories.length,
                      itemBuilder: (_, i) {
                        final cat = MockData.classifiedCategories[i];
                        return ClassifiedCategoryChip(
                          category: cat,
                          selected: _selectedClassifiedCategory == cat.name,
                          onTap: () {
                            setState(() {
                              _selectedClassifiedCategory =
                                  _selectedClassifiedCategory == cat.name ? null : cat.name;
                            });
                          },
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 6),
                  SizedBox(
                    height: 230,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: _filteredClassifieds.length,
                      itemBuilder: (_, i) => ClassifiedAdCard(
                        ad: _filteredClassifieds[i],
                        onTap: () => _openAd(_filteredClassifieds[i]),
                      ),
                    ),
                  ),

                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    child: Divider(),
                  ),

                  // News categories filter
                  SectionHeader(title: 'Latest News'),
                  SizedBox(
                    height: 40,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: MockData.newsCategories.length,
                      itemBuilder: (_, i) {
                        final cat = MockData.newsCategories[i];
                        final selected = cat == _selectedNewsCategory;
                        return Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: ChoiceChip(
                            label: Text(cat),
                            selected: selected,
                            onSelected: (_) => setState(() => _selectedNewsCategory = cat),
                            selectedColor: AppColors.ink,
                            backgroundColor: Colors.white,
                            labelStyle: TextStyle(
                              color: selected ? Colors.white : AppColors.ink,
                              fontWeight: FontWeight.w600,
                              fontSize: 12.5,
                            ),
                            side: const BorderSide(color: AppColors.divider),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Article list
                  ..._filteredArticles.map(
                    (a) => Column(
                      children: [
                        ArticleListTile(article: a, onTap: () {}),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: Divider(height: 1),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(color: AppColors.ink, borderRadius: BorderRadius.circular(6)),
                child: const Icon(Icons.newspaper, color: AppColors.paper, size: 16),
              ),
              const SizedBox(width: 8),
              Text('THE DAILY WIRE', style: Theme.of(context).textTheme.headlineSmall),
            ],
          ),
          Row(
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.search, color: AppColors.ink),
                tooltip: 'Search',
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.bookmark_border, color: AppColors.ink),
                tooltip: 'Saved',
              ),
            ],
          ),
        ],
      ),
    );
  }
}
