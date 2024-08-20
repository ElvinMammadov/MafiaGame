enum Flavor {
  prod,
  dev,
}

class AppConfig {
  String gameFirebase = "";
  String gamerFirebase = "";

  Flavor flavor = Flavor.dev;

  static AppConfig shared = AppConfig.create();

  AppConfig(this.gameFirebase, this.gamerFirebase, this.flavor);

  factory AppConfig.create({
    String gameFirebase = "",
    String gamerFirebase = "",
    Flavor flavor = Flavor.dev,
  }) =>
      shared = AppConfig(gameFirebase, gamerFirebase, flavor);
}
