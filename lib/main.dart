import 'package:flutter/material.dart';

void main() => runApp(RecipeManagerApp());

class RecipeManagerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Recipe Manager',
      theme: ThemeData(primarySwatch: Colors.orange),
      home: RecipeHomePage(),
    );
  }
}

class RecipeHomePage extends StatefulWidget {
  @override
  _RecipeHomePageState createState() => _RecipeHomePageState();
}

class _RecipeHomePageState extends State<RecipeHomePage> {
  final List<String> recipes = [];

  void _addRecipe() {
    TextEditingController controller = TextEditingController();
    String category = 'breakfast';

    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text('Add Recipe'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                DropdownButton<String>(
                  value: category,
                  onChanged: (value) => setState(() => category = value!),
                  items:
                      ['breakfast', 'lunch', 'dinner']
                          .map(
                            (cat) =>
                                DropdownMenuItem(value: cat, child: Text(cat)),
                          )
                          .toList(),
                ),
                TextField(
                  controller: controller,
                  decoration: InputDecoration(hintText: 'Recipe Name'),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  setState(() {
                    if (controller.text.isNotEmpty) {
                      recipes.add(controller.text.trim());
                    }
                  });
                  Navigator.pop(context);
                },
                child: Text('Add'),
              ),
            ],
          ),
    );
  }

  void _showRecipes() {
    showDialog(
      context: context,
      builder:
          (_) => AlertDialog(
            title: Text('Recipes'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: recipes.map((r) => Text(r)).toList(),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('Close'),
              ),
            ],
          ),
    );
  }

  void _deleteRecipe() {
    showDialog(
      context: context,
      builder:
          (_) => AlertDialog(
            title: Text('Delete Recipe'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children:
                  recipes
                      .map(
                        (r) => ListTile(
                          title: Text(r),
                          trailing: IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () {
                              setState(() => recipes.remove(r));
                              Navigator.pop(context);
                            },
                          ),
                        ),
                      )
                      .toList(),
            ),
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Mmmm Tastes Good :)")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: _showRecipes,
              child: Text('Open Recipes'),
            ),
            ElevatedButton(onPressed: _addRecipe, child: Text('Add Recipe')),
            ElevatedButton(
              onPressed: _deleteRecipe,
              child: Text('Delete Recipe'),
            ),
          ],
        ),
      ),
    );
  }
}
