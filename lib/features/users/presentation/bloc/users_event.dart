abstract class UsersEvent {}

class GetClientsEvent extends UsersEvent {
  final int page;
  final int limit;
  final String search;

  GetClientsEvent({this.page = 1, this.limit = 10, this.search = ''});
}
