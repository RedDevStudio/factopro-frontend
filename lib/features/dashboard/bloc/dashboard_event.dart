part of 'dashboard_bloc.dart';

sealed class DashboardEvent extends Equatable {
  const DashboardEvent();

  @override
  List<Object?> get props => [];
}

final class DashboardNavItemSelected extends DashboardEvent {
  const DashboardNavItemSelected(this.item);

  final DashboardNavItem item;

  @override
  List<Object?> get props => [item];
}
