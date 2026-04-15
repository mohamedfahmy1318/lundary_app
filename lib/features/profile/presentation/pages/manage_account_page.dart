import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laundry/core/utils/app_extensions.dart';
import 'package:laundry/core/di/injection_container.dart';
import 'package:laundry/core/services/local_storage_service.dart';
import 'package:laundry/core/utils/current_location_helper.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/app_bar_factory.dart';
import '../../../select_address/presentation/screens/map_address_picker_screen.dart';
import '../cubit/profile_cubit.dart';
import '../cubit/profile_state.dart';
import '../cubit/change_password_cubit.dart';
import '../cubit/change_password_state.dart';
import '../cubit/update_profile_cubit.dart';
import '../cubit/update_profile_state.dart';
import 'package:image_picker/image_picker.dart';

class ManageAccountPage extends StatefulWidget {
  const ManageAccountPage({super.key});

  @override
  State<ManageAccountPage> createState() => _ManageAccountPageState();
}

class _ManageAccountPageState extends State<ManageAccountPage> {
  final LocalStorageService _localStorage = getIt<LocalStorageService>();
  List<String> _savedLocations = const <String>[];
  bool _isLoadingCurrentLocation = false;

  @override
  void initState() {
    super.initState();
    _loadSavedLocations();
    _syncCurrentLocation();
  }

  void _loadSavedLocations() {
    _savedLocations = _localStorage.getSavedLocations();
  }

  Future<void> _syncCurrentLocation() async {
    if (!mounted) {
      return;
    }

    setState(() {
      _isLoadingCurrentLocation = true;
    });

    final current = await CurrentLocationHelper.getCurrentAddress();
    if (current != null && current.trim().isNotEmpty) {
      await _persistLocation(current.trim());
    }

    if (!mounted) {
      return;
    }
    setState(() {
      _isLoadingCurrentLocation = false;
      _loadSavedLocations();
    });
  }

  Future<void> _persistLocation(String location) async {
    await _localStorage.saveCurrentLocation(location);
    final normalized =
        _localStorage
            .getSavedLocations()
            .where(
              (item) => item.trim().toLowerCase() != location.toLowerCase(),
            )
            .toList();
    await _localStorage.saveSavedLocations(<String>[location, ...normalized]);
  }

  Future<void> _addAnotherLocation() async {
    final selectedAddress = await Navigator.of(context).push<String>(
      MaterialPageRoute(
        builder:
            (_) => const MapAddressPickerScreen(title: 'Add Another Location'),
      ),
    );

    if (!mounted || selectedAddress == null || selectedAddress.trim().isEmpty) {
      return;
    }

    await _persistLocation(selectedAddress.trim());
    if (!mounted) {
      return;
    }

    setState(() {
      _loadSavedLocations();
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Location added successfully.')),
    );
  }

  Future<void> _editLocation(int index) async {
    if (index < 0 || index >= _savedLocations.length) {
      return;
    }

    final oldLocation = _savedLocations[index];
    final selectedAddress = await Navigator.of(context).push<String>(
      MaterialPageRoute(
        builder: (_) => const MapAddressPickerScreen(title: 'Edit Location'),
      ),
    );

    if (!mounted || selectedAddress == null || selectedAddress.trim().isEmpty) {
      return;
    }

    final updatedLocation = selectedAddress.trim();
    final next = List<String>.from(_savedLocations);
    next[index] = updatedLocation;

    final seen = <String>{};
    final deduplicated =
        next.where((item) => seen.add(item.trim().toLowerCase())).toList();

    await _localStorage.saveSavedLocations(deduplicated);

    final current = _localStorage.getCurrentLocation();
    if (current != null &&
        current.trim().toLowerCase() == oldLocation.trim().toLowerCase()) {
      await _localStorage.saveCurrentLocation(updatedLocation);
    }

    if (!mounted) {
      return;
    }

    setState(() {
      _savedLocations = deduplicated;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Location updated successfully.')),
    );
  }

  Future<void> _deleteLocation(int index) async {
    if (index < 0 || index >= _savedLocations.length) {
      return;
    }

    final locationToDelete = _savedLocations[index];
    final shouldDelete = await showDialog<bool>(
      context: context,
      builder:
          (dialogContext) => AlertDialog(
            title: const Text('Delete location'),
            content: const Text(
              'Are you sure you want to delete this location?',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(dialogContext).pop(false),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () => Navigator.of(dialogContext).pop(true),
                child: const Text('Delete'),
              ),
            ],
          ),
    );

    if (shouldDelete != true) {
      return;
    }

    final next = List<String>.from(_savedLocations)..removeAt(index);
    await _localStorage.saveSavedLocations(next);

    final current = _localStorage.getCurrentLocation();
    if (current != null &&
        current.trim().toLowerCase() == locationToDelete.trim().toLowerCase()) {
      await _localStorage.saveCurrentLocation(
        next.isNotEmpty ? next.first : '',
      );
    }

    if (!mounted) {
      return;
    }

    setState(() {
      _savedLocations = next;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Location deleted successfully.')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => getIt<ProfileCubit>()..loadProfile()),
        BlocProvider(create: (context) => getIt<UpdateProfileCubit>()),
      ],
      child: BlocListener<UpdateProfileCubit, UpdateProfileState>(
        listener: (context, state) {
          state.whenOrNull(
            success: (msg) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(msg), backgroundColor: Colors.green),
              );
              context.read<ProfileCubit>().loadProfile();
            },
            error: (msg) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(msg), backgroundColor: Colors.red),
              );
            },
          );
        },
        child: Scaffold(
          backgroundColor: AppColors.white,
          appBar: AppBarFactory.build(
            context,
            title: "Manage Account",
            onBack: () => context.pop(),
          ),
          body: BlocBuilder<ProfileCubit, ProfileState>(
            builder: (context, state) {
              return state.maybeWhen(
                loaded: (profile) {
                  return SingleChildScrollView(
                    padding: EdgeInsets.symmetric(
                      horizontal: 24.w,
                      vertical: 16.h,
                    ),
                    child: Column(
                      children: [
                        // Avatar with Edit Button
                        Stack(
                          children: [
                            Container(
                              width: 120.w,
                              height: 120.w,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.grey[300],
                                image:
                                    profile.fullAvatarUrl != null
                                        ? DecorationImage(
                                          image: NetworkImage(
                                            profile.fullAvatarUrl!,
                                          ),
                                          fit: BoxFit.cover,
                                        )
                                        : null,
                              ),
                              child:
                                  profile.fullAvatarUrl == null
                                      ? Icon(
                                        Icons.person,
                                        size: 60.sp,
                                        color: Colors.grey[600],
                                      )
                                      : null,
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: InkWell(
                                onTap: () => _pickImage(context),
                                child: Container(
                                  padding: EdgeInsets.all(8.r),
                                  decoration: const BoxDecoration(
                                    color: AppColors.primary,
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.camera_alt,
                                    color: AppColors.white,
                                    size: 20,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 16.h),
                        Text(profile.name, style: AppTextStyles.pageTitle),
                        Text(profile.email, style: AppTextStyles.bodyRegular),
                        SizedBox(height: 30.h),

                        // Editable Fields
                        _EditableField(
                          label: "Full Name",
                          value: profile.name,
                          onEdit:
                              () => _showEditProfileBottomSheet(
                                context,
                                title: "Full Name",
                                initialValue: profile.name,
                                onSave: (newName) {
                                  context
                                      .read<UpdateProfileCubit>()
                                      .updateProfile(name: newName);
                                },
                              ),
                        ),
                        _EditableField(
                          label: "Phone Number",
                          value: profile.phone,
                          onEdit:
                              () => _showEditProfileBottomSheet(
                                context,
                                title: "Phone Number",
                                initialValue: profile.phone,
                                onSave: (newPhone) {
                                  context
                                      .read<UpdateProfileCubit>()
                                      .updateProfile(phone: newPhone);
                                },
                              ),
                        ),

                        // Password Field
                        _buildSection(
                          label: "Password",
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "••••••••",
                                  style: AppTextStyles.bodyMedium,
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  _showChangePasswordBottomSheet(context);
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.primary,
                                  foregroundColor: AppColors.white,
                                  minimumSize: Size(80.w, 36.h),
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 12.w,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12.r),
                                  ),
                                  elevation: 0,
                                ),
                                child: const Text("Change"),
                              ),
                            ],
                          ),
                        ),

                        // Saved Locations
                        _buildSection(
                          label: "Saved Locations",
                          trailing: TextButton.icon(
                            onPressed: _addAnotherLocation,
                            icon: const Icon(Icons.add, size: 16),
                            label: const Text("Add"),
                            style: TextButton.styleFrom(
                              foregroundColor: AppColors.primary,
                            ),
                          ),
                          child: Column(
                            children: [
                              if (_isLoadingCurrentLocation)
                                Padding(
                                  padding: EdgeInsets.only(bottom: 8.h),
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: 14.w,
                                        height: 14.w,
                                        child: const CircularProgressIndicator(
                                          strokeWidth: 2,
                                        ),
                                      ),
                                      SizedBox(width: 8.w),
                                      Text(
                                        'Fetching current location...',
                                        style: AppTextStyles.caption,
                                      ),
                                    ],
                                  ),
                                ),
                              if (_savedLocations.isEmpty)
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'No saved locations yet. Tap Add to add one.',
                                    style: AppTextStyles.caption,
                                  ),
                                )
                              else
                                ..._savedLocations.asMap().entries.map((entry) {
                                  final index = entry.key;
                                  final location = entry.value;

                                  return Container(
                                    width: double.infinity,
                                    margin: EdgeInsets.only(bottom: 8.h),
                                    padding: EdgeInsets.all(12.w),
                                    decoration: BoxDecoration(
                                      color: AppColors.cardBackground,
                                      borderRadius: BorderRadius.circular(12.r),
                                    ),
                                    child: Row(
                                      children: [
                                        const Icon(
                                          Icons.location_on_outlined,
                                          color: AppColors.primary,
                                        ),
                                        SizedBox(width: 12.w),
                                        Expanded(
                                          child: Text(
                                            location,
                                            style: AppTextStyles.caption,
                                          ),
                                        ),
                                        IconButton(
                                          tooltip: 'Edit location',
                                          icon: const Icon(
                                            Icons.edit_outlined,
                                            color: AppColors.primary,
                                          ),
                                          onPressed: () => _editLocation(index),
                                        ),
                                        IconButton(
                                          tooltip: 'Delete location',
                                          icon: const Icon(
                                            Icons.delete_outline,
                                            color: Colors.red,
                                          ),
                                          onPressed:
                                              () => _deleteLocation(index),
                                        ),
                                      ],
                                    ),
                                  );
                                }),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
                orElse: () => const Center(child: CircularProgressIndicator()),
              );
            },
          ),
        ),
      ),
    );
  }

  Future<void> _pickImage(BuildContext context) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      if (!context.mounted) return;
      context.read<UpdateProfileCubit>().updateProfile(
        avatarFilePath: pickedFile.path,
      );
    }
  }

  void _showEditProfileBottomSheet(
    BuildContext context, {
    required String title,
    required String initialValue,
    required Function(String) onSave,
  }) {
    final controller = TextEditingController(text: initialValue);
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (bottomSheetContext) {
        return Container(
          padding: EdgeInsets.only(
            left: 24.w,
            right: 24.w,
            top: 24.h,
            bottom: MediaQuery.of(bottomSheetContext).viewInsets.bottom + 24.h,
          ),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                "Edit $title",
                style: AppTextStyles.pageTitle,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 24.h),
              TextField(
                controller: controller,
                decoration: InputDecoration(
                  labelText: title,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
              ),
              SizedBox(height: 32.h),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(bottomSheetContext);
                  if (controller.text.trim().isNotEmpty &&
                      controller.text.trim() != initialValue) {
                    onSave(controller.text.trim());
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  minimumSize: Size(double.infinity, 50.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
                child: Text(
                  "Save changes",
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.white,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showChangePasswordBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return BlocProvider(
          create: (_) => getIt<ChangePasswordCubit>(),
          child: const _ChangePasswordBottomSheet(),
        );
      },
    );
  }

  /// Generic section container used for password, photo upload, locations, etc.
  Widget _buildSection({
    required String label,
    required Widget child,
    Widget? trailing,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label,
                style: AppTextStyles.sectionLabel.copyWith(fontSize: 12.sp),
              ),
              if (trailing != null) trailing,
            ],
          ),
          SizedBox(height: 8.h),
          child,
        ],
      ),
    );
  }
}

class _EditableField extends StatelessWidget {
  final String label;
  final String value;
  final VoidCallback onEdit;

  const _EditableField({
    required this.label,
    required this.value,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: AppTextStyles.sectionLabel.copyWith(fontSize: 12.sp),
          ),
          SizedBox(height: 8.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(value, style: AppTextStyles.bodyMedium),
              InkWell(
                onTap: onEdit,
                child: Icon(Icons.edit, color: AppColors.primary, size: 18.sp),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ChangePasswordBottomSheet extends StatefulWidget {
  const _ChangePasswordBottomSheet();

  @override
  State<_ChangePasswordBottomSheet> createState() =>
      _ChangePasswordBottomSheetState();
}

class _ChangePasswordBottomSheetState
    extends State<_ChangePasswordBottomSheet> {
  final _formKey = GlobalKey<FormState>();
  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _obscureCurrent = true;
  bool _obscureNew = true;
  bool _obscureConfirm = true;

  @override
  void dispose() {
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return Container(
      padding: EdgeInsets.only(
        left: 24.w,
        right: 24.w,
        top: 24.h,
        bottom: bottomInset + 24.h,
      ),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      child: BlocConsumer<ChangePasswordCubit, ChangePasswordState>(
        listener: (context, state) {
          state.whenOrNull(
            success: (msg) {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(msg), backgroundColor: Colors.green),
              );
            },
            error: (msg) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(msg), backgroundColor: Colors.red),
              );
            },
          );
        },
        builder: (context, state) {
          final isLoading = state.maybeWhen(
            loading: () => true,
            orElse: () => false,
          );

          return Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  "Change Password",
                  style: AppTextStyles.pageTitle,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 24.h),
                _buildPasswordField(
                  controller: _currentPasswordController,
                  label: "Current Password",
                  obscureText: _obscureCurrent,
                  onToggleObscure:
                      () => setState(() => _obscureCurrent = !_obscureCurrent),
                  validator:
                      (val) => val == null || val.isEmpty ? 'Required' : null,
                ),
                SizedBox(height: 16.h),
                _buildPasswordField(
                  controller: _newPasswordController,
                  label: "New Password",
                  obscureText: _obscureNew,
                  onToggleObscure:
                      () => setState(() => _obscureNew = !_obscureNew),
                  validator: (val) {
                    if (val == null || val.isEmpty) return 'Required';
                    if (val.length < 6) return 'Password too short';
                    return null;
                  },
                ),
                SizedBox(height: 16.h),
                _buildPasswordField(
                  controller: _confirmPasswordController,
                  label: "Confirm New Password",
                  obscureText: _obscureConfirm,
                  onToggleObscure:
                      () => setState(() => _obscureConfirm = !_obscureConfirm),
                  validator: (val) {
                    if (val != _newPasswordController.text) {
                      return 'Passwords do not match';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 32.h),
                ElevatedButton(
                  onPressed:
                      isLoading
                          ? null
                          : () {
                            if (_formKey.currentState?.validate() ?? false) {
                              context
                                  .read<ChangePasswordCubit>()
                                  .changePassword(
                                    currentPassword:
                                        _currentPasswordController.text,
                                    newPassword: _newPasswordController.text,
                                    confirmPassword:
                                        _confirmPasswordController.text,
                                  );
                            }
                          },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    minimumSize: Size(double.infinity, 50.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  child:
                      isLoading
                          ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            ),
                          )
                          : Text(
                            "Update Password",
                            style: AppTextStyles.bodyMedium.copyWith(
                              color: AppColors.white,
                            ),
                          ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildPasswordField({
    required TextEditingController controller,
    required String label,
    required bool obscureText,
    required VoidCallback onToggleObscure,
    required String? Function(String?) validator,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      validator: validator,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: AppTextStyles.bodyMedium.copyWith(color: Colors.grey[600]),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: const BorderSide(color: AppColors.primary),
        ),
        suffixIcon: IconButton(
          icon: Icon(
            obscureText ? Icons.visibility_off : Icons.visibility,
            color: Colors.grey[600],
          ),
          onPressed: onToggleObscure,
        ),
      ),
    );
  }
}
