import 'package:equatable/equatable.dart';
import 'package:factopro/features/dashboard/bloc/dashboard_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  DashboardBloc() : super(const DashboardState()) {
    on<DashboardNavItemSelected>(_onNavItemSelected);
  }

  void _onNavItemSelected(
    DashboardNavItemSelected event,
    Emitter<DashboardState> emit,
  ) {
    emit(state.copyWith(selectedNavItem: event.item));
  }
}
