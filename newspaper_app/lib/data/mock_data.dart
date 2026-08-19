import 'package:flutter/material.dart';
import '../models/models.dart';

/// All data below is static/mock data as required by the assignment.
/// Images are loaded from picsum.photos (seeded, so they stay stable)
/// purely as placeholders — no backend/API logic is involved.
class MockData {
  static const newsCategories = [
    'Top Stories',
    'National',
    'Business',
    'Sports',
    'Technology',
    'Entertainment',
    'World',
  ];

  static final List<Article> articles = [
    Article(
      id: 'a1',
      title: 'Parliament Passes New Digital Infrastructure Bill',
      summary:
          'The bill promises faster rollout of fiber networks across rural districts, with an outlay of ₹12,000 crore over five years.',
      category: 'National',
      imageUrl: 'https://picsum.photos/seed/parliament1/900/600',
      author: 'Ritu Sharma',
      readTime: '4 min read',
      publishedAt: '2h ago',
      isFeatured: true,
    ),
    Article(
      id: 'a2',
      title: 'Markets Rally as Inflation Cools for Third Straight Month',
      summary:
          'The benchmark index closed 1.8% higher, led by gains in banking and IT stocks amid easing price pressures.',
      category: 'Business',
      imageUrl: 'https://picsum.photos/seed/markets2/900/600',
      author: 'Arjun Mehta',
      readTime: '3 min read',
      publishedAt: '3h ago',
      isFeatured: true,
    ),
    Article(
      id: 'a3',
      title: 'Local Football Club Secures Historic Promotion',
      summary:
          'A last-minute goal sealed promotion to the top division for the first time in the club\'s 40-year history.',
      category: 'Sports',
      imageUrl: 'https://picsum.photos/seed/football3/900/600',
      author: 'Kabir Anand',
      readTime: '2 min read',
      publishedAt: '5h ago',
      isFeatured: true,
    ),
    Article(
      id: 'a4',
      title: 'City Unveils Plan for New Metro Corridor',
      summary:
          'The 18 km corridor will connect the eastern suburbs to the central business district by 2029.',
      category: 'National',
      imageUrl: 'https://picsum.photos/seed/metro4/900/600',
      author: 'Neha Kulkarni',
      readTime: '5 min read',
      publishedAt: '6h ago',
    ),
    Article(
      id: 'a5',
      title: 'Startup Raises \$40M to Expand AI-Powered Farming Tools',
      summary:
          'The funding round will help the company scale its crop-monitoring sensors to five new states.',
      category: 'Technology',
      imageUrl: 'https://picsum.photos/seed/farm5/900/600',
      author: 'Dev Malhotra',
      readTime: '3 min read',
      publishedAt: '8h ago',
    ),
    Article(
      id: 'a6',
      title: 'Film Festival Announces This Year\'s Opening Feature',
      summary:
          'The festival returns with over 120 films from 30 countries, opening with a much-anticipated drama.',
      category: 'Entertainment',
      imageUrl: 'https://picsum.photos/seed/film6/900/600',
      author: 'Sana Iyer',
      readTime: '2 min read',
      publishedAt: '10h ago',
    ),
    Article(
      id: 'a7',
      title: 'Global Leaders Meet to Discuss Climate Financing',
      summary:
          'Delegates from over 60 nations gathered to negotiate a new fund aimed at supporting green energy transition.',
      category: 'World',
      imageUrl: 'https://picsum.photos/seed/climate7/900/600',
      author: 'Farah Khan',
      readTime: '6 min read',
      publishedAt: '12h ago',
    ),
  ];

  static const classifiedCategories = [
    ClassifiedCategory(name: 'Jobs', icon: Icons.work_outline, color: Color(0xFF2E7D32)),
    ClassifiedCategory(name: 'Property', icon: Icons.home_outlined, color: Color(0xFF1565C0)),
    ClassifiedCategory(name: 'Matrimonial', icon: Icons.favorite_outline, color: Color(0xFFA6192E)),
    ClassifiedCategory(name: 'Education', icon: Icons.school_outlined, color: Color(0xFF6A1B9A)),
    ClassifiedCategory(name: 'Vehicles', icon: Icons.directions_car_outlined, color: Color(0xFFEF6C00)),
    ClassifiedCategory(name: 'Business', icon: Icons.storefront_outlined, color: Color(0xFF00838F)),
    ClassifiedCategory(name: 'Services', icon: Icons.build_outlined, color: Color(0xFF5D4037)),
    ClassifiedCategory(name: 'General', icon: Icons.grid_view_outlined, color: Color(0xFF616161)),
  ];

  static ClassifiedCategory categoryFor(String name) => classifiedCategories.firstWhere(
        (c) => c.name == name,
        orElse: () => classifiedCategories.last,
      );

  static final List<ClassifiedAd> classifieds = [
    ClassifiedAd(
      id: 'c1',
      title: 'Senior Flutter Developer Needed – Immediate Joining',
      category: 'Jobs',
      description:
          'A fast-growing fintech company is hiring a Senior Flutter Developer with 3+ years of experience building production mobile apps. Must have strong knowledge of state management, clean architecture, and CI/CD pipelines. Remote-friendly with quarterly on-site meetups.',
      location: 'Bengaluru, Karnataka',
      date: 'Posted 2 days ago',
      price: '₹18L – ₹25L /year',
      contact: '+91 98765 43210',
      images: const ['https://picsum.photos/seed/job1/900/600'],
      categoryColor: const Color(0xFF2E7D32),
      categoryIcon: Icons.work_outline,
    ),
    ClassifiedAd(
      id: 'c2',
      title: '3BHK Sea-View Apartment for Sale',
      category: 'Property',
      description:
          'Spacious 3BHK apartment on the 12th floor with unobstructed sea view. 1,650 sq.ft carpet area, 2 covered parking spots, modular kitchen, and access to clubhouse with pool and gym. Ready to move in.',
      location: 'Bandra West, Mumbai',
      date: 'Posted 5 days ago',
      price: '₹4.2 Cr',
      contact: '+91 91234 56780',
      images: const [
        'https://picsum.photos/seed/property2a/900/600',
        'https://picsum.photos/seed/property2b/900/600',
        'https://picsum.photos/seed/property2c/900/600',
      ],
      categoryColor: const Color(0xFF1565C0),
      categoryIcon: Icons.home_outlined,
    ),
    ClassifiedAd(
      id: 'c3',
      title: 'Alliance Invited: Doctor, 29, Seeking Match',
      category: 'Matrimonial',
      description:
          'Family seeks alliance for daughter, 29, MBBS, currently practicing in a city hospital. Well-settled family, seeking a professionally qualified match aged 29-34 with similar values. Caste no bar.',
      location: 'Pune, Maharashtra',
      date: 'Posted 1 week ago',
      price: '—',
      contact: '+91 90909 08080',
      images: const ['https://picsum.photos/seed/matri3/900/600'],
      categoryColor: const Color(0xFFA6192E),
      categoryIcon: Icons.favorite_outline,
    ),
    ClassifiedAd(
      id: 'c4',
      title: 'Admissions Open: Full-Stack Development Bootcamp',
      category: 'Education',
      description:
          '16-week intensive bootcamp covering web and mobile development, including Flutter, React, and backend fundamentals. Includes placement assistance and live project work with industry mentors.',
      location: 'Hyderabad, Telangana',
      date: 'Posted 3 days ago',
      price: '₹85,000 (EMI available)',
      contact: '+91 88990 11223',
      images: const ['https://picsum.photos/seed/edu4/900/600'],
      categoryColor: const Color(0xFF6A1B9A),
      categoryIcon: Icons.school_outlined,
    ),
    ClassifiedAd(
      id: 'c5',
      title: '2021 Honda City VX – Single Owner, Low Mileage',
      category: 'Vehicles',
      description:
          'Well-maintained 2021 Honda City VX, petrol, automatic. 22,000 km driven, single owner, all service records available. New tyres fitted 3 months ago. Genuine buyers only.',
      location: 'Indiranagar, Bengaluru',
      date: 'Posted 1 day ago',
      price: '₹11.5 Lakh',
      contact: '+91 99887 76655',
      images: const [
        'https://picsum.photos/seed/car5a/900/600',
        'https://picsum.photos/seed/car5b/900/600',
      ],
      categoryColor: const Color(0xFFEF6C00),
      categoryIcon: Icons.directions_car_outlined,
    ),
    ClassifiedAd(
      id: 'c6',
      title: 'Franchise Opportunity: Premium Coffee Chain',
      category: 'Business',
      description:
          'Award-winning coffee chain is offering franchise opportunities in Tier-1 and Tier-2 cities. Includes full setup support, staff training, and marketing kit. Expected break-even within 14 months.',
      location: 'Multiple Cities',
      date: 'Posted 4 days ago',
      price: 'Investment: ₹22L+',
      contact: '+91 97654 32109',
      images: const ['https://picsum.photos/seed/biz6/900/600'],
      categoryColor: const Color(0xFF00838F),
      categoryIcon: Icons.storefront_outlined,
    ),
    ClassifiedAd(
      id: 'c7',
      title: 'Home Deep-Cleaning Services – Same Day Booking',
      category: 'Services',
      description:
          'Professional home deep-cleaning service covering kitchen, bathrooms, and living areas. Eco-friendly products, trained staff, and same-day slots available. Packages start at 2BHK.',
      location: 'Serving all of Delhi NCR',
      date: 'Posted 6 hours ago',
      price: 'Starting ₹1,499',
      contact: '+91 96321 47890',
      images: const ['https://picsum.photos/seed/service7/900/600'],
      categoryColor: const Color(0xFF5D4037),
      categoryIcon: Icons.build_outlined,
    ),
    ClassifiedAd(
      id: 'c8',
      title: 'Free: Study Table and Bookshelf – Good Condition',
      category: 'General',
      description:
          'Moving out and giving away a wooden study table with an attached bookshelf, in good working condition. Pickup only, available this weekend.',
      location: 'Kothrud, Pune',
      date: 'Posted 9 hours ago',
      price: 'Free',
      contact: '+91 93456 78901',
      images: const ['https://picsum.photos/seed/general8/900/600'],
      categoryColor: const Color(0xFF616161),
      categoryIcon: Icons.grid_view_outlined,
    ),
  ];

  static List<ClassifiedAd> relatedTo(ClassifiedAd ad) {
    return classifieds
        .where((c) => c.category == ad.category && c.id != ad.id)
        .toList();
  }
}
