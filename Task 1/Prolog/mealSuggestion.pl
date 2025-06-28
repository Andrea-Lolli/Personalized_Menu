% Meal Definitions
% meal(MealName, Course).
meal(bruschette_al_pomodoro, appetizer).
meal(caprese, appetizer).
meal(spaghetti_alla_carbonara, main_dish).
meal(risotto_ai_funghi, main_dish).
meal(lasagna_alla_bolognese, main_dish).
meal(penne_all_arrabbiata, main_dish).
meal(bistecca_alla_fiorentina, second_course).
meal(pollo_alla_cacciatora, second_course).
meal(melanzane_alla_parmigiana, second_course).
meal(margherita, pizza).
meal(diavola, pizza).
meal(prosciutto_e_funghi, pizza).
meal(fornarina, pizza).
meal(gluten_free_margherita, pizza).
meal(tiramisu, dessert).
meal(panna_cotta, dessert).
meal(biscotti, dessert).

% Ingredients per Meal
% meal_ingredients(Meal, [Ingredients]).
meal_ingredients(bruschette_al_pomodoro, [bread, tomato, garlic, olive_oil]).
meal_ingredients(caprese, [tomato, mozzarella, basil, olive_oil]).
meal_ingredients(spaghetti_alla_carbonara, [spaghetti, egg, pancetta, cheese]).
meal_ingredients(risotto_ai_funghi, [rice, mushrooms, butter, cheese]).
meal_ingredients(lasagna_alla_bolognese, [pasta, beef, cheese, egg]).
meal_ingredients(penne_all_arrabbiata, [penne, tomato, garlic, chili, olive_oil]).
meal_ingredients(bistecca_alla_fiorentina, [beef]).
meal_ingredients(pollo_alla_cacciatora, [chicken, tomato, olives, onion]).
meal_ingredients(melanzane_alla_parmigiana, [eggplant, cheese, tomato, breadcrumbs]).
meal_ingredients(margherita, [pizza_dough, tomato, mozzarella]).
meal_ingredients(diavola, [pizza_dough, tomato, mozzarella, salami]).
meal_ingredients(prosciutto_e_funghi, [pizza_dough, tomato, mozzarella, ham, mushrooms]).
meal_ingredients(fornarina, [pizza_dough, olive_oil]).
meal_ingredients(gluten_free_margherita, [gluten_free_dough, tomato, mozzarella]).
meal_ingredients(tiramisu, [mascarpone, egg, coffee, ladyfingers, cocoa]).
meal_ingredients(panna_cotta, [cream, milk, sugar]).
meal_ingredients(biscotti, [flour, egg, butter, sugar]).

% Ingredient Types
% ingredient_type(Ingredient, Type).
ingredient_type(bread, cereal).
ingredient_type(pizza_dough, cereal).
ingredient_type(gluten_free_dough, cereal).
ingredient_type(tomato, vegetable).
ingredient_type(garlic, vegetable).
ingredient_type(olive_oil, plant_fat).
ingredient_type(basil, vegetable).
ingredient_type(mozzarella, dairy).
ingredient_type(cheese, dairy).
ingredient_type(pancetta, meat).
ingredient_type(salami, meat).
ingredient_type(ham, meat).
ingredient_type(beef, meat).
ingredient_type(chicken, meat).
ingredient_type(mushrooms, vegetable).
ingredient_type(eggplant, vegetable).
ingredient_type(rice, cereal).
ingredient_type(pasta, cereal).
ingredient_type(penne, cereal).
ingredient_type(spaghetti, cereal).
ingredient_type(egg, animal_product).
ingredient_type(butter, dairy).
ingredient_type(cream, dairy).
ingredient_type(milk, dairy).
ingredient_type(sugar, sweetener).
ingredient_type(cocoa, plant_product).
ingredient_type(coffee, plant_product).
ingredient_type(ladyfingers, cereal).
ingredient_type(flour, cereal).
ingredient_type(onion, vegetable).
ingredient_type(olives, vegetable).
ingredient_type(mascarpone, dairy).

% Allergens per Meal
% meal_allergens(Meal, [Allergens]).
meal_allergens(bruschette_al_pomodoro, [gluten]).
meal_allergens(caprese, [milk]).
meal_allergens(spaghetti_alla_carbonara, [gluten, milk, egg]).
meal_allergens(risotto_ai_funghi, [milk]).
meal_allergens(lasagna_alla_bolognese, [gluten, milk, egg]).
meal_allergens(penne_all_arrabbiata, [gluten]).
meal_allergens(bistecca_alla_fiorentina, []).
meal_allergens(pollo_alla_cacciatora, []).
meal_allergens(melanzane_alla_parmigiana, [gluten, milk]).
meal_allergens(margherita, [gluten, milk]).
meal_allergens(diavola, [gluten, milk]).
meal_allergens(prosciutto_e_funghi, [gluten, milk]).
meal_allergens(fornarina, [gluten]).
meal_allergens(gluten_free_margherita, [milk]).
meal_allergens(tiramisu, [gluten, milk, egg]).
meal_allergens(panna_cotta, [milk]).
meal_allergens(biscotti, [gluten, milk, egg]).

% Calories per Meal
% meal_calories(Meal, Calories).
meal_calories(bruschette_al_pomodoro, 180).
meal_calories(caprese, 250).
meal_calories(spaghetti_alla_carbonara, 565).
meal_calories(risotto_ai_funghi, 450).
meal_calories(lasagna_alla_bolognese, 750).
meal_calories(penne_all_arrabbiata, 325).
meal_calories(bistecca_alla_fiorentina, 655).
meal_calories(pollo_alla_cacciatora, 570).
meal_calories(melanzane_alla_parmigiana, 550).
meal_calories(margherita, 600).
meal_calories(diavola, 650).
meal_calories(prosciutto_e_funghi, 700).
meal_calories(fornarina, 250).
meal_calories(gluten_free_margherita, 850).
meal_calories(tiramisu, 450).
meal_calories(panna_cotta, 250).
meal_calories(biscotti, 125).

%Diet Restrictions
% diet_restriction(Diet, DisallowedType).
diet_restriction(vegetarian, meat).
diet_restriction(vegan, meat).
diet_restriction(vegan, dairy).
diet_restriction(vegan, animal_product).

% Inference Rules

% Inclusion rule for carnivores
meal_satisfies_diet(Meal, carnivore) :-
    meal_ingredients(Meal, Ingredients),
    member(Ing, Ingredients),
    ingredient_type(Ing, meat).

% Exclusion rules for other diets
meal_satisfies_diet(Meal, Diet) :-
    Diet \= carnivore,
    meal_ingredients(Meal, Ingredients),
    \+ (member(Ing, Ingredients),
        ingredient_type(Ing, Type),
        diet_restriction(Diet, Type)).

% Check allergen safety
meal_safe_for_allergies(Meal, Allergies) :-
    meal_allergens(Meal, MealAllergens),
    \+ (member(Allergen, Allergies),
        member(Allergen, MealAllergens)).

% Check calorie constraint
meal_within_calories(Meal, MaxCalories) :-
    meal_calories(Meal, Calories),
    Calories =< MaxCalories.

% Recommendation rule
recommend_meal(Course, Diet, Allergies, false, _, Meal) :-
    meal(Meal, Course),
    meal_satisfies_diet(Meal, Diet),
    meal_safe_for_allergies(Meal, Allergies).

recommend_meal(Course, Diet, Allergies, true, MaxCalories, Meal) :-
    meal(Meal, Course),
    meal_satisfies_diet(Meal, Diet),
    meal_safe_for_allergies(Meal, Allergies),
    meal_within_calories(Meal, MaxCalories).

% Example Query
% recommend_meal(main_dish, vegetarian, [milk], true, 500, Meal).
% recommend_meal(appetizer, vegetarian, [gluten], false, _, Meal).
% recommend_meal(main_dish, vegan, [], true, 400, Meal).
% recommend_meal(dessert, omnivore, [egg], false, _, Meal).
% recommend_meal(second_course, carnivore, [], true, 800, Meal).
% recommend_meal(pizza, vegan, [egg], false, _, Meal).
% recommend_meal(dessert, vegetarian, [gluten], true, 300, Meal).
% recommend_meal(appetizer, omnivore, [], false, _, Meal).
% recommend_meal(appetizer, vegan, [gluten, milk], true, 200, Meal).
% recommend_meal(pizza, carnivore, [], true, 700, Meal).
% recommend_meal(main_dish, vegetarian, [], true, 500, Meal).




























