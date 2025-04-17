import 'package:flutter/material.dart';

void main() {
  runApp(RecipeApp());
}

List<Recipe> recipeList = [];

class RecipeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simple Recipe App',
      theme: ThemeData(primarySwatch: Colors.orange),
      home: MainMenu(),
    );
  }
}

class MainMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("MY RECIPE MANAGER")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              child: Text("Add Recipe"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddRecipeScreen()),
                );
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              child: Text("View Recipes"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ViewRecipesScreen()),
                );
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              child: Text("Edit Recipes"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EditRecipesScreen()),
                );
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              child: Text("Delete Recipes"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DeleteRecipesScreen(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class AddRecipeScreen extends StatefulWidget {
  @override
  _AddRecipeScreenState createState() => _AddRecipeScreenState();
}

class _AddRecipeScreenState extends State<AddRecipeScreen> {
  final nameController = TextEditingController();
  final ingredientsController = TextEditingController();
  final instructionsController = TextEditingController();
  String selectedCategory = "breakfast";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add Recipe")),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: ListView(
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: "Recipe Name"),
            ),
            DropdownButton<String>(
              value: selectedCategory,
              onChanged: (value) => setState(() => selectedCategory = value!),
              items:
                  ["breakfast", "lunch", "dinner"]
                      .map(
                        (cat) => DropdownMenuItem(value: cat, child: Text(cat)),
                      )
                      .toList(),
            ),
            TextField(
              controller: ingredientsController,
              decoration: InputDecoration(
                labelText: "Ingredients (comma separated)",
              ),
              maxLines: 3,
            ),
            TextField(
              controller: instructionsController,
              decoration: InputDecoration(labelText: "Instructions"),
              maxLines: 4,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              child: Text("Save"),
              onPressed: () {
                recipeList.add(
                  Recipe(
                    nameController.text,
                    selectedCategory,
                    ingredientsController.text
                        .split(',')
                        .map((e) => e.trim())
                        .toList(),
                    instructionsController.text,
                  ),
                );
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class ViewRecipesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Recipes")),
      body:
          recipeList.isEmpty
              ? Center(child: Text("No recipes added."))
              : ListView.builder(
                itemCount: recipeList.length,
                itemBuilder: (context, index) {
                  final recipe = recipeList[index];
                  return ListTile(
                    title: Text(recipe.name),
                    subtitle: Text(recipe.category),
                    onTap:
                        () => showDialog(
                          context: context,
                          builder:
                              (_) => AlertDialog(
                                title: Text(recipe.name),
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Category: ${recipe.category}"),
                                    SizedBox(height: 8),
                                    Text(
                                      "Ingredients:\n${recipe.ingredients.join(', ')}",
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      "Instructions:\n${recipe.instructions}",
                                    ),
                                  ],
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: Text("Close"),
                                  ),
                                ],
                              ),
                        ),
                  );
                },
              ),
    );
  }
}

class EditRecipesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Edit Recipes")),
      body: Center(child: Text("Edit Recipes Screen ")),
    );
  }
}

class DeleteRecipesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Delete Recipes")),
      body: Center(child: Text("Delete Recipes Screen ")),
    );
  }
}

class Recipe {
  final String name;
  final String category;
  final List<String> ingredients;
  final String instructions;

  Recipe(this.name, this.category, this.ingredients, this.instructions);
}
