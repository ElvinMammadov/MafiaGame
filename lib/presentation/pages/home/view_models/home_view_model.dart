part of home;

class HomeViewModel {
  final List<HomeTab> tabs;

  HomeViewModel({
    required this.tabs,
  });

  static const int tabsCount = 3;

  factory HomeViewModel.create() => HomeViewModel(
    tabs: <HomeTab>[
      const HomeTab(
        title: AppStrings.statistics,
        icon: Icons.insert_chart,
      ),
      const HomeTab(
        title: AppStrings.mLegends,
        icon: Icons.home,
      ),
      const HomeTab(
        title: AppStrings.games,
        icon: Icons.sports_esports,
      ),
    ],
  );
}
