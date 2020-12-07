import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import '../../utilities/constants.dart';
import '../../utilities/colors.dart';

class CarouselIndicator extends StatefulWidget {
  final contact_image;
  final name;
  final address;
  final phone_number;
  final email;
  final company_name;
  CarouselIndicator(this.contact_image,this.name, this.address, this.phone_number, this.email, this.company_name);
  @override
  State<StatefulWidget> createState() {
    return CarouselIndicatorState();
  }
}

class CarouselIndicatorState extends State<CarouselIndicator> {
  int currentPos = 0;

  final _formKey = GlobalKey<FormState>();
  static List<String> firstNameList = [null];
  static List<String> lastNameList = [null];
  static List<String> companyList = [null];
  static List<String> emailList = [null];
  static List<String> addressList = [null];

  @override
  Widget build(BuildContext context) {
    List<String> listPaths = [
      widget.contact_image,
      'assets/icons/no_card.png',
    ];
    return Scaffold(
        appBar: AppBar(
          leading: GestureDetector(
              onTap: () {/* Write listener code here */},
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
                    if (_formKey.currentState.validate()) {
                      _formKey.currentState.save();
                    }
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
                    ..._getFirstName(),
                    Container(
                        width: 375,
                        height: 0.5,
                        decoration:
                            BoxDecoration(color: const Color(0xffe4e4e4))),
                    ..._getLastName(),
                    Container(
                        width: 375,
                        height: 0.5,
                        decoration:
                            BoxDecoration(color: const Color(0xffe4e4e4))),
                    ..._getCompany(),
                    Container(
                        width: 375,
                        height: 0.5,
                        decoration:
                            BoxDecoration(color: const Color(0xffe4e4e4))),
                    ..._getEmail(),
                    Container(
                        width: 375,
                        height: 0.5,
                        decoration:
                            BoxDecoration(color: const Color(0xffe4e4e4))),
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
            Expanded(child: DynamicTextFields(i, firstName)),
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

  List<Widget> _getLastName() {
    List<Widget> lastNameTextFields = [];
    for (int i = 0; i < lastNameList.length; i++) {
      lastNameTextFields.add(Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: Row(
          children: [
            _addLastNameRemoveButton(i == lastNameList.length - 1, i),
            SizedBox(
              width: 10,
            ),
            Expanded(child: DynamicTextFields(i, lastName)),
          ],
        ),
      ));
    }
    return lastNameTextFields;
  }

  Widget _addLastNameRemoveButton(bool add, int index) {
    return InkWell(
      onTap: () {
        if (add) {
          lastNameList.insert(0, null);
        } else
          lastNameList.removeAt(index);
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
            Expanded(child: DynamicTextFields(i, company)),
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
            Expanded(child: DynamicTextFields(i, email)),
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
            Expanded(child: DynamicTextFields(i, email)),
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
  String imgPath;
  CarouselImageView(this.imgPath);
  @override
  Widget build(BuildContext context) {
    return  Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(imgPath),
                fit: BoxFit.fitWidth))
    );
  }
}

class DynamicTextFields extends StatefulWidget {
  final int index;
  final String parameter;
  DynamicTextFields(this.index, this.parameter);
  @override
  _DynamicTextFieldsState createState() => _DynamicTextFieldsState();
}

class _DynamicTextFieldsState extends State<DynamicTextFields> {
  TextEditingController _nameController;
  TextEditingController _lastNameController;
  TextEditingController _companyController;
  TextEditingController _emailController;
  TextEditingController _addressController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _lastNameController = TextEditingController();
    _companyController = TextEditingController();
    _emailController = TextEditingController();
    _addressController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _lastNameController.dispose();
    _companyController.dispose();
    _emailController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _nameController.text =
          CarouselIndicatorState.firstNameList[widget.index] ?? '';
      _lastNameController.text =
          CarouselIndicatorState.lastNameList[widget.index] ?? '';
      _companyController.text =
          CarouselIndicatorState.companyList[widget.index] ?? '';
      _addressController.text =
          CarouselIndicatorState.addressList[widget.index] ?? '';
      _emailController.text =
          CarouselIndicatorState.emailList[widget.index] ?? '';
    });

    return widget.parameter == 'firstName'
        ? TextFormField(
            controller: _nameController,
            onChanged: (v) =>
                CarouselIndicatorState.firstNameList[widget.index] = v,
            decoration: InputDecoration.collapsed(
                hintText: 'add firstname', border: InputBorder.none),
            validator: (v) {
              if (v.trim().isEmpty) return 'Please enter something';
              return null;
            },
          )
        : widget.parameter == 'lastName'
            ? TextFormField(
                controller: _lastNameController,
                onChanged: (v) =>
                    CarouselIndicatorState.lastNameList[widget.index] = v,
                decoration: InputDecoration.collapsed(
                    hintText: 'add lastName', border: InputBorder.none),
                validator: (v) {
                  if (v.trim().isEmpty) return 'Please enter something';
                  return null;
                },
              )
            : widget.parameter == 'company'
                ? TextFormField(
                    controller: _companyController,
                    onChanged: (v) =>
                        CarouselIndicatorState.companyList[widget.index] = v,
                    decoration: InputDecoration.collapsed(
                        hintText: 'add company', border: InputBorder.none),
                    validator: (v) {
                      if (v.trim().isEmpty) return 'Please enter something';
                      return null;
                    },
                  )
                : widget.parameter == 'email'
                    ? TextFormField(
                        controller: _emailController,
                        onChanged: (v) =>
                            CarouselIndicatorState.emailList[widget.index] = v,
                        decoration: InputDecoration.collapsed(
                            hintText: 'add email', border: InputBorder.none),
                        validator: (v) {
                          if (v.trim().isEmpty) return 'Please enter something';
                          return null;
                        },
                      )
                    : widget.parameter == 'address'
                        ? TextFormField(
                            controller: _addressController,
                            onChanged: (v) => CarouselIndicatorState
                                .addressList[widget.index] = v,
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
