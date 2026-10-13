import 'package:factopro/core/constants/iran_provinces.dart';
import 'package:factopro/core/utils/extensions/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

/// Opens a searchable bottom sheet listing [iranProvinces]. Resolves to the
/// chosen province, or null when dismissed.
Future<String?> showProvincePickerSheet(
  BuildContext context, {
  String? selected,
}) {
  return showModalBottomSheet<String>(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    backgroundColor: context.colorScheme.surface,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
    ),
    builder: (context) => _ProvincePickerSheet(selected: selected),
  );
}

class _ProvincePickerSheet extends StatefulWidget {
  const _ProvincePickerSheet({this.selected});

  final String? selected;

  @override
  State<_ProvincePickerSheet> createState() => _ProvincePickerSheetState();
}

class _ProvincePickerSheetState extends State<_ProvincePickerSheet> {
  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<String> get _visibleProvinces {
    final query = _searchController.text.trim();
    if (query.isEmpty) return iranProvinces;
    return [
      for (final province in iranProvinces)
        if (province.contains(query)) province,
    ];
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;
    final provinces = _visibleProvinces;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Padding(
        // Keeps the search field above the keyboard.
        padding: EdgeInsets.only(
          bottom: MediaQuery.viewInsetsOf(context).bottom,
        ),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.sizeOf(context).height * 0.75,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Gap(10),
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: colorScheme.outline,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 14, 20, 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'انتخاب استان',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: colorScheme.onSurface,
                      ),
                    ),
                    const Gap(12),
                    TextField(
                      controller: _searchController,
                      style: TextStyle(color: colorScheme.onSurface),
                      decoration: InputDecoration(
                        isDense: true,
                        hintText: 'جستجوی استان...',
                        hintStyle: TextStyle(
                          color: colorScheme.onSurfaceVariant,
                        ),
                        prefixIcon: Icon(
                          Icons.search,
                          color: colorScheme.onSurfaceVariant,
                        ),
                        filled: true,
                        fillColor: colorScheme.outlineVariant,
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 12,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: colorScheme.outline),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: colorScheme.outline),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: colorScheme.primary),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Divider(color: colorScheme.outline, height: 1),
              Flexible(
                child: provinces.isEmpty
                    ? Padding(
                        padding: const EdgeInsets.all(32),
                        child: Text(
                          'استانی با این نام یافت نشد',
                          style: TextStyle(
                            fontSize: 13,
                            color: colorScheme.onSurfaceVariant,
                          ),
                        ),
                      )
                    : ListView.builder(
                        shrinkWrap: true,
                        padding: const EdgeInsets.symmetric(vertical: 6),
                        itemCount: provinces.length,
                        itemBuilder: (context, index) {
                          final province = provinces[index];
                          final isSelected = province == widget.selected;

                          return ListTile(
                            onTap: () => Navigator.of(context).pop(province),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 20,
                            ),
                            title: Text(
                              province,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: isSelected
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                                color: isSelected
                                    ? colorScheme.primary
                                    : colorScheme.onSurface,
                              ),
                            ),
                            trailing: isSelected
                                ? Icon(
                                    Icons.check_rounded,
                                    color: colorScheme.primary,
                                  )
                                : null,
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
