import 'package:clinica_front/core/colors.dart';
import 'package:clinica_front/core/text.dart';
import 'package:clinica_front/data/model/paciente.dart';
import 'package:clinica_front/ui/common_widget/app_patient_search_bar.dart';
import 'package:clinica_front/ui/common_widget/app_patient_tile.dart';
import 'package:clinica_front/ui/common_widget/appbar.dart';
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
                      _addPatient('AÑADIR PACIENTE', width, viewModel, context)
                    ],
                  ),
                ),
                SizedBox(height: 15),
                _pattientList(viewModel, textStyle24, textBlackStyle24, isDesktop: true),
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
                      _addPatient('AÑADIR', width * 0.5, viewModel, context)
                    ],
                  ),
                ),
                SizedBox(height: 15),
                _pattientList(viewModel, textStyle24, textBlackStyle24),
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
    return Consumer<HomeViewModel>(
      builder: (BuildContext context, HomeViewModel viewModel, Widget? child) {
        return Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(kToolbarHeight),
            child: AppBarClinica(size: size, width: width),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () => viewModel.navigationReplace(path: '/edit'),
            backgroundColor: kPrimaryColor,
            child: Icon(Icons.add, color: kWhitePure),
          ),
          body: Container(
            color: kLila20,
            child: Column(
              children: [
                SizedBox(height: 25),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: _patientSearchBar(viewModel),
                ),
                SizedBox(height: 15),
                _pattientList(viewModel, textStyle14, textBlackStyle14),
                SizedBox(height: 15),
              ],
            ),
          ),
        );
      },
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

Expanded _pattientList(HomeViewModel viewModel, TextStyle textStyle1, TextStyle textStyle2, {bool isDesktop = false}) {
  return Expanded(
    child: FutureBuilder<List<Paciente>>(
      future: viewModel.pacientesRepositoryImp.getPaciente(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator(color: kPrimaryColor));
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('No patients found.'));
        }
        return ListView.builder(
          itemCount: snapshot.data!.length,
          physics: BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 15),
          itemBuilder: (BuildContext context, int index) {
            return AppPatientTile(
              onTap: () => viewModel.navigationReplace(path: '/patient/${snapshot.data![index].pacienteId.toString()}'), // Pass the patient ID
              body: _buildPatientDetails(snapshot.data![index].persona, 
              textStyle1, textStyle2, isDesktop: isDesktop));
          },
        );
      },
    ),
  );
}

Widget _buildPatientDetails(Persona persona, TextStyle textStyle1, TextStyle textStyle2,{bool isDesktop = false}) {
  String direction = '${persona.direccion.calle} ${persona.direccion.altura}, ${persona.direccion.localidad}, ${persona.direccion.provincia}';
  return isDesktop ? Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: [
        Text(persona.nombreApellido, style: textStyle1),
        Text(persona.dni, style: textStyle2),
        Text(direction, style: textStyle2),
    ],
  ) : Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: [
      Text(persona.nombreApellido, style: textStyle1),
      Text(persona.dni, style: textStyle2),
      Text(direction, style: textStyle2),
    ],
  );
}

ElevatedButton _addPatient(String title, double width, HomeViewModel viewModel, BuildContext context){
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
        backgroundColor: kPrimaryColor,
        fixedSize: Size(width, 45),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
    onPressed: () => viewModel.navigationReplace(path: '/edit'),
    child: Text(title, style: textTitle, overflow: TextOverflow.ellipsis));
}