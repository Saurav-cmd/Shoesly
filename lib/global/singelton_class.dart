class Singleton<T> {
  static final Map<Type, dynamic> _instances = {};

  factory Singleton(Type type, T Function() createFunc) {
    if (!_instances.containsKey(type)) {
      _instances[type] = createFunc();
    }
    return _instances[type];
  }
}