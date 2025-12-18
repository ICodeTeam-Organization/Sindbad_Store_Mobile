class ExcellOperation {
  final String operationName;
  final List<Operation> operations;

  ExcellOperation({
    required this.operationName,
    required this.operations,
  });
}

class Operation {
  final String name;
  final String? downloadExcellLink;
  final String note;

  Operation({
    required this.name,
    this.downloadExcellLink,
    required this.note,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Operation &&
        other.name == name &&
        other.downloadExcellLink == downloadExcellLink &&
        other.note == note;
  }

  @override
  int get hashCode =>
      name.hashCode ^ downloadExcellLink.hashCode ^ note.hashCode;
}
