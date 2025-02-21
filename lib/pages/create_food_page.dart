import 'package:diet_app/controller/create_food_controller.dart';
import 'package:diet_app/widgets/bottom_bar_scaffold.dart';
import 'package:diet_app/widgets/input_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class CreateFoodPage extends StatelessWidget {
  const CreateFoodPage({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    return SafeArea(
      child: BottomBarScaffold(
        body: GetBuilder<CreateFoodController>(
            init: CreateFoodController(),
            builder: (c) {
              return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(14),
                      child: Row(
                        children: [Icon(Icons.close, size: 30), SizedBox(width: 14), Text('Criar alimento', style: textTheme.titleLarge)],
                      ),
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
                        InputTextField(controller: c.nameController, keyboardType: TextInputType.number, label: 'Nome do Alimento'),
                        SizedBox(height: 20),
                        InputTextField(
                            controller: c.standardQuantityController,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(RegExp(r'[0-9]')), // Allow only numbers
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
                        'Adicionar alimento',
                        style: textTheme.titleMedium!.copyWith(color: colorScheme.surface),
                      ),
                      onPressed: () {
                        c.createFood();
                        if (c.errorMessage.isNotEmpty) {
                          Get.snackbar(
                            'Erro ao criar alimento',
                            c.errorMessage,
                            duration: Duration(seconds: 3),
                            backgroundColor: colorScheme.error,
                            backgroundGradient: RadialGradient(
                              colors: [Color.fromRGBO(236, 72, 48, 0.0), Color.fromRGBO(236, 72, 48, 0.3)],
                            ),
                          );
                        }
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
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                ],
                suffix: unit,
                keyboardType: TextInputType.number)),
      ],
    );
  }
}
