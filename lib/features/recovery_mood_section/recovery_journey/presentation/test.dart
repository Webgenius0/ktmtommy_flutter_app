// // ignore_for_file: depend_on_referenced_packages
// import 'package:flutter/material.dart';
// import 'package:ktmtommy_apps/features/recovery_mood_section/recovery_journey/data/registration_data/registration_api.dart';
// import 'package:ktmtommy_apps/features/recovery_mood_section/recovery_journey/data/registration_data/registration_rx.dart';
// import 'package:ktmtommy_apps/helpers/toast.dart';
// import 'package:ktmtommy_apps/networks/api_acess.dart';
// import 'package:rxdart/rxdart.dart';
//
// class RegistrationTestScreen extends StatefulWidget {
//   const RegistrationTestScreen({super.key});
//
//   @override
//   State<RegistrationTestScreen> createState() => _RegistrationTestScreenState();
// }
//
// class _RegistrationTestScreenState extends State<RegistrationTestScreen> {
//   // Controllers for text fields
//   final _nameController = TextEditingController();
//   final _emailController = TextEditingController();
//   final _phoneController = TextEditingController();
//   final _passwordController = TextEditingController();
//   final _passwordConfirmationController = TextEditingController();
//   final _ageController = TextEditingController();
//   final _genderController = TextEditingController();
//   final _userModeController = TextEditingController();
//   final _injuryNameController = TextEditingController();
//   final _injuryLevelController = TextEditingController();
//   final _injuryDateController = TextEditingController();
//   final _currentRecoveryStageController = TextEditingController();
//   final _physicalSymptomController = TextEditingController();
//   final _physicalSymptomDetailsController = TextEditingController();
//   final _physicalSymptomDurationController = TextEditingController();
//   final _physicalSymptomFrequencyController = TextEditingController();
//   final _emotionalSymptomsController = TextEditingController();
//   final _recoveryGoalController = TextEditingController();
//   final _recoveryGoalTimeController = TextEditingController();
//   final _progressTimelineController = TextEditingController();
//   final _recoveryTargetDateController = TextEditingController();
//   final _reminderFromController = TextEditingController();
//   final _reminderToController = TextEditingController();
//
//   // Checkbox state for terms_accepted
//   bool _termsAccepted = false;
//
//   // Response or error message
//   String _responseMessage = '';
//   bool _isLoading = false;
//
//
//   @override
//   void dispose() {
//     // Dispose controllers
//     _nameController.dispose();
//     _emailController.dispose();
//     _phoneController.dispose();
//     _passwordController.dispose();
//     _passwordConfirmationController.dispose();
//     _ageController.dispose();
//     _genderController.dispose();
//     _userModeController.dispose();
//     _injuryNameController.dispose();
//     _injuryLevelController.dispose();
//     _injuryDateController.dispose();
//     _currentRecoveryStageController.dispose();
//     _physicalSymptomController.dispose();
//     _physicalSymptomDetailsController.dispose();
//     _physicalSymptomDurationController.dispose();
//     _physicalSymptomFrequencyController.dispose();
//     _emotionalSymptomsController.dispose();
//     _recoveryGoalController.dispose();
//     _recoveryGoalTimeController.dispose();
//     _progressTimelineController.dispose();
//     _recoveryTargetDateController.dispose();
//     _reminderFromController.dispose();
//     _reminderToController.dispose();
//     super.dispose();
//   }
//
//   // Function to handle API call with form data
//   Future<void> _registerWithForm() async {
//     setState(() {
//       _isLoading = true;
//       _responseMessage = '';
//     });
//
//     try {
//       final success = await recoveryRegistrationApiRxObj.registerRecoveryUserApi(
//         name: _nameController.text,
//         email: _emailController.text,
//         phone: _phoneController.text,
//         password: _passwordController.text,
//         password_confirmation: _passwordConfirmationController.text,
//         age: int.tryParse(_ageController.text) ?? 0,
//         gender: _genderController.text,
//         user_mode: _userModeController.text,
//         terms_accepted: _termsAccepted,
//         injury_name: _injuryNameController.text,
//         injury_level: _injuryLevelController.text,
//         injury_date: _injuryDateController.text,
//         current_recovery_stage: _currentRecoveryStageController.text,
//         physical_symptom: int.tryParse(_physicalSymptomController.text) ?? 0,
//         physical_symptom_details: _physicalSymptomDetailsController.text,
//         physical_symptom_duration: int.tryParse(_physicalSymptomDurationController.text) ?? 0,
//         physical_symptom_frequency: int.tryParse(_physicalSymptomFrequencyController.text) ?? 0,
//         emotional_symptoms: _emotionalSymptomsController.text,
//         recovery_goal: _recoveryGoalController.text,
//         recovery_goal_time: _recoveryGoalTimeController.text,
//         progress_timeline: _progressTimelineController.text,
//         recovery_target_date: _recoveryTargetDateController.text,
//         reminder_from: _reminderFromController.text,
//         reminder_to: _reminderToController.text,
//       );
//
//       setState(() {
//         _isLoading = false;
//         _responseMessage = success ? 'Registration Successful (Form)!' : 'Registration Failed (Form)!';
//       });
//     } catch (e) {
//       setState(() {
//         _isLoading = false;
//         _responseMessage = 'Error (Form): $e';
//       });
//     }
//   }
//
//   // Function to handle API call with hardcoded JSON data
//   Future<void> _registerWithHardcodedData() async {
//     setState(() {
//       _isLoading = true;
//       _responseMessage = '';
//     });
//
//     try {
//       final success = await recoveryRegistrationApiRxObj.registerRecoveryUserApi(
//         name: "RH Robin",
//         email: "zobayer.dev@gmail.com",
//         phone: "1234567890",
//         password: "12345678",
//         password_confirmation: "12345678",
//         age: 30,
//         gender: "male",
//         user_mode: "recovery",
//         terms_accepted: true,
//         injury_name: "Ankle Sprain",
//         injury_level: "Moderate",
//         injury_date: "2025-10-01",
//         current_recovery_stage: "Early",
//         physical_symptom: 4,
//         physical_symptom_details: "Pain",
//         physical_symptom_duration: 30,
//         physical_symptom_frequency: 2,
//         emotional_symptoms: "Anxiety",
//         recovery_goal: "Full mobility",
//         recovery_goal_time: "6 weeks",
//         progress_timeline: "2 weeks",
//         recovery_target_date: "2025-11-24",
//         reminder_from: "08:00:00",
//         reminder_to: "20:00:00",
//       );
//
//       setState(() {
//         _isLoading = false;
//         _responseMessage = success ? 'Registration Successful (Hardcoded)!' : 'Registration Failed (Hardcoded)!';
//       });
//     } catch (e) {
//       setState(() {
//         _isLoading = false;
//         _responseMessage = 'Error (Hardcoded): $e';
//       });
//     }
//   }
//
//   // Build text field widget
//   Widget _buildTextField(TextEditingController controller, String label, {bool isNumber = false}) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8.0),
//       child: TextField(
//         controller: controller,
//         decoration: InputDecoration(
//           labelText: label,
//           border: const OutlineInputBorder(),
//         ),
//         keyboardType: isNumber ? TextInputType.number : TextInputType.text,
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Registration Test Screen'),
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             _buildTextField(_nameController, 'Name'),
//             _buildTextField(_emailController, 'Email'),
//             _buildTextField(_phoneController, 'Phone'),
//             _buildTextField(_passwordController, 'Password'),
//             _buildTextField(_passwordConfirmationController, 'Password Confirmation'),
//             _buildTextField(_ageController, 'Age', isNumber: true),
//             _buildTextField(_genderController, 'Gender'),
//             _buildTextField(_userModeController, 'User Mode'),
//             CheckboxListTile(
//               title: const Text('Accept Terms'),
//               value: _termsAccepted,
//               onChanged: (value) {
//                 setState(() {
//                   _termsAccepted = value ?? false;
//                 });
//               },
//             ),
//             _buildTextField(_injuryNameController, 'Injury Name'),
//             _buildTextField(_injuryLevelController, 'Injury Level'),
//             _buildTextField(_injuryDateController, 'Injury Date'),
//             _buildTextField(_currentRecoveryStageController, 'Current Recovery Stage'),
//             _buildTextField(_physicalSymptomController, 'Physical Symptom', isNumber: true),
//             _buildTextField(_physicalSymptomDetailsController, 'Physical Symptom Details'),
//             _buildTextField(_physicalSymptomDurationController, 'Physical Symptom Duration', isNumber: true),
//             _buildTextField(_physicalSymptomFrequencyController, 'Physical Symptom Frequency', isNumber: true),
//             _buildTextField(_emotionalSymptomsController, 'Emotional Symptoms'),
//             _buildTextField(_recoveryGoalController, 'Recovery Goal'),
//             _buildTextField(_recoveryGoalTimeController, 'Recovery Goal Time'),
//             _buildTextField(_progressTimelineController, 'Progress Timeline'),
//             _buildTextField(_recoveryTargetDateController, 'Recovery Target Date'),
//             _buildTextField(_reminderFromController, 'Reminder From'),
//             _buildTextField(_reminderToController, 'Reminder To'),
//             const SizedBox(height: 16),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 ElevatedButton(
//                   onPressed: _isLoading ? null : _registerWithForm,
//                   child: _isLoading
//                       ? const CircularProgressIndicator()
//                       : const Text('Register (Form)'),
//                 ),
//                 ElevatedButton(
//                   onPressed: _isLoading ? null : _registerWithHardcodedData,
//                   child: _isLoading
//                       ? const CircularProgressIndicator()
//                       : const Text('Register (Hardcoded)'),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 16),
//             Text(
//               _responseMessage,
//               style: TextStyle(
//                 color: _responseMessage.contains('Error') ? Colors.red : Colors.green,
//                 fontWeight: FontWeight.bold,
//               ),
//               textAlign: TextAlign.center,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }