enum ProjectType { flutter, dart }

class CreateProjectService {
  CreateProjectService({required this.type});

  final ProjectType type;

  Future<int> create() async {
    return 0;
  }
}
