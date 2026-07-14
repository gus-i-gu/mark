final class HomeCardDescriptor {
  const HomeCardDescriptor({required this.title, required this.body});

  final String title;
  final String body;
}

const homeCards = <HomeCardDescriptor>[
  HomeCardDescriptor(
    title: 'Recent updates',
    body: 'Markei is one evolving Flutter codebase for desktop and mobile.',
  ),
  HomeCardDescriptor(
    title: 'Scheduled updates',
    body: 'Sync, Analytics, Household and public distribution are future work.',
  ),
  HomeCardDescriptor(
    title: 'What Markei is for',
    body: 'Register local purchases and compare Products from your history.',
  ),
  HomeCardDescriptor(
    title: 'Mid-term perspectives',
    body:
        'Lists and comparisons are estimates derived from registered history.',
  ),
  HomeCardDescriptor(
    title: 'How Markei works',
    body: 'Local offline-first storage is used; normal use needs no network.',
  ),
  HomeCardDescriptor(
    title: 'For developers',
    body: 'Local use currently sends no user data or usage analytics.',
  ),
];
