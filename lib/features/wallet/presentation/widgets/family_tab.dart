import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/bottom_sheet_wrapper.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../../../../core/widgets/selectable_chip.dart';
import '../../data/models/family_member_model.dart';

class FamilyTab extends StatefulWidget {
  const FamilyTab({super.key});

  @override
  State<FamilyTab> createState() => _FamilyTabState();
}

class _FamilyTabState extends State<FamilyTab> {
  late List<FamilyMemberModel> _members;

  @override
  void initState() {
    super.initState();
    _members = List.from(FamilyMemberModel.mockMembers);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Add Member Button
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Align(
            alignment: Alignment.centerRight,
            child: SizedBox(
              height: 36.h,
              child: ElevatedButton.icon(
                onPressed: () => _showAddMemberSheet(context),
                icon: Icon(Icons.add, size: 16.sp),
                label: Text(
                  "Add Member",
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: AppColors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  elevation: 0,
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 16.h),

        // Members List
        Expanded(
          child: _members.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.people_outline,
                        size: 64.sp,
                        color: Colors.grey[300],
                      ),
                      SizedBox(height: 16.h),
                      Text(
                        "No family members yet",
                        style: AppTextStyles.caption,
                      ),
                    ],
                  ),
                )
              : ListView.separated(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  itemCount: _members.length,
                  separatorBuilder: (_, _) => SizedBox(height: 12.h),
                  itemBuilder: (_, index) {
                    final member = _members[index];
                    return _FamilyMemberTile(
                      member: member,
                      onDelete: () {
                        setState(() => _members.removeAt(index));
                      },
                    );
                  },
                ),
        ),
      ],
    );
  }

  void _showAddMemberSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => _AddFamilyMemberSheet(
        onAdd: (member) {
          setState(() => _members.add(member));
        },
      ),
    );
  }
}

// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
// Family Member Tile
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

class _FamilyMemberTile extends StatelessWidget {
  final FamilyMemberModel member;
  final VoidCallback onDelete;

  const _FamilyMemberTile({required this.member, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Row(
        children: [
          // Avatar
          Container(
            width: 44.w,
            height: 44.w,
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.15),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                member.name.isNotEmpty ? member.name[0].toUpperCase() : '?',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
            ),
          ),
          SizedBox(width: 12.w),

          // Name + Contact
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(member.name, style: AppTextStyles.bodyMedium),
                SizedBox(height: 2.h),
                Row(
                  children: [
                    Icon(
                      member.contactMethod == ContactMethod.email
                          ? Icons.email_outlined
                          : Icons.phone_outlined,
                      size: 12.sp,
                      color: AppColors.textSecondary,
                    ),
                    SizedBox(width: 4.w),
                    Text(member.contact, style: AppTextStyles.captionSmall),
                  ],
                ),
              ],
            ),
          ),

          // Delete
          GestureDetector(
            onTap: onDelete,
            child: Icon(
              Icons.delete_outline,
              color: AppColors.error,
              size: 22.sp,
            ),
          ),
        ],
      ),
    );
  }
}

// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
// Add Family Member Bottom Sheet
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

class _AddFamilyMemberSheet extends StatefulWidget {
  final ValueChanged<FamilyMemberModel> onAdd;

  const _AddFamilyMemberSheet({required this.onAdd});

  @override
  State<_AddFamilyMemberSheet> createState() => _AddFamilyMemberSheetState();
}

class _AddFamilyMemberSheetState extends State<_AddFamilyMemberSheet> {
  final _nameController = TextEditingController();
  final _contactController = TextEditingController();
  ContactMethod _contactMethod = ContactMethod.email;

  @override
  void dispose() {
    _nameController.dispose();
    _contactController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BottomSheetWrapper(
      title: "Add Family Member",
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Name
          Text("Name", style: AppTextStyles.sectionLabel),
          SizedBox(height: 8.h),
          CustomTextField(controller: _nameController, hintText: "Enter name"),
          SizedBox(height: 16.h),

          // Contact Method Toggle
          Text("Contact Method", style: AppTextStyles.sectionLabel),
          SizedBox(height: 8.h),
          Row(
            children: [
              Expanded(
                child: SelectableChip(
                  label: "Email",
                  isSelected: _contactMethod == ContactMethod.email,
                  onTap: () => setState(() {
                    _contactMethod = ContactMethod.email;
                    _contactController.clear();
                  }),
                  padding: EdgeInsets.symmetric(vertical: 10.h),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: SelectableChip(
                  label: "Phone",
                  isSelected: _contactMethod == ContactMethod.phone,
                  onTap: () => setState(() {
                    _contactMethod = ContactMethod.phone;
                    _contactController.clear();
                  }),
                  padding: EdgeInsets.symmetric(vertical: 10.h),
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),

          // Contact Input
          CustomTextField(
            controller: _contactController,
            hintText: _contactMethod == ContactMethod.email
                ? "example@email.com"
                : "+1 (555) 000-0000",
            prefixIcon: Icon(
              _contactMethod == ContactMethod.email
                  ? Icons.email_outlined
                  : Icons.phone_outlined,
              size: 18.sp,
              color: Colors.grey[400],
            ),
            keyboardType: _contactMethod == ContactMethod.email
                ? TextInputType.emailAddress
                : TextInputType.phone,
          ),
          SizedBox(height: 24.h),

          // Add Button
          SizedBox(
            width: double.infinity,
            height: 50.h,
            child: ElevatedButton(
              onPressed: () {
                if (_nameController.text.isNotEmpty &&
                    _contactController.text.isNotEmpty) {
                  widget.onAdd(
                    FamilyMemberModel(
                      id: 'fam_${DateTime.now().millisecondsSinceEpoch}',
                      name: _nameController.text,
                      contact: _contactController.text,
                      contactMethod: _contactMethod,
                    ),
                  );
                  Navigator.pop(context);
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.r),
                ),
                elevation: 0,
              ),
              child: Text(
                "Add Member",
                style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600),
              ),
            ),
          ),
          SizedBox(height: 12.h),
        ],
      ),
    );
  }
}
