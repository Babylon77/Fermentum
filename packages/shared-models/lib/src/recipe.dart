class RecipeSummary {
  const RecipeSummary({
    required this.id,
    required this.name,
    required this.beverageType,
    required this.targetBatchVolumeLiters,
  });

  final String id;
  final String name;
  final String beverageType;
  final double targetBatchVolumeLiters;
}

