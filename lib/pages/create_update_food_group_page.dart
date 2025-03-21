import 'package:diet_app/controller/create_update_food_group_controller.dart';
import 'package:diet_app/core/app_theme.dart';
import 'package:diet_app/model/food.dart';
import 'package:diet_app/model/food_group.dart';
import 'package:diet_app/widgets/food_picker_dialog.dart';
import 'package:diet_app/widgets/input_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class CreateUpdateFoodGroupPage extends StatelessWidget {
  final FoodGroup? foodGroup;

  const CreateUpdateFoodGroupPage({required this.foodGroup, super.key});

  @override
  Widget build(BuildContext context) {
    final bool isEdit = foodGroup != null;
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
                    Text(
                        isEdit
                            ? 'Atualizar grupo de alimentos'
                            : 'Criar grupo de alimentos',
                        style: textTheme.titleLarge)
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
              child: SingleChildScrollView(
                child: GetBuilder<CreateUpdateFoodGroupController>(
                    init: CreateUpdateFoodGroupController(foodGroup: foodGroup),
                    builder: (c) {
                      return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(14.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  InputTextField(
                                      controller: c.nameController,
                                      requestFocus: true,
                                      label: 'Nome do Alimento'),
                                  SizedBox(height: 20),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Alimentos',
                                          style: textTheme.titleMedium),
                                      GestureDetector(
                                        onTap: () async {
                                          Food? selectedFood = await showDialog(
                                            context: context,
                                            builder: (context) {
                                              return EatablePickerDialog(showFoodGroups: false);
                                            },
                                          );
                                          if (selectedFood != null) {
                                            c.addFood(selectedFood);
                                          }
                                        },
                                        child: Container(
                                          width: 40,
                                          height: 40,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: colorScheme.onPrimary,
                                            boxShadow: [
                                              BoxShadow(
                                                color: colorScheme.inverseSurface.withValues(alpha: 0.3),
                                                spreadRadius: 2,
                                                blurRadius: 5,
                                                offset: const Offset(0, 3),
                                              ),
                                            ],
                                          ),
                                          child: Center(
                                            child: Icon(
                                              Icons.add,
                                              color: colorScheme.primary,
                                              size: 20,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 20),
                                  ListView.separated(
                                    shrinkWrap: true,
                                    physics: const NeverScrollableScrollPhysics(),
                                    itemCount: c.selectedFoodQuantityList.length,
                                    separatorBuilder: (context, index) {
                                      return const SizedBox(height: 12);
                                    },
                                    itemBuilder: (context, index) {
                                      final fqHelper = c.selectedFoodQuantityList[index];
                                      return Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          Expanded(
                                            child: ListTile(
                                              contentPadding: EdgeInsets.zero,
                                              leading: Icon(
                                                  Icons.breakfast_dining,
                                                  size: 44,
                                                  color: Color(0xff4FD1C5)),
                                              title: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    fqHelper.food.name,
                                                    style:
                                                        textTheme.titleMedium,
                                                  ),
                                                  const SizedBox(height: 6),
                                                  Text(
                                                    fqHelper.food.nutritionData,
                                                    style: textTheme.bodySmall!.copyWith(
                                                      fontSize: 10,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 8),
                                          Expanded(
                                            child: InputTextField(
                                                controller: fqHelper.controller,
                                                inputFormatters: [
                                                  FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
                                                ],
                                                suffix: 'g',
                                                keyboardType: TextInputType.numberWithOptions(decimal: true)),
                                          ),
                                          const SizedBox(width: 8),
                                          GestureDetector(
                                            child: Icon(
                                              Icons.delete_forever,
                                              color: colorScheme.error,
                                              size: 16,
                                            ),
                                            onTap: () => c.removeFood(fqHelper),
                                          )
                                        ],
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(14.0),
                              child: Column(
                                children: [
                                  SizedBox(
                                    width: double.infinity,
                                    child: TextButton(
                                      child: Text(
                                        isEdit
                                            ? 'Atualizar grupo'
                                            : 'Criar grupo',
                                        style: textTheme.titleMedium!.copyWith(
                                            color: colorScheme.surface),
                                      ),
                                      onPressed: () {
                                        c.saveFoodGroup();
                                        if (c.errorMessage.isNotEmpty) {
                                          Get.snackbar(
                                            'Erro ao ${isEdit ? 'atualizar' : 'criar'} grupo',
                                            c.errorMessage,
                                            duration: Duration(seconds: 3),
                                            backgroundColor: colorScheme.error,
                                            backgroundGradient: RadialGradient(
                                              colors: [
                                                colorScheme.errorGradientEnd,
                                                colorScheme.errorGradientStart
                                              ],
                                            ),
                                          );
                                          return;
                                        } else {
                                          Get.back(result: {'action': 'save', 'food': c.foodGroup});
                                        }
                                      },
                                    ),
                                  ),
                                  if (isEdit) ...[
                                    SizedBox(height: 10),
                                    SizedBox(
                                      width: double.infinity,
                                      child: TextButton(
                                        style: TextButton.styleFrom(
                                          backgroundColor: Colors.red,
                                        ),
                                        child: Text(
                                          'Excluir grupo de alimentos',
                                          style: textTheme.titleMedium!
                                              .copyWith(
                                                  color: colorScheme.surface),
                                        ),
                                        // TODO: mover código de alertas para um lugar em comum, reduzir código duplicado
                                        onPressed: () {
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                title: Text(
                                                  'Confirmar exclusão',
                                                  style: textTheme.titleMedium!,
                                                ),
                                                content: Text(
                                                  'Tem certeza que deseja excluir este grupo?',
                                                  style: textTheme.titleMedium!.copyWith(fontWeight: FontWeight.normal),
                                                ),
                                                actions: <Widget>[
                                                  TextButton(
                                                    style: TextButton.styleFrom(
                                                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                                      minimumSize: Size(0, 0),
                                                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                                    ),
                                                    child: Text(
                                                      'Cancelar',
                                                      style: textTheme.titleMedium!.copyWith(color: colorScheme.surface),
                                                    ),
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                  ),
                                                  TextButton(
                                                    style: TextButton.styleFrom(backgroundColor: Colors.red,
                                                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                                      minimumSize: Size(0, 0),
                                                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                                    ),
                                                    child: Text(
                                                      'Excluir',
                                                      style: textTheme.titleMedium!.copyWith(color: colorScheme.surface),
                                                    ),
                                                    onPressed: () {
                                                      Navigator.of(context).pop();
                                                      Get.back(result: {'action': 'delete', 'food': c.foodGroup});
                                                    },
                                                  ),
                                                ],
                                              );
                                            },
                                          );
                                        },
                                      ),
                                    ),
                                  ]
                                ],
                              ),
                            ),
                            SizedBox(height: 20),
                          ]);
                    }),
              ),
            )
          ],
        ),
      ),
    );
  }
}
