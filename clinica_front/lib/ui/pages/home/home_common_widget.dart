import 'package:clinica_front/core/colors.dart';
import 'package:clinica_front/core/text.dart';
import 'package:clinica_front/ui/pages/common_widget/app_patient_search_bar.dart';
import 'package:clinica_front/ui/pages/common_widget/app_patient_tile.dart';
import 'package:clinica_front/ui/pages/common_widget/appbar.dart';
import 'package:clinica_front/ui/pages/home/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreenDesktop extends StatelessWidget {
  const HomeScreenDesktop({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width * 0.15;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: AppBarClinica(size: size, width: width),
      ),
      body: Consumer<HomeViewModel>(
        builder: (BuildContext context, HomeViewModel viewModel, Widget? child) {
          return Container(
            color: kLila20,
            child: Column(
              children: [
                SizedBox(height: 25),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _patientSearchBar(viewModel),
                      _addPatient('AÑADIR PACIENTE', width)
                    ],
                  ),
                ),
                SizedBox(height: 15),
                _pattientList(
                  Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(flex: 2, child: Text('NOMBRE DE PACIENTE', style: textStyle24)),
                    Expanded(flex: 2, child: Text('20-25483699-4', style: textBlackStyle24)),
                    Expanded(flex: 2,
                      child: Text(
                        'Calle José Ortega y Gasset, 40 - Tucumán, Argentina.',
                        style: textBlackStyle24,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                  ],
                )),
                SizedBox(height: 15),
              ],
            ),
          );
        },
      ),
    );
  }
}

class HomeScreenTablet extends StatelessWidget {
  const HomeScreenTablet({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width * 0.35;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: AppBarClinica(size: size, width: width),
      ),
      body: Consumer<HomeViewModel>(
        builder: (BuildContext context, HomeViewModel viewModel, Widget? child) {
          return Container(
            color: kLila20,
            child: Column(
              children: [
                SizedBox(height: 25),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _patientSearchBar(viewModel),
                      _addPatient('AÑADIR', width * 0.5)
                    ],
                  ),
                ),
                SizedBox(height: 15),
                _pattientList(
                  Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text('NOMBRE DE PACIENTE', style: textStyle24),
                    Text('20-25483699-4', style: textBlackStyle24),
                    Text('Calle José Ortega y Gasset, 40 - Tucumán, Argentina.', style: textBlackStyle24),
                  ],
                )),
                SizedBox(height: 15),
              ],
            ),
          );
        },
      ),
    );
  }
}

class HomeScreenMobile extends StatelessWidget {
  const HomeScreenMobile({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width * 0.45;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: AppBarClinica(size: size, width: width),
      ),
      floatingActionButton: FloatingActionButton(onPressed: null, backgroundColor: kPrimaryColor, child: Icon(Icons.add, color: kWhitePure)),
      body: Consumer<HomeViewModel>(
        builder: (BuildContext context, HomeViewModel viewModel, Widget? child) {
          return Container(
            color: kLila20,
            child: Column(
              children: [
                SizedBox(height: 25),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: _patientSearchBar(viewModel),
                ),
                SizedBox(height: 15),
                _pattientList(
                  Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text('NOMBRE DE PACIENTE', style: textStyle14),
                    Text('20-25483699-4', style: textBlackStyle14),
                    Text('Calle José Ortega y Gasset, 40 - Tucumán, Argentina.', style: textBlackStyle14),
                  ],
                )),
                SizedBox(height: 15),
              ],
            ),
          );
        },
      ),
    );
  }
}

AppPatientSearchBar _patientSearchBar(HomeViewModel viewModel) {
  return AppPatientSearchBar(
    onChanged: (value) => null,
    controller: viewModel.medicoSearchController,
    hintText: 'Ingresar DNI o Pasaporte',
  );
}


Expanded _pattientList(Widget body) {
  return Expanded(
    child: ListView.builder(
      itemCount: 50,
      physics: BouncingScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: 15),
      itemBuilder: (BuildContext context, int index) {
        return AppPatientTile(body: body);
      },
    ),
  );
}

ElevatedButton _addPatient(String title, double width){
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
        backgroundColor: kPrimaryColor,
        fixedSize: Size(width, 45),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
    onPressed: null,
    child: Text(title, style: textTitle, overflow: TextOverflow.ellipsis));
}