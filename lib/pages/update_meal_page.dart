import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/meal_controller.dart';
import '../model/meal.dart';
import '../util/utils.dart';

class UpdateMealPage extends StatelessWidget {
  final Meal meal;

  UpdateMealPage({super.key, required this.meal});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Atualizar Refeição'),
        ),
        body: GetBuilder<MealController>(
          init: MealController(),
          builder: (c) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Text(
                    'Editar Alimentos da Refeição',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: ListView.builder(
                      itemCount: meal.eatEventList.length,
                      itemBuilder: (context, index) {
                        final eatEvent = meal.eatEventList[index];
                        final quantityController = TextEditingController(
                          text: eatEvent.quantity.toString(),
                        );

                        return Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 3,
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  eatEvent.eatable.name,
                                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  children: [
                                    Expanded(
                                      child: TextField(
                                        controller: quantityController,
                                        keyboardType: TextInputType.numberWithOptions(decimal: true),
                                        inputFormatters: [Utils.decimalInputFormatter()],
                                        decoration: InputDecoration(
                                          labelText: 'Quantidade',
                                          border: OutlineInputBorder(),
                                          isDense: true,
                                        ),
                                        onChanged: (value) {
                                          final newQuantity = double.tryParse(value);
                                          if (newQuantity != null) {
                                            eatEvent.quantity = newQuantity;
                                          }
                                        },
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    IconButton(
                                      icon: Icon(Icons.delete_forever_rounded, color: Colors.red),
                                      onPressed: () {
                                        meal.eatEventList.remove(eatEvent);
                                        c.update();
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton.icon(
                    onPressed: () {
                      c.updateMeal(meal);
                      Get.back();
                    },
                    icon: Icon(Icons.save_alt),
                    label: Text('Salvar Refeição'),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}