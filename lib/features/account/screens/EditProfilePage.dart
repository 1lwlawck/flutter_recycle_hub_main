import 'package:flutter/material.dart';
import 'package:flutter_recycle_hub/core/models/Users.dart';
import 'package:flutter_recycle_hub/core/services/Config.dart';
import 'package:flutter_recycle_hub/utils/shared_prefs_util.dart';
import 'package:flutter_recycle_hub/features/account/services/UserService.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  bool isLoading = true;
  User? user;
  File? profileImage;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  @override
  void dispose() {
    nameController.dispose();
    dobController.dispose();
    genderController.dispose();
    phoneController.dispose();
    emailController.dispose();
    super.dispose();
  }

  Future<void> _loadUserData() async {
    final userId = await SharedPrefsUtil.getUserId();
    if (userId == null) {
      setState(() => isLoading = false);
      return;
    }

    final fetchedUser = await UserService.getUser(userId);
    if (fetchedUser != null) {
      setState(() {
        user = fetchedUser;
        nameController.text = user!.namaUser;
        dobController.text = user!.tanggalLahir ?? '';
        genderController.text = user!.jenisKelamin ?? '';
        phoneController.text = user!.nomorHp ?? '';
        emailController.text = user!.email;
        isLoading = false;
      });
    } else {
      setState(() => isLoading = false);
    }
  }

  Future<void> _updateUserData() async {
    if (user == null) return;

    final userData = {
      'nama_user': nameController.text.trim(),
      'tanggal_lahir': dobController.text.trim(),
      'jenis_kelamin': genderController.text.trim(),
      'nomor_hp': phoneController.text.trim(),
      'email': emailController.text.trim(),
    };

    final success = await UserService.updateUser(
      userId: user!.id,
      userData: userData,
      avatarFile: profileImage,
    );

    _showDialog(
      success
          ? "Data berhasil diperbarui"
          : "Gagal memperbarui data, coba lagi nanti.",
    );
  }

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        profileImage = File(pickedFile.path);
      });
    }
  }

  void _showDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          elevation: 8,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.info_outline,
                  size: 50,
                  color: Colors.blueAccent,
                ),
                const SizedBox(height: 10),
                Text(
                  message,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    "OK",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFE5E5E5),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Edit Profile",
          style: TextStyle(
              color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            Expanded(
              child: ListView(
                children: [
                  GestureDetector(
                    onTap: _pickImage,
                    child: Container(
                      width: 150,
                      height: 150,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            offset: const Offset(8, -8),
                            blurRadius: 5,
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: profileImage != null
                            ? Image.file(
                                profileImage!,
                                fit: BoxFit.cover,
                              )
                            : Image.network(
                                "${Config.API_URL}/static/uploads/avatars/${user!.avatar}",
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) =>
                                    const Icon(Icons.person, size: 50),
                              ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  buildTextField("Nama", nameController),
                  const SizedBox(height: 10),
                  buildTextField("Tanggal Lahir", dobController),
                  const SizedBox(height: 10),
                  buildTextField("Jenis Kelamin", genderController),
                  const SizedBox(height: 10),
                  buildTextField("No Ponsel", phoneController),
                  const SizedBox(height: 10),
                  buildTextField("Email", emailController),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: _updateUserData,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: const BorderSide(color: Colors.black),
                      ),
                    ),
                    child: const Text(
                      "SIMPAN",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTextField(String label, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
              fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.grey[100],
            contentPadding:
                const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.black, width: 2),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.blueAccent, width: 2),
            ),
          ),
        ),
      ],
    );
  }
}
