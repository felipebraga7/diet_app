import 'package:diet_app/controller/create_food_controller.dart';
import 'package:diet_app/model/food.dart';
import 'package:diet_app/widgets/input_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class CreateUpdateFoodPage extends StatelessWidget {
  final Food? food;

  CreateUpdateFoodPage({this.food, super.key}) {}

  @override
  Widget build(BuildContext context) {
    final bool isEdit = food != null;
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    return SafeArea(
      child: Scaffold(
        body: GetBuilder<CreateUpdateFoodController>(
            init: CreateUpdateFoodController(food: food ?? Food.empty()),
            builder: (c) {
              return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Column(
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: () => Get.back(),
                            child: Padding(
                              padding: const EdgeInsets.all(14.0),
                              child: Icon(Icons.close, size: 30),
                            )),
                        Text(isEdit ? 'Atualizar alimento' : 'Criar alimento', style: textTheme.titleLarge)
                      ],
                    ),
                    Divider(
                      height: 4,
                      thickness: 4,
                      color: colorScheme.primary,
                    )
                  ],
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Informações básicas', style: textTheme.titleMedium),
                        SizedBox(height: 20),
                        InputTextField(controller: c.nameController, requestFocus: true, label: 'Nome do Alimento'),
                        SizedBox(height: 20),
                        InputTextField(
                            controller: c.standardQuantityController,
                            keyboardType: TextInputType.numberWithOptions(decimal: true),
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')), // Allow only numbers
                            ],
                            suffix: 'g',
                            label: 'Porção padrão do alimento'),
                        SizedBox(height: 20),
                        Text('Informações nutricionais', style: textTheme.titleMedium),
                        SizedBox(height: 20),
                        _getNutritionalItem(context, 'Calorias', 'kcal', c.caloriesController),
                        SizedBox(height: 20),
                        _getNutritionalItem(context, 'Carboidratos', 'g', c.carbsController),
                        SizedBox(height: 20),
                        _getNutritionalItem(context, 'Proteína', 'g', c.proteinController),
                        SizedBox(height: 20),
                        _getNutritionalItem(context, 'Gordura', 'g', c.fatController),
                        SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: SizedBox(
                    width: double.infinity,
                    child: TextButton(
                      child: Text(
                        isEdit ? 'Atualizar alimento' : 'Adicionar alimento',
                        style: textTheme.titleMedium!.copyWith(color: colorScheme.surface),
                      ),
                      onPressed: () {
                        c.saveFood();
                        if (c.errorMessage.isNotEmpty) {
                          Get.snackbar(
                            'Erro ao ${isEdit ? 'atualizar' : 'criar'} alimento',
                            c.errorMessage,
                            duration: Duration(seconds: 3),
                            backgroundColor: colorScheme.error,
                            backgroundGradient: RadialGradient(
                              colors: [Color.fromRGBO(236, 72, 48, 0.0), Color.fromRGBO(236, 72, 48, 0.3)],
                            ),
                          );
                          return;
                        }
                        Get.back();
                        Get.snackbar(
                          'Sucesso!',
                          'Alimento ${isEdit ? 'atualizado' : 'criado'}',
                          duration: Duration(seconds: 3),
                          backgroundColor: colorScheme.primary, // criar gradiente
                        );
                      },
                    ),
                  ),
                ),
                SizedBox(height: 20),
              ]);
            }),
      ),
    );
  }

  Widget _getNutritionalItem(BuildContext context, String title, String unit, TextEditingController controller) {
    final textTheme = Theme.of(context).textTheme;
    return Row(
      children: [
        Expanded(child: Text(title, style: textTheme.titleSmall)),
        SizedBox(width: 10),
        Expanded(
            child: InputTextField(
                controller: controller,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
                ],
                suffix: unit,
                keyboardType: TextInputType.numberWithOptions(decimal: true))),
      ],
    );
  }
}
