import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:scan_contacts/components/models/contact_model.dart';
import 'package:scan_contacts/components/screens/contact_listing/contact_listing.dart';
import '../../utilities/constants.dart';
import '../../utilities/colors.dart';
import 'package:hive/hive.dart';

class CarouselIndicator extends StatefulWidget {
  final userId;
  final contactImage;
  final name;
  final address;
  final phoneNumber;
  final email;
  final companyName;
  CarouselIndicator(this.userId,this.contactImage, this.name, this.address,
      this.phoneNumber, this.email, this.companyName);
  @override
  State<StatefulWidget> createState() {
    return CarouselIndicatorState();
  }
}

class CarouselIndicatorState extends State<CarouselIndicator> {
  int currentPos = 0;

  final _formKey = GlobalKey<FormState>();
  static List<String> firstNameList = [null];
  static List<String> designationList = [null];
  static List<String> companyList = [null];
  static List<String> mobileList = [null];
  static List<String> emailList = [null];
  static List<String> addressList = [null];
  static String userFirstName = "";
  static String designationName = "";
  static String companyName = "";
  static String mobileNumber = "";
  static String userEmail = "";
  static String address = "";

  @override
  Widget build(BuildContext context) {
    List<String> listPaths = [
      widget.contactImage,
      'assets/icons/no_card.png',
    ];
    return Scaffold(
        appBar: AppBar(
          leading: GestureDetector(
              onTap: () {
                this.navigateToPreviousScreen();
              },
              child: Center(
                child: Text(
                  cancel,
                  style: TextStyle(
                      color: CommonColors.blue_color,
                      fontWeight: FontWeight.w500,
                      fontFamily: "Lato",
                      fontStyle: FontStyle.normal,
                      fontSize: 15.0),
                ),
              )),
          actions: <Widget>[
            Padding(
                padding: EdgeInsets.only(right: 20.0),
                child: GestureDetector(
                  onTap: () {
                    this.updatedUser();
                  },
                  child: Center(
                    child: Text(
                      done,
                      style: TextStyle(
                          color: CommonColors.blue_color,
                          fontWeight: FontWeight.w500,
                          fontFamily: "Lato",
                          fontStyle: FontStyle.normal,
                          fontSize: 15.0),
                    ),
                  ),
                )),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            CarouselSlider.builder(
              itemCount: listPaths.length,
              options: CarouselOptions(
                  autoPlay: false,
                  onPageChanged: (index, reason) {
                    setState(() {
                      currentPos = index;
                    });
                  }),
              itemBuilder: (context, index) {
                return CarouselImageView(listPaths[index]);
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: listPaths.map((url) {
                int index = listPaths.indexOf(url);
                return Container(
                  width: 8.0,
                  height: 8.0,
                  margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 1.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: currentPos == index
                        ? CommonColors.icon_color
                        : CommonColors.search_text,
                  ),
                );
              }).toList(),
            ),
            SizedBox(height: 10.0),
            Container(
                width: 375,
                height: 0.5,
                decoration: BoxDecoration(color: const Color(0xffe4e4e4))),
            Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Text("First Name:"),
                    ..._getFirstName(),
                    Container(
                        width: 375,
                        height: 0.5,
                        decoration:
                            BoxDecoration(color: const Color(0xffe4e4e4))),
                    Text("Designation:"),
                    ..._getDesignation(),
                    Container(
                        width: 375,
                        height: 0.5,
                        decoration:
                            BoxDecoration(color: const Color(0xffe4e4e4))),
                    Text("Company Name:"),
                    ..._getCompany(),
                    Container(
                        width: 375,
                        height: 0.5,
                        decoration:
                            BoxDecoration(color: const Color(0xffe4e4e4))),
                    Text("Email:"),
                    ..._getEmail(),
                    Text("Mobile Number:"),
                    ..._getMobile(),
                    Container(
                        width: 375,
                        height: 0.5,
                        decoration:
                            BoxDecoration(color: const Color(0xffe4e4e4))),
                    Text("Address:"),
                    ..._getAddress(),
                    Container(
                        width: 375,
                        height: 0.5,
                        decoration:
                            BoxDecoration(color: const Color(0xffe4e4e4))),
                  ],
                ),
              ),
            ),
          ]),
        ));
  }

  navigateToPreviousScreen() {
    Navigator.pop(context);
  }

  updatedUser() {
    final user = ContactModel(
        frontImage: widget.contactImage,
        userName: firstNameList[0] != null
            ? firstNameList[0].toString()
            : widget.name,
        companyName: companyList[0] != null
            ? companyList[0].toString()
            : widget.companyName,
        email: emailList[0] != null
            ? emailList[0].toString()
            : widget.email,
        address: addressList[0]!= null
            ? addressList[0].toString()
            : widget.address,
        mobileNumber: mobileList[0] != null
            ? mobileList[0].toString()
            : widget.phoneNumber,
        companyNumber: "",
        designations:
            designationList[0] != null ? designationList[0].toString() : ""
    );
    final cardContact = Hive.box('cardContact');
    cardContact.putAt(widget.userId, user);
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) {
      return new ContactListing();
    }));
  }

  List<Widget> _getFirstName() {
    List<Widget> firstNameTextFields = [];
    for (int i = 0; i < 1; i++) {
      firstNameTextFields.add(Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: Row(
          children: [
            _addRemoveButton(i == firstNameList.length - 1, i),
            SizedBox(
              width: 10,
            ),
            Expanded(child: DynamicTextFields(i, firstName, widget.name)),
          ],
        ),
      ));
    }
    return firstNameTextFields;
  }

  Widget _addRemoveButton(bool add, int index) {
    return InkWell(
      onTap: () {
        if (add) {
          firstNameList.insert(0, null);
        } else
          firstNameList.removeAt(index);
        setState(() {});
      },
      child: Container(
          width: 25,
          height: 25,
          decoration: BoxDecoration(
            color: (add) ? Colors.red : Colors.green,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Icon(
            (add) ? Icons.remove : Icons.add,
            color: Colors.white,
          )),
    );
  }

  List<Widget> _getDesignation() {
    List<Widget> designationTextFields = [];
    for (int i = 0; i < 1; i++) {
      designationTextFields.add(Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: Row(
          children: [
            _addDesignationRemoveButton(i == designationList.length - 1, i),
            SizedBox(
              width: 10,
            ),
            Expanded(child: DynamicTextFields(i, designation, "")),
          ],
        ),
      ));
    }
    return designationTextFields;
  }

  Widget _addDesignationRemoveButton(bool add, int index) {
    return InkWell(
      onTap: () {
        if (add) {
          designationList.insert(0, null);
        } else
          designationList.removeAt(index);
        setState(() {});
      },
      child: Container(
        width: 25,
        height: 25,
        decoration: BoxDecoration(
          color: (add) ? Colors.green : Colors.red,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Icon(
          (add) ? Icons.add : Icons.remove,
          color: Colors.white,
        ),
      ),
    );
  }

  List<Widget> _getCompany() {
    List<Widget> companyTextFields = [];
    for (int i = 0; i < companyList.length; i++) {
      companyTextFields.add(Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: Row(
          children: [
            _addCompanyRemoveButton(i == companyList.length - 1, i),
            SizedBox(
              width: 10,
            ),
            Expanded(child: DynamicTextFields(i, company, widget.companyName)),
          ],
        ),
      ));
    }
    return companyTextFields;
  }

  Widget _addCompanyRemoveButton(bool add, int index) {
    return InkWell(
      onTap: () {
        if (add) {
          companyList.insert(0, null);
        } else
          companyList.removeAt(index);
        setState(() {});
      },
      child: Container(
        width: 25,
        height: 25,
        decoration: BoxDecoration(
          color: (add) ? Colors.green : Colors.red,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Icon(
          (add) ? Icons.add : Icons.remove,
          color: Colors.white,
        ),
      ),
    );
  }

  List<Widget> _getMobile() {
    List<Widget> mobileTextFields = [];
    for (int i = 0; i < mobileList.length; i++) {
      mobileTextFields.add(Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: Row(
          children: [
            _addMobileRemoveButton(i == mobileList.length - 1, i),
            SizedBox(
              width: 10,
            ),
            Expanded(child: DynamicTextFields(i, mobile, widget.phoneNumber))
          ],
        ),
      ));
    }
    return mobileTextFields;
  }

  Widget _addMobileRemoveButton(bool add, int index) {
    return InkWell(
      onTap: () {
        if (add) {
          emailList.insert(0, null);
        } else
          emailList.removeAt(index);
        setState(() {});
      },
      child: Container(
        width: 25,
        height: 25,
        decoration: BoxDecoration(
          color: (add) ? Colors.green : Colors.red,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Icon(
          (add) ? Icons.add : Icons.remove,
          color: Colors.white,
        ),
      ),
    );
  }

  List<Widget> _getEmail() {
    List<Widget> emailTextFields = [];
    for (int i = 0; i < emailList.length; i++) {
      emailTextFields.add(Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: Row(
          children: [
            _addEmailRemoveButton(i == emailList.length - 1, i),
            SizedBox(
              width: 10,
            ),
            Expanded(child: DynamicTextFields(i, email, widget.email)),
          ],
        ),
      ));
    }
    return emailTextFields;
  }

  Widget _addEmailRemoveButton(bool add, int index) {
    return InkWell(
      onTap: () {
        if (add) {
          emailList.insert(0, null);
        } else
          emailList.removeAt(index);
        setState(() {});
      },
      child: Container(
        width: 25,
        height: 25,
        decoration: BoxDecoration(
          color: (add) ? Colors.green : Colors.red,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Icon(
          (add) ? Icons.add : Icons.remove,
          color: Colors.white,
        ),
      ),
    );
  }

  List<Widget> _getAddress() {
    List<Widget> addressTextFields = [];
    for (int i = 0; i < addressList.length; i++) {
      addressTextFields.add(Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: Row(
          children: [
            _addAddressRemoveButton(i == addressList.length - 1, i),
            SizedBox(
              width: 10,
            ),
            Expanded(child: DynamicTextFields(i, textAddress, widget.address)),
          ],
        ),
      ));
    }
    return addressTextFields;
  }

  Widget _addAddressRemoveButton(bool add, int index) {
    return InkWell(
      onTap: () {
        if (add) {
          addressList.insert(0, null);
        } else
          addressList.removeAt(index);
        setState(() {});
      },
      child: Container(
        width: 25,
        height: 25,
        decoration: BoxDecoration(
          color: (add) ? Colors.green : Colors.red,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Icon(
          (add) ? Icons.add : Icons.remove,
          color: Colors.white,
        ),
      ),
    );
  }
}

class CarouselImageView extends StatelessWidget {
  final String imgPath;
  CarouselImageView(this.imgPath);
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 334,
        width: 191,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(imgPath), fit: BoxFit.fitWidth)));
  }
}

class DynamicTextFields extends StatefulWidget {
  final int index;
  final String parameter;
  final String userDetails;
  DynamicTextFields(this.index, this.parameter, this.userDetails);
  @override
  _DynamicTextFieldsState createState() => _DynamicTextFieldsState();
}

class _DynamicTextFieldsState extends State<DynamicTextFields> {
  TextEditingController _nameController;
  TextEditingController _designationController;
  TextEditingController _companyController;
  TextEditingController _emailController;
  TextEditingController _addressController;
  TextEditingController _mobileController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _designationController = TextEditingController();
    _companyController = TextEditingController();
    _emailController = TextEditingController();
    _addressController = TextEditingController();
    _mobileController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _designationController.dispose();
    _companyController.dispose();
    _emailController.dispose();
    _addressController.dispose();
    _mobileController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _nameController.text =
          CarouselIndicatorState.firstNameList[widget.index] ??
          widget.userDetails;
      _designationController.text =
          CarouselIndicatorState.designationList[widget.index] ??
              widget.userDetails;
      _companyController.text =
          CarouselIndicatorState.companyList[widget.index] ??
              widget.userDetails;
      _addressController.text =
          CarouselIndicatorState.addressList[widget.index] ??
              widget.userDetails;
      _emailController.text =
          CarouselIndicatorState.emailList[widget.index] ??
              widget.userDetails;
      _mobileController.text =
          CarouselIndicatorState.mobileList[widget.index] ??
              widget.userDetails;
    });

    return widget.parameter == 'firstName'
        ? TextFormField(
            controller: _nameController,
            onChanged: (v) => {
              CarouselIndicatorState.firstNameList[widget.index] = _nameController.text,
            },
            decoration: InputDecoration.collapsed(
                hintText: 'add first name', border: InputBorder.none),
            validator: (v) {
              if (v.trim().isEmpty) return 'Please enter something';
              return null;
            },
          )
        : widget.parameter == 'designation'
            ? TextFormField(
                controller: _designationController,
                onChanged: (v) => {
                   CarouselIndicatorState.designationList[widget.index] = _designationController.text,
                },
                decoration: InputDecoration.collapsed(
                    hintText: 'add designation', border: InputBorder.none),
                validator: (v) {
                  if (v.trim().isEmpty) return 'Please enter something';
                  return null;
                },
              )
            : widget.parameter == 'company'
                ? TextFormField(
                    controller: _companyController,
                    onChanged: (v) =>
                        CarouselIndicatorState.companyList[widget.index] = _companyController.text,
                    decoration: InputDecoration.collapsed(
                        hintText: 'add company', border: InputBorder.none),
                    validator: (v) {
                      if (v.trim().isEmpty) return 'Please enter something';
                      return null;
                    },
                  )
                : widget.parameter == 'mobile'
                    ? TextFormField(
                        controller: _mobileController,
                        onChanged: (v) =>
                            CarouselIndicatorState.emailList[widget.index] = _mobileController.text,
                        decoration: InputDecoration.collapsed(
                            hintText: 'add mobile', border: InputBorder.none),
                        validator: (v) {
                          if (v.trim().isEmpty) return 'Please enter something';
                          return null;
                        },
                      )
                    : widget.parameter == 'email'
                        ? TextFormField(
                            controller: _emailController,
                            onChanged: (v) => CarouselIndicatorState
                                .emailList[widget.index] = _emailController.text ,
                            decoration: InputDecoration.collapsed(
                                hintText: 'add email',
                                border: InputBorder.none),
                            validator: (v) {
                              if (v.trim().isEmpty)
                                return 'Please enter something';
                              return null;
                            },
                          )
                        : widget.parameter == 'address'
                            ? TextFormField(
                                controller: _addressController,
                                maxLines: 8,
                                onChanged: (v) => CarouselIndicatorState
                                    .addressList[widget.index] = _addressController.text,
                                decoration: InputDecoration.collapsed(
                                    hintText: 'add address',
                                    border: InputBorder.none),
                                validator: (v) {
                                  if (v.trim().isEmpty)
                                    return 'Please enter something';
                                  return null;
                                },
                              )
                            : '';
  }
}
