// ignore_for_file: unused_element, unused_field
import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:rawado/common_wigdets/auth_button.dart';
import 'package:rawado/common_wigdets/custom_appbar.dart';
import 'package:rawado/common_wigdets/custom_container.dart';
import 'package:rawado/common_wigdets/custom_dropdown.dart';
import 'package:rawado/features_trainer/service/presentation/widgets/location_select_bottomsheet.dart';
import 'package:rawado/gen/assets.gen.dart';
import 'package:rawado/helpers/di.dart';
import 'package:rawado/helpers/loading_helper.dart';
import 'package:rawado/helpers/toast.dart';
import 'package:rawado/helpers/ui_helpers.dart';
import 'package:rawado/networks/api_acess.dart';
import 'package:rawado/provider/address_provider.dart';

import '../../../common_wigdets/custom_textfiled.dart';
import '../../../common_wigdets/image_picker.dart';
import '../../../constants/text_font_style.dart';
import '../../../gen/colors.gen.dart';
import '../../../helpers/all_routes.dart';
import '../../../helpers/helper_methods.dart';
import '../../../helpers/navigation_service.dart';
import '../model/categories_response.dart';
import '../model/service_response.dart';

class ServiceAddScreen extends StatefulWidget {
  const ServiceAddScreen({super.key});

  @override
  State<ServiceAddScreen> createState() => _ServiceAddScreenState();
}

class _ServiceAddScreenState extends State<ServiceAddScreen> {
  // final _imageFileNotifier = ValueNotifier<String?>(null);
  final GlobalKey<FormState> _fromKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController serviceChargeController = TextEditingController();
  final TextEditingController descController = TextEditingController();
  String? _startTime;
  final _imageFileNotifier = ValueNotifier<File?>(null);
  List<File> imageList = [];

  CategoriesData? selectedCategories;

  @override
  void initState() {
    getCategoriesRXObj.getCategories();
    setData();
    // getCurrentLocation();
    super.initState();
  }

  void setData() {
    log('service type : ${appData.read('trainerName')}');
    nameController.text = appData.read('trainerName') ?? '';
    emailController.text = appData.read('emailAddress') ?? '';
    // TODO: NEED TO SOLVE ISSUE
    // selectedCategories = appData.read('servicetype');
    serviceChargeController.text = appData.read('serviceCharge') ?? '';
    descController.text = appData.read('description') ?? '';
    imageList = appData.read('imageFile') ?? [];
  }

  void removeData() {
    appData.remove('trainerName');
    appData.remove('emailAddress');
    // appData.remove('servicetype');
    appData.remove('serviceCharge');
    appData.remove('description');
    appData.remove('imageFile');
  }

  void getCurrentLocation() async {
    await getCurrentAddressFromLatLng(context);
  }

  @override
  void dispose() {
    emailController.dispose();
    nameController.dispose();
    serviceChargeController.dispose();
    descController.dispose();
    // removeData();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'SAVE',
        centerTitle: false,
      ),
      body: Form(
        key: _fromKey,
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.all(UIHelper.kDefaulutPadding()),
          children: [
            // Trainer name Text Filed
            Text(
              'TRAINER NAME',
              style: TextFontStyle.headline14StyleCabin500
                  .copyWith(color: AppColors.cA7A7A7),
            ),
            UIHelper.verticalSpace(8.h),
            _buildNameTextFiled(),
            UIHelper.verticalSpace(20.h),

            // Trainer email Text Filed
            Text(
              'EMAIL',
              style: TextFontStyle.headline14StyleCabin500
                  .copyWith(color: AppColors.cA7A7A7),
            ),
            UIHelper.verticalSpace(8.h),
            _buildEmailTextFiled(),
            UIHelper.verticalSpace(20.h),

            // Service Type Terxt Field
            Text(
              'SERVICE TYPE',
              style: TextFontStyle.headline14StyleCabin500
                  .copyWith(color: AppColors.cA7A7A7),
            ),
            UIHelper.verticalSpace(8.h),

            //Categories section
            buildCategoriesSection(),
            UIHelper.verticalSpace(20.h),

            // Service CHARGE Text Field
            Text(
              'SERVICE CHARGE',
              style: TextFontStyle.headline14StyleCabin500
                  .copyWith(color: AppColors.cA7A7A7),
            ),
            UIHelper.verticalSpace(8.h),
            _buildChargeTextFiled(),
            UIHelper.verticalSpace(20.h),

            // Location Text Field
            Text(
              'LOCATION',
              style: TextFontStyle.headline14StyleCabin500
                  .copyWith(color: AppColors.cA7A7A7),
            ),
            UIHelper.verticalSpace(8.h),

            // TODO(Need To Intrigration Map) Location Section
            buildAddressSection(),
            UIHelper.verticalSpace(20.h),

            // Location Text Field
            Text(
              'DESCRIPTION',
              style: TextFontStyle.headline14StyleCabin500
                  .copyWith(color: AppColors.cA7A7A7),
            ),
            UIHelper.verticalSpace(8.h),
            __buildDescriptionTextField(),
            UIHelper.verticalSpace(20.h),

            // Image Picker
            GestureDetector(
              onTap: () {
                _showImageSourceDialog(context);
              },
              child: CustomContainer(
                paddingEdgeInsets: EdgeInsets.zero,
                height: 150.h,
                boarder: 12.r,
                child: ValueListenableBuilder<File?>(
                  valueListenable: _imageFileNotifier,
                  builder: (context, imagePath, _) {
                    if (imagePath != null) {
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(12.r),
                        child: Image.file(
                          imagePath,
                          fit: BoxFit.cover,
                        ),
                      );
                    } else {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            Assets.images.galleryAdd.path,
                            height: 60.h,
                            width: 60.w,
                            fit: BoxFit.cover,
                          ),
                          Text(
                            'UPLOAD PHOTO',
                            style: TextFontStyle.headline14StyleCabin500
                                .copyWith(color: AppColors.cA7A7A7),
                          )
                        ],
                      );
                    }
                  },
                ),
              ),
            ),

            UIHelper.verticalSpace(20.h),

            AppCustomeButton(
                name: 'CONTINUE',
                onCallBack: () async {
                  if (_fromKey.currentState?.validate() ?? false) {
                    if (_imageFileNotifier.value == null) {
                      ToastUtil.showLongToast(
                          'Please Add Picture'.toUpperCase());
                    }
                    imageList.add(_imageFileNotifier.value!);

                    if (selectedCategories!.id == null) {
                      ToastUtil.showLongToast(
                          'Please Select Service Type'.toUpperCase());
                    }

                    if (selectedCategories!.id != null) {
                      Map data = {
                        "name": nameController.text,
                        "email": emailController.text,
                        "category_id": selectedCategories!.id!,
                        "charge": serviceChargeController.text,
                        "location": context.read<AddressProvider>().address,
                        "longitude": context.read<AddressProvider>().lon,
                        "latitude": context.read<AddressProvider>().lat,
                        "description": descController.text,
                        "images[]": imageList,
                      };
                      log("body data: $data");
                      CreateServiceResponse response =
                          await postServiceCreateRXObj
                              .serviceCreate(
                                nameController.text,
                                emailController.text,
                                selectedCategories!.id!,
                                serviceChargeController.text,
                                context.read<AddressProvider>().lat!,
                                context.read<AddressProvider>().lon!,
                                descController.text,
                                context.read<AddressProvider>().address!,
                                imageList,
                              )
                              .waitingForFuture();

                      // .then((value) {
                      _imageFileNotifier.value = null;

                      await getServiceDetailsRXObj
                          .getServiceDetails(response.data!.id!);
                      await getAvailableServiceRXObj
                          .getAvailableService(response.data!.id!);
                      // NavigationService.navigateToReplacement(Routes.serviceDetails, );
                      removeData();
                      await NavigationService.navigateToReplacementWithObj(
                          Routes.serviceDetails, response.data!.id);
                      // });
                    }
                  }
                },
                height: 54.h,
                minWidth: double.infinity,
                borderRadius: 40.r,
                color: appColor(),
                textStyle: TextFontStyle.headline18StyleCabin700
                    .copyWith(color: appTextColor()),
                context: context)
          ],
        ),
      ),
    );
  }

  CustomTextFormField __buildDescriptionTextField() {
    return CustomTextFormField(
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please Enter Description'.toUpperCase();
        }
        return null;
      },
      borderRadius: 12.r,
      maxLine: 4,
      controller: descController,
      isPrefixIcon: false,
      hintText: 'WRITE THERE....',
    );
  }

  CustomTextFormField _buildChargeTextFiled() {
    return CustomTextFormField(
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please Enter Service Charge'.toUpperCase();
        }
        return null;
      },
      controller: serviceChargeController,
      isPrefixIcon: false,
      hintText: 'ENTER YOU SERVICE CHARGE',
    );
  }

  CustomTextFormField _buildEmailTextFiled() {
    return CustomTextFormField(
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please Enter Your Email'.toUpperCase();
        }
        return null;
      },
      controller: emailController,
      isPrefixIcon: false,
      hintText: 'ENTER EMAIL ADDRESS',
    );
  }

  CustomTextFormField _buildNameTextFiled() {
    return CustomTextFormField(
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please Enter Your Name'.toUpperCase();
        }
        return null;
      },
      controller: nameController,
      isPrefixIcon: false,
      hintText: 'ENTER TRAINER NAME',
    );
  }

  Consumer<AddressProvider> buildAddressSection() {
    return Consumer<AddressProvider>(builder: (context, address, _) {
      return GestureDetector(
        onTap: () {
          appData.write('trainerName', nameController.text);
          appData.write('emailAddress', emailController.text);
          // appData.write('servicetype', selectedCategories);
          appData.write('serviceCharge', serviceChargeController.text);
          appData.write('description', descController.text);
          appData.write('imageFile', imageList);
          log('onTap location');
          getCurrentLocation();
          showBottom(context);
        },
        child: CustomContainer(
          height: 54.h,
          boarder: 40.r,
          paddingEdgeInsets:
              EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          child: Text(
            address.address ?? 'ENTER LOCATION',
            style: TextFontStyle.headline16StyleCabin500
                .copyWith(color: AppColors.c5A5C5F),
          ),
        ),
      );
    });
  }

  StreamBuilder<CategoriesResponse> buildCategoriesSection() {
    return StreamBuilder(
        stream: getCategoriesRXObj.dataFetcher,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else if (snapshot.hasData) {
            final data = snapshot.data!.data;
            return Center(
              child: CustomDropdown<CategoriesData>(
                  borderRadius: BorderRadius.circular(40.r),
                  hint: 'ENTER YOUR SERVICE',
                  items: data!,
                  selectedItem: selectedCategories,
                  itemToString: (data) => data.name!.toUpperCase(),
                  onChanged: (value) {
                    setState(() {
                      selectedCategories = value;
                      log('selectedCategories is : ${selectedCategories!.id}');
                    });
                  }),
            );
          } else {
            return Center(
              child: CustomContainer(
                height: 54.h,
                boarder: 40.r,
                paddingEdgeInsets:
                    EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                child: Text(
                  'LOADING....',
                  style: TextFontStyle.headline16StyleCabin500
                      .copyWith(color: AppColors.c5A5C5F),
                ),
              ),
            );
          }
        });
  }

  void _showImageSourceDialog(BuildContext context) {
    showCupertinoModalPopup(
      context: context,
      builder: (_) => ImageSourceDialog(
        onImageSelected: (String imagePath) {
          _imageFileNotifier.value = File(imagePath);
        },
      ),
    );
  }

  void showBottom(BuildContext context) {
    showModalBottomSheet(
      elevation: 0,
      context: context,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.transparent,
      builder: (builder) {
        return LocationBottomSheet(
          onTapConfirm: () {
            NavigationService.goBack;
            NavigationService.navigateToReplacement(Routes.gpsSearch);
          },
        );
      },
    );
  }

  Future<void> _selectCupertinoTimePicker(BuildContext context) async {
    showCupertinoModalPopup(
      context: context,
      builder: (_) => Container(
        height: 250,
        color: AppColors.c1C1C1C,
        child: Column(
          children: [
            SizedBox(
              height: 180,
              child: CupertinoDatePicker(
                showDayOfWeek: true,
                mode: CupertinoDatePickerMode.time,
                initialDateTime: DateTime.now(),
                onDateTimeChanged: (DateTime newDateTime) {
                  setState(() {
                    // Format the time to 'HH:mm'
                    _startTime = DateFormat('HH:mm a').format(newDateTime);
                  });
                },
                use24hFormat: false, // Use 24-hour format
              ),
            ),
            CupertinoButton(
              child: const Text('Done'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        ),
      ),
    );
  }

  // Future<void> _selectDateTime() async {
  //   // Then, pick the time
  //   final TimeOfDay? pickedTime = await showTimePicker(
  //     context: context,
  //     initialTime: TimeOfDay.fromDateTime(DateTime.now()),
  //   );

  //   if (pickedTime != null) {
  //     // Combine the picked date and time into a single DateTime object
  //     final selectedDateTime = DateTime(
  //       pickedTime.hour,
  //       pickedTime.minute,
  //     );

  //     setState(() {
  //       _startTime = DateFormat('HH:mm').format(selectedDateTime);
  //     });
  //   }
  // }
}
