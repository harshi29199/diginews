import 'package:flutter/material.dart';
import '../data/mock_data.dart';
import '../models/models.dart';
import '../theme/app_theme.dart';
import '../widgets/classified_widgets.dart';

class AdDetailScreen extends StatefulWidget {
  final ClassifiedAd ad;
  const AdDetailScreen({super.key, required this.ad});

  @override
  State<AdDetailScreen> createState() => _AdDetailScreenState();
}

class _AdDetailScreenState extends State<AdDetailScreen> {
  bool _saved = false;
  int _imageIndex = 0;
  final PageController _pageController = PageController();

  void _toggleSave() {
    setState(() => _saved = !_saved);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(_saved ? 'Saved to bookmarks' : 'Removed from bookmarks'),
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _share() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
      builder: (_) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Share this ad', style: Theme.of(context).textTheme.headlineSmall),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _shareOption(Icons.message_outlined, 'Message'),
                  _shareOption(Icons.email_outlined, 'Email'),
                  _shareOption(Icons.copy_outlined, 'Copy Link'),
                  _shareOption(Icons.more_horiz, 'More'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _shareOption(IconData icon, String label) {
    return Column(
      children: [
        CircleAvatar(
          radius: 24,
          backgroundColor: AppColors.paperDark,
          child: Icon(icon, color: AppColors.ink),
        ),
        const SizedBox(height: 6),
        Text(label, style: const TextStyle(fontSize: 11)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final ad = widget.ad;
    final related = MockData.relatedTo(ad);

    return Scaffold(
      backgroundColor: AppColors.paper,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            backgroundColor: AppColors.paper,
            foregroundColor: AppColors.ink,
            surfaceTintColor: Colors.transparent,
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  // INNOVATION: Swipeable image gallery with page indicator
                  // so multi-image ads (property, vehicles) can be browsed
                  // like a photo carousel instead of a single static image.
                  Hero(
                    tag: 'classified_${ad.id}',
                    child: PageView.builder(
                      controller: _pageController,
                      itemCount: ad.images.length,
                      onPageChanged: (i) => setState(() => _imageIndex = i),
                      itemBuilder: (_, i) => Image.network(ad.images[i], fit: BoxFit.cover),
                    ),
                  ),
                  if (ad.images.length > 1)
                    Positioned(
                      bottom: 14,
                      left: 0,
                      right: 0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          ad.images.length,
                          (i) => AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            margin: const EdgeInsets.symmetric(horizontal: 3),
                            width: _imageIndex == i ? 18 : 6,
                            height: 6,
                            decoration: BoxDecoration(
                              color: _imageIndex == i ? Colors.white : Colors.white54,
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            actions: [
              IconButton(
                icon: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 250),
                  transitionBuilder: (child, anim) => ScaleTransition(scale: anim, child: child),
                  child: Icon(
                    _saved ? Icons.bookmark : Icons.bookmark_border,
                    key: ValueKey(_saved),
                    color: _saved ? AppColors.accent : AppColors.ink,
                  ),
                ),
                onPressed: _toggleSave,
              ),
              IconButton(
                icon: const Icon(Icons.share_outlined),
                onPressed: _share,
              ),
              const SizedBox(width: 6),
            ],
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: ad.categoryColor.withOpacity(0.12),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(ad.categoryIcon, size: 13, color: ad.categoryColor),
                            const SizedBox(width: 4),
                            Text(
                              ad.category,
                              style: TextStyle(
                                  color: ad.categoryColor, fontWeight: FontWeight.w700, fontSize: 11.5),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(ad.title, style: Theme.of(context).textTheme.headlineLarge),
                  const SizedBox(height: 8),
                  Text(
                    ad.price,
                    style: const TextStyle(color: AppColors.accent, fontSize: 20, fontWeight: FontWeight.w800),
                  ),
                  const SizedBox(height: 14),
                  Row(
                    children: [
                      const Icon(Icons.location_on_outlined, size: 16, color: AppColors.subtitle),
                      const SizedBox(width: 4),
                      Expanded(child: Text(ad.location, style: const TextStyle(color: AppColors.subtitle, fontSize: 13))),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      const Icon(Icons.calendar_today_outlined, size: 14, color: AppColors.subtitle),
                      const SizedBox(width: 6),
                      Text(ad.date, style: const TextStyle(color: AppColors.subtitle, fontSize: 13)),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const Divider(),
                  const SizedBox(height: 12),
                  Text('Description', style: Theme.of(context).textTheme.headlineSmall),
                  const SizedBox(height: 8),
                  Text(ad.description, style: Theme.of(context).textTheme.bodyLarge),
                  const SizedBox(height: 20),
                  const Divider(),
                  const SizedBox(height: 12),
                  Text('Contact', style: Theme.of(context).textTheme.headlineSmall),
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppColors.divider),
                    ),
                    child: Row(
                      children: [
                        const CircleAvatar(
                          radius: 20,
                          backgroundColor: AppColors.paperDark,
                          child: Icon(Icons.person_outline, color: AppColors.ink),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Advertiser', style: TextStyle(fontSize: 11, color: AppColors.subtitle)),
                              Text(ad.contact, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14)),
                            ],
                          ),
                        ),
                        IconButton.filled(
                          onPressed: () {},
                          style: IconButton.styleFrom(backgroundColor: AppColors.success),
                          icon: const Icon(Icons.call, size: 18, color: Colors.white),
                        ),
                      ],
                    ),
                  ),

                  // INNOVATION: Related ads carousel — encourages continued
                  // browsing within the same category, similar to "related
                  // stories" seen at the bottom of newspaper articles.
                  if (related.isNotEmpty) ...[
                    const SizedBox(height: 24),
                    Text('Related Ads in ${ad.category}', style: Theme.of(context).textTheme.headlineSmall),
                    const SizedBox(height: 10),
                    SizedBox(
                      height: 230,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: related.length,
                        itemBuilder: (_, i) => ClassifiedAdCard(
                          ad: related[i],
                          onTap: () => Navigator.of(context).pushReplacement(
                            MaterialPageRoute(builder: (_) => AdDetailScreen(ad: related[i])),
                          ),
                        ),
                      ),
                    ),
                  ],
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 10, 16, 12),
          child: Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: _toggleSave,
                  icon: Icon(_saved ? Icons.bookmark : Icons.bookmark_border,
                      color: _saved ? AppColors.accent : AppColors.ink),
                  label: Text(_saved ? 'Saved' : 'Save', style: const TextStyle(color: AppColors.ink)),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    side: const BorderSide(color: AppColors.divider),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                flex: 2,
                child: ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.call, size: 18),
                  label: const Text('Contact Advertiser'),
                  style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 14)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
