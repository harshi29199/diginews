import 'package:flutter/material.dart';

/// A newspaper article / news story.
class Article {
  final String id;
  final String title;
  final String summary;
  final String category;
  final String imageUrl;
  final String author;
  final String readTime;
  final String publishedAt;
  final bool isFeatured;

  const Article({
    required this.id,
    required this.title,
    required this.summary,
    required this.category,
    required this.imageUrl,
    required this.author,
    required this.readTime,
    required this.publishedAt,
    this.isFeatured = false,
  });
}

/// A classified advertisement category, e.g. Jobs, Property...
class ClassifiedCategory {
  final String name;
  final IconData icon;
  final Color color;

  const ClassifiedCategory({
    required this.name,
    required this.icon,
    required this.color,
  });
}

/// A single classified advertisement listing.
class ClassifiedAd {
  final String id;
  final String title;
  final String category;
  final String description;
  final String location;
  final String date;
  final String price;
  final String contact;
  final List<String> images;
  final Color categoryColor;
  final IconData categoryIcon;

  const ClassifiedAd({
    required this.id,
    required this.title,
    required this.category,
    required this.description,
    required this.location,
    required this.date,
    required this.price,
    required this.contact,
    required this.images,
    required this.categoryColor,
    required this.categoryIcon,
  });
}
