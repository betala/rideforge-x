class ApiPaths {
  ApiPaths._();

  static const baseUrl = String.fromEnvironment(
    'RIDEFORGE_API_BASE_URL',
    defaultValue: 'http://localhost:4000/api/v1',
  );

  static const motorcycles = '/motorcycles';
  static const tourPlans = '/tour-plans';
  static const groupRides = '/group-rides';
  static const diagnostics = '/diagnostics';
  static const media = '/media';
}

