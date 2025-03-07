%facts defining meals:  meal(Name, Course, Type, Calories, ContainsGluten, ContainsLactose).
meal(bruschette_al_pomodoro, appetizer, vegetarian, 180, yes, no).
meal(caprese, appetizer, vegetarian, 250, no, yes).
meal(spaghetti_alla_carbonara, main_dish, carnivore, 565, yes, yes).
meal(risotto_ai_funghi, main_dish, vegetarian, 450, no, yes).
meal(lasagna_alla_bolognese, main_dish, carnivore, 750, yes, yes).
meal(penne_all_arrabbiata, main_dish, vegetarian, 325, yes, no).
meal(bistecca_alla_fiorentina, second_course, carnivore, 655, no, no).
meal(pollo_alla_cacciatora, second_course, carnivore, 570, no, no).
meal(melanzane_alla_parmigiana, second_course, vegetarian, 550, yes, yes).
meal(margherita, pizza, vegetarian, 600, yes, yes).
meal(diavola, pizza, carnivore, 650, yes, yes).
meal(prosciutto_e_funghi, pizza, carnivore, 700, yes, yes).
meal(fornarina, pizza, vegetarian, 250, yes, no).
meal(gluten_free_margherita, pizza, vegetarian, 850, no, yes).
meal(tiramisu, dessert, omnivore, 450, yes, yes).
meal(panna_cotta, dessert, omnivore, 250, no, yes).
meal(biscotti, dessert, omnivore, 125, yes, yes).

%function to filter meals on diet (vegetarian, carnivore, omnivore), course (appetizer, main_dish, second_course, pizza, dessert), and allergies (lactose, gluten)
filter_meals(Allergies, Diet, Course, Meal, Calories) :-
    meal(Meal, Course, MealType, Calories, ContainsGluten, ContainsLactose),
    %dietary restrictions
    (Diet == omnivore ; Diet == MealType),
    %allergy restrictions check
    \+ (member(gluten, Allergies), ContainsGluten == yes),
    \+ (member(lactose, Allergies), ContainsLactose == yes).

%filter based on calories
suggest_meal(Allergies, Diet, CalorieConscious, MaxCalories, Course, Meal) :-
    filter_meals(Allergies, Diet, Course, Meal, Calories),
    %check calorie limit if the user is calorie conscious
    (CalorieConscious == no ; Calories =< MaxCalories).

%query examples:
% ?- suggest_meal([gluten], vegetarian, yes, 500, main_dish, Meal).
% ?- suggest_meal([lactose], carnivore, no, 700, second_course, Meal).
% ?- suggest_meal([], omnivore, yes, 400, dessert, Meal).
% ?- suggest_meal([gluten], omnivore, no, 1000, appetizer, Meal).
% ?- suggest_meal([], vegetarian, yes, 300, main_dish, Meal).
% ?- suggest_meal([lactose], vegetarian, no, 600, second_course, Meal).
% ?- suggest_meal([], omnivore, yes, 200, dessert, Meal).
% ?- suggest_meal([gluten,lactose], carnivore, yes, 1500, second_course, Meal).
% ?- suggest_meal([], vegetarian, no, 1000, appetizer, Meal).
% ?- suggest_meal([lactose], omnivore, yes, 350, dessert, Meal).
%find multiple dishes with a querù
%?- findall(Meal, suggest_meal([gluten, lactose], vegetarian, yes, 500, main_dish, Meal), Meals).
