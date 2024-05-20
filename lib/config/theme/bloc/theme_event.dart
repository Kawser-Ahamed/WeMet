
class ThemeEvent {}

class UserChangeThemeEvent extends ThemeEvent{

  final bool isDark;
  UserChangeThemeEvent(this.isDark);
}

class PrimaryChangeThemeEvent extends ThemeEvent{}

