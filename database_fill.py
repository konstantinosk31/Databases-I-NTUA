import pymysql
import csv
import pandas as pd

def convert_data(file_name):
    with open(file_name, 'rb') as file:
        binary_data = file.read()
    return binary_data

def connect():
    # Connect to the database
    connection = pymysql.connect(host='localhost',
                                user='root',
                                password='admin123',
                                database='mydb',
                                cursorclass=pymysql.cursors.DictCursor)
    return connection

def fill_Professional_Expertise():
    connection = connect()
    try:
        with connection:
            with connection.cursor() as cursor:
                sql = "INSERT INTO Professional_Expertise (type) VALUES (%s)"
                cursor.execute(sql, "3.A_cook")
                cursor.execute(sql, "4.B_cook")
                cursor.execute(sql, "5.C_cook")
                cursor.execute(sql, "2.sous_chef")
                cursor.execute(sql, "1.chef")
            connection.commit()
    except Exception as e:
        print("Error:", e)
    finally:
        # The connection is automatically closed when exiting the 'with connection' block
        print("Database connection closed.")

def fill_Cook():
    connection = connect()
    try:
        with connection:
            with connection.cursor() as cursor:
                sql = "INSERT INTO Cook (name, surname, phone_number, Date_of_birth, years_of_experience, Professional_Expertise_type,Cook_Images) VALUES (%s, %s, %s, %s, %s, %s, %s)"
                with open('cook.csv', 'r') as file:
                    csv_data = csv.reader(file)
                    next(csv_data)  # Skip the header row
                    for row in csv_data:
                        cursor.execute(sql, (row[0], row[1], row[2], row[3], row[4], row[5], convert_data(row[6])))
                
            connection.commit()
    except Exception as e:
        print("Error:", e)
    finally:
        # The connection is automatically closed when exiting the 'with connection' block
        print("Database connection closed.")

def fill_National_Cuisine():
    connection = connect()
    try:
        with connection:
            with connection.cursor() as cursor:
                sql = "INSERT INTO National_Cuisine (name) VALUES (%s)"
                with open('national_cuisine.csv', 'r') as file:
                    csv_data = csv.reader(file)
                    next(csv_data)  # Skip the header row
                    for row in csv_data:
                        cursor.execute(sql, (row[0]))
                
            connection.commit()
    except Exception as e:
        print("Error:", e)
    finally:
        # The connection is automatically closed when exiting the 'with connection' block
        print("Database connection closed.")    

def fill_Meal_Form():
    connection = connect()
    try:
        with connection:
            with connection.cursor() as cursor:
                sql = "INSERT INTO Meal (Meal_Form) VALUES (%s)"
                cursor.execute(sql, "breakfast")
                cursor.execute(sql, "morning_snack")
                cursor.execute(sql, "lunch")
                cursor.execute(sql, "afternoon_snack")
                cursor.execute(sql, "dinner")
            connection.commit()
    except Exception as e:
        print("Error:", e)
    finally:
        # The connection is automatically closed when exiting the 'with connection' block
        print("Database connection closed.")

def fill_Food_Category():
    connection = connect()
    try:
        with connection:
            with connection.cursor() as cursor:
                sql = "INSERT INTO Food_Category (name, description,Food_Category_Images) VALUES (%s, %s,%s)"
                with open('food_category.csv', 'r') as file:
                    csv_data = csv.reader(file)
                    next(csv_data)  # Skip the header row
                    for row in csv_data:
                        cursor.execute(sql, (row[0], row[1], convert_data(row[2])))
                
            connection.commit()
    except Exception as e:
        print("Error:", e)
    finally:
        # The connection is automatically closed when exiting the 'with connection' block
        print("Database connection closed.")    


def fill_Equipment():
    connection = connect()
    try:
        with connection:
            with connection.cursor() as cursor:
                sql = "INSERT INTO Equipment (name, manual,Equipment_Images) VALUES (%s, %s,%s)"
                with open('equipment.csv', 'r') as file:
                    csv_data = csv.reader(file)
                    next(csv_data)  # Skip the header row
                    for row in csv_data:
                        cursor.execute(sql, (row[0], row[1], convert_data(row[2])))
                
            connection.commit()
    except Exception as e:
        print("Error:", e)
    finally:
        # The connection is automatically closed when exiting the 'with connection' block
        print("Database connection closed.")    


def fill_Etiquette():
    connection = connect()
    try:
        with connection:
            with connection.cursor() as cursor:
                sql = "INSERT INTO Etiquette (Meal_Type) VALUES (%s)"
                with open('etiquette.csv', 'r') as file:
                    csv_data = csv.reader(file)
                    next(csv_data)  # Skip the header row
                    for row in csv_data:
                        cursor.execute(sql, (row[0]))
                
            connection.commit()
    except Exception as e:
        print("Error:", e)
    finally:
        # The connection is automatically closed when exiting the 'with connection' block
        print("Database connection closed.")

def fill_Thematic_Unit():
    connection = connect()
    try:
        with connection:
            with connection.cursor() as cursor:
                sql = "INSERT INTO Thematic_Unit (name, description,Thematic_Unit_Images) VALUES (%s, %s, %s)"
                with open('thematic_unit.csv', 'r') as file:
                    csv_data = csv.reader(file)
                    next(csv_data)  # Skip the header row
                    for row in csv_data:
                        cursor.execute(sql, (row[0], row[1], convert_data(row[2])))
                
            connection.commit()
    except Exception as e:
        print("Error:", e)
    finally:
        # The connection is automatically closed when exiting the 'with connection' block
        print("Database connection closed.")

def fill_ingredients():
    df = pd.read_csv('ingredients.csv', encoding='utf-8')
    df['name2'] = df['name'].str.lower()
    df.drop_duplicates(subset='name2', inplace=True)
    df.drop(columns=['name2'], inplace=True)
    pd.DataFrame(df).to_csv('ingredients.csv', index=False)
    row = []
    connection = connect()
    try:
        with connection:
            with connection.cursor() as cursor:
                sql = "INSERT INTO Ingredients (name, caloriesper100grams, Food_Category_name,Ingredients_Images) VALUES (%s, %s, %s, %s)"
                with open('ingredients.csv', 'r', encoding='utf-8') as file:
                    csv_data = csv.reader(file)
                    next(csv_data)  # Skip the header row
                    for row in csv_data:
                        cursor.execute(sql, (row[0], row[1], row[2], convert_data(row[3])))
                
            connection.commit()
    except Exception as e:
        print(row)
        print("Error:", e)
    finally:
        # The connection is automatically closed when exiting the 'with connection' block
        print("Database connection closed.")

def fill_Recipies():
    """df = pd.read_csv('recipies.csv', encoding='utf-8')
    df = df[['National_Cuisine_name']]
    df.drop_duplicates(inplace=True)
    df.sort_values(by='National_Cuisine_name', inplace=True)
    pd.DataFrame(df).to_csv('recipies_national_cuisines.csv', index=False)

    df = pd.read_csv('national_cuisine.csv')
    df = df[['name']]
    df.sort_values(by='name', inplace=True)
    pd.DataFrame(df).to_csv('national_cuisine.csv', index=False)"""
    connection = connect()
    try:
        with connection:
            with connection.cursor() as cursor:
                sql = "INSERT INTO Recipies (difficulty,name,description,preparation_time,cooking_time,fat,protein,carbs,cooking_or_pastry,basic_ingredient_name,National_Cuisine_name,Recipies_Image) VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)"
                with open('recipies.csv', 'r', encoding='utf-8') as file:
                    csv_data = csv.reader(file)
                    next(csv_data)  # Skip the header row
                    for row in csv_data:
                        cursor.execute(sql, (row[0], row[1], row[2], row[3], row[4], row[5], row[6], row[7], row[8], row[9], row[10], convert_data(row[11])))
                
            connection.commit()
    except Exception as e:
        print("Error:", e)
    finally:
        # The connection is automatically closed when exiting the 'with connection' block
        print("Database connection closed.")

def fill_Steps():
    """df = pd.read_csv('steps.csv', encoding='utf-8')
    df.insert(loc=1, column='step_number',value=0)
    # Initialize variables to keep track of step numbers and the current recipe
    step_number = 1
    current_recipe = df['Recipies_name'].iloc[0]

    # Iterate through each row in the DataFrame
    for index, row in df.iterrows():
        # Check if the recipe has changed
        if row['Recipies_name'] != current_recipe:
            # Reset step number and update the current recipe
            step_number = 1
            current_recipe = row['Recipies_name']
        
        df.at[index, 'step_number'] = step_number
        
        # Increment step number for the next step
        step_number += 1

    # Write the modified DataFrame back to a CSV file
    df.to_csv('steps.csv', index=False)"""

    """df = pd.read_csv('steps.csv', encoding='utf-8')
    df = df[['Steps_Step_Description']]
    df.drop_duplicates(keep="first", inplace=True)
    pd.DataFrame(df).to_csv('steps_descriptions.csv', index=False)"""
    connection = connect()
    try:
        with connection:
            with connection.cursor() as cursor:
                sql = "INSERT INTO Steps (Step_Description) VALUES (%s)"
                with open('steps_descriptions.csv', 'r', encoding='utf-8') as file:
                    csv_data = csv.reader(file)
                    next(csv_data)  # Skip the header row
                    for row in csv_data:
                        cursor.execute(sql, (row[0]))
                
            connection.commit()
    except Exception as e:
        print("Error:", e)
    finally:
        # The connection is automatically closed when exiting the 'with connection' block
        print("Database connection closed.")

def fill_Recipies_has_Steps():
    connection = connect()
    row = []
    try:
        with connection:
            with connection.cursor() as cursor:
                sql = "INSERT INTO Recipies_has_Steps (Recipies_name, step_number, Steps_Step_Description) VALUES (%s, %s, %s)"
                with open('steps.csv', 'r', encoding='utf-8') as file:
                    csv_data = csv.reader(file)
                    next(csv_data)  # Skip the header row
                    for row in csv_data:
                        cursor.execute(sql, (row[0], row[1], row[2]))
                
            connection.commit()
    except Exception as e:
        print(row)
        print("Error:", e)
    finally:
        # The connection is automatically closed when exiting the 'with connection' block
        print("Database connection closed.")

def fill_Recipies_Etiquettes():
    connection = connect()
    row = []
    try:
        with connection:
            with connection.cursor() as cursor:
                sql = "INSERT INTO Recipies_has_Etiquette (Recipies_name, Etiquette_Meal_Type) VALUES (%s, %s)"
                with open('recipies_has_etiquette.csv', 'r', encoding='utf-8') as file:
                    csv_data = csv.reader(file)
                    next(csv_data)  # Skip the header row
                    for row in csv_data:
                        cursor.execute(sql, (row[0], row[1]))
                
            connection.commit()
    except Exception as e:
        print("Error:", e)
    finally:
        # The connection is automatically closed when exiting the 'with connection' block
        print("Database connection closed.")

def fill_Recipies_has_Equipment():
    """df_existing = pd.read_csv('equipment.csv', encoding='utf-8')
    df_existing = df_existing[['name']]
    df_existing.drop_duplicates(keep="first", inplace=True)
    df_existing.sort_values(by='name', inplace=True)
    pd.DataFrame(df_existing).to_csv('equipment_names.csv', index=False)

    df_from_recipes = pd.read_csv('recipies_has_equipment.csv', encoding='utf-8')
    df_from_recipes = df_from_recipes[['Equipment_name']]
    df_from_recipes.drop_duplicates(keep="first", inplace=True)
    df_from_recipes.sort_values(by='Equipment_name', inplace=True)
    pd.DataFrame(df_from_recipes).to_csv('equipment_names_from_recipes.csv', index=False)

    df = pd.read_csv('recipies_has_equipment.csv', encoding='utf-8')
    df.drop_duplicates(keep="first", inplace=True)
    pd.DataFrame(df).to_csv('recipies_has_equipment.csv', index=False)"""
    connection = connect()
    row = []
    try:
        with connection:
            with connection.cursor() as cursor:
                sql = "INSERT INTO Recipies_has_Equipment (Recipies_name, Equipment_name) VALUES (%s, %s)"
                with open('recipies_has_equipment.csv', 'r', encoding='utf-8') as file:
                    csv_data = csv.reader(file)
                    next(csv_data)  # Skip the header row
                    for row in csv_data:
                        cursor.execute(sql, (row[0], row[1]))
                
            connection.commit()
    except Exception as e:
        print(row)
        print("Error:", e)
    finally:
        # The connection is automatically closed when exiting the 'with connection' block
        print("Database connection closed.")


def fill_Recipies_Meal():
    connection = connect()
    row = []
    try:
        with connection:
            with connection.cursor() as cursor:
                sql = "INSERT INTO Meal_has_Recipies (Meal_Meal_Form, Recipies_name) VALUES (%s, %s)"
                with open('meal_has_recipies.csv', 'r', encoding='utf-8') as file:
                    csv_data = csv.reader(file)
                    next(csv_data)  # Skip the header row
                    for row in csv_data:
                        cursor.execute(sql, (row[1], row[0]))
                
            connection.commit()
    except Exception as e:
        print(row)
        print("Error:", e)
    finally:
        # The connection is automatically closed when exiting the 'with connection' block
        print("Database connection closed.")

def fill_Tips():
    connection = connect()
    row = []
    try:
        with connection:
            with connection.cursor() as cursor:
                sql = "INSERT INTO Tips (description, Recipies_name) VALUES (%s, %s)"
                with open('tips.csv', 'r', encoding='utf-8') as file:
                    csv_data = csv.reader(file)
                    next(csv_data)  # Skip the header row
                    for row in csv_data:
                        cursor.execute(sql, (row[1], row[0]))
                
            connection.commit()
    except Exception as e:
        print(row)
        print("Error:", e)
    finally:
        # The connection is automatically closed when exiting the 'with connection' block
        print("Database connection closed.")



def fill_Cook_has_Specialisation():
    connection = connect()
    row = []
    try:
        with connection:
            with connection.cursor() as cursor:
                sql = "INSERT INTO Has_specialisation (National_Cuisine_name, Cook_Name, Cook_surname) VALUES (%s, %s,%s)"
                with open('has_specialisation.csv', 'r', encoding='utf-8') as file:
                    csv_data = csv.reader(file)
                    next(csv_data)  # Skip the header row
                    for row in csv_data:
                        cursor.execute(sql, (row[2], row[0], row[1]))
                
            connection.commit()
    except Exception as e:
        print(row)
        print("Error:", e)
    finally:
        # The connection is automatically closed when exiting the 'with connection' block
        print("Database connection closed.")

def fill_Cook_has_Recipies():
    
    df_specialisations = pd.read_csv('has_specialisation.csv', encoding='utf-8')
    df_recipies = pd.read_csv('recipies.csv', encoding='utf-8')
    df_recipies = df_recipies[['name', 'National_Cuisine_Name']]
    merge_data = pd.merge(df_specialisations, df_recipies, on='National_Cuisine_Name', how='inner')

    result = merge_data[['Cook_name', 'Cook_surname', 'name']]
    result.columns = ['Cook_Name', 'Cook_Surname', 'Recipes_name']
    result.to_csv('cook_has_recipies.csv', index=False)
    
    connection = connect()
    row = []
    try:
        with connection:
            with connection.cursor() as cursor:
                sql = "INSERT INTO Cook_has_Recipies (Cook_Name, Cook_Surname, Recipies_name) VALUES (%s, %s,%s)"
                with open('cook_has_recipies.csv', 'r', encoding='utf-8') as file:
                    csv_data = csv.reader(file)
                    next(csv_data)  # Skip the header row
                    for row in csv_data:
                        cursor.execute(sql, (row[0], row[1], row[2]))
                
            connection.commit()
    except Exception as e:
        print(row)
        print("Error:", e)
    finally:
        # The connection is automatically closed when exiting the 'with connection' block
        print("Database connection closed.")


def fill_Recipies_Has_Ingredients():
    """
    df_basic_ingredients = pd.read_csv('ingredients.csv', encoding='utf-8')
    df_basic_ingredients = df_basic_ingredients[['name']]
    df_basic_ingredients.drop_duplicates(keep="first", inplace=True)
    
    df_recipe_ingredients = pd.read_csv('recipies_has_ingredients.csv', encoding='utf-8')
    df_recipe_ingredients = df_recipe_ingredients[['ingredient_name']]
    df_recipe_ingredients.drop_duplicates(keep="first", inplace=True)
    cond = df_recipe_ingredients.isin(df_basic_ingredients.to_dict(orient='list')).all(axis=1)
    df_recipe_ingredients = df_recipe_ingredients[~cond]
    df_recipe_ingredients.sort_values(by='ingredient_name', inplace=True)
    pd.DataFrame(df_recipe_ingredients).to_csv('extra_ingredients_names.csv', index=False)
    """

    connection = connect()
    row = []
    try:
        with connection:
            with connection.cursor() as cursor:
                sql = "INSERT INTO Recipies_has_Ingredients (Recipies_name, Ingredients_Name, quantity) VALUES (%s, %s,%s)"
                with open('recipies_has_ingredients.csv', 'r', encoding='utf-8') as file:
                    csv_data = csv.reader(file)
                    next(csv_data)  # Skip the header row
                    for row in csv_data:
                        cursor.execute(sql, (row[0], row[1], row[2]))
                
            connection.commit()
    except Exception as e:
        print(row)
        print("Error:", e)
    finally:
        # The connection is automatically closed when exiting the 'with connection' block
        print("Database connection closed.")


def fill_Recipies_has_Thematic_Unit():
    connection = connect()
    row = []
    try:
        with connection:
            with connection.cursor() as cursor:
                sql = "INSERT INTO Recipies_has_Thematic_Unit (Recipies_name, Thematic_Unit_name) VALUES (%s, %s)"
                with open('recipies_has_thematic_unit.csv', 'r', encoding='utf-8') as file:
                    csv_data = csv.reader(file)
                    next(csv_data)  # Skip the header row
                    for row in csv_data:
                        cursor.execute(sql, (row[0], row[1]))
                
            connection.commit()
    except Exception as e:
        print(row)
        print("Error:", e)
    finally:
        # The connection is automatically closed when exiting the 'with connection' block
        print("Database connection closed.")

def fill_Episode():
    connection = connect()
    try:
        with connection:
            with connection.cursor() as cursor:
                sql = "INSERT INTO Episode (episode_number) VALUES (%s)"
                with open('episode.csv', 'r') as file:
                    csv_data = csv.reader(file)
                    next(csv_data)  # Skip the header row
                    for row in csv_data:
                        cursor.execute(sql, row[0])
                
            connection.commit()
    except Exception as e:
        print("Error:", e)
    finally:
        # The connection is automatically closed when exiting the 'with connection' block
        print("Database connection closed.")

fill_Professional_Expertise()
fill_Cook()
fill_National_Cuisine()
fill_Meal_Form()
fill_Food_Category()
fill_Equipment()
fill_Etiquette()
fill_Thematic_Unit()
fill_ingredients()
fill_Recipies()
fill_Steps()
fill_Recipies_has_Steps()
fill_Recipies_Etiquettes()
fill_Recipies_has_Equipment()
fill_Recipies_Meal()
fill_Tips()
fill_Cook_has_Specialisation()
fill_Recipies_Has_Ingredients()
fill_Recipies_has_Thematic_Unit()
fill_Episode()
fill_Cook_has_Recipies()