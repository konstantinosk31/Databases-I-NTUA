import pymysql
import csv
import pandas as pd

# Function to convert a file to binary data, used to store images in the database
def convert_data(file_name):
    with open(file_name, 'rb') as file:
        binary_data = file.read()
    return binary_data

# Function to connect to the database
def connect():
    # Load the credentials from CSV
    df = pd.read_csv('database_credentials.csv', header=None)
    credentials = df[0].values  # Extract values into an array
    
    # Use the credentials to connect to the database
    connection = pymysql.connect(
        host=credentials[0],      
        user=credentials[1],      
        password=credentials[2],  
        database=credentials[3],  
        cursorclass=pymysql.cursors.DictCursor
    )
    return connection

# Function to fill the Professional_Expertise table
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
        print("Database connection closed.")

# Function to fill the Cook table
def fill_Cook():
    connection = connect()
    try:
        with connection:
            with connection.cursor() as cursor:
                sql = "INSERT INTO Cook (name, surname, phone_number, Date_of_birth, years_of_experience, Professional_Expertise_type,Cook_Images) VALUES (%s, %s, %s, %s, %s, %s, %s)"
                with open('Data\cook.csv', 'r') as file:
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

# Function to fill the National_Cuisine table
def fill_National_Cuisine():
    connection = connect()
    try:
        with connection:
            with connection.cursor() as cursor:
                sql = "INSERT INTO National_Cuisine (name) VALUES (%s)"
                with open('Data/national_cuisine.csv', 'r') as file:
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

# Function to fill the Meal_Form table
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

# Function to fill the Food_Category table
def fill_Food_Category():
    connection = connect()
    try:
        with connection:
            with connection.cursor() as cursor:
                sql = "INSERT INTO Food_Category (name, description,Food_Category_Images) VALUES (%s, %s,%s)"
                with open('Data/food_category.csv', 'r') as file:
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

# Function to fill the Equipment table
def fill_Equipment():
    connection = connect()
    try:
        with connection:
            with connection.cursor() as cursor:
                sql = "INSERT INTO Equipment (name, manual,Equipment_Images) VALUES (%s, %s,%s)"
                with open('Data\equipment.csv', 'r') as file:
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

# Function to fill the Etiquette table
def fill_Etiquette():
    connection = connect()
    try:
        with connection:
            with connection.cursor() as cursor:
                sql = "INSERT INTO Etiquette (Meal_Type) VALUES (%s)"
                with open('Data\etiquette.csv', 'r') as file:
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

# Function to fill the Thematic_Unit table
def fill_Thematic_Unit():
    connection = connect()
    try:
        with connection:
            with connection.cursor() as cursor:
                sql = "INSERT INTO Thematic_Unit (name, description,Thematic_Unit_Images) VALUES (%s, %s, %s)"
                with open('Data/thematic_unit.csv', 'r') as file:
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

# Function to fill the Ingredients table
def fill_ingredients():
    df = pd.read_csv('Data\ingredients.csv', encoding='utf-8')
    df['name2'] = df['name'].str.lower()
    df.drop_duplicates(subset='name2', inplace=True)
    df.drop(columns=['name2'], inplace=True)
    pd.DataFrame(df).to_csv('Data\ingredients.csv', index=False)
    row = []
    connection = connect()
    try:
        with connection:
            with connection.cursor() as cursor:
                sql = "INSERT INTO Ingredients (name, caloriesper100grams, Food_Category_name,Ingredients_Images) VALUES (%s, %s, %s, %s)"
                with open('Data\ingredients.csv', 'r', encoding='utf-8') as file:
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

# Function to fill the Recipies table
def fill_Recipies():
    connection = connect()
    try:
        with connection:
            with connection.cursor() as cursor:
                sql = "INSERT INTO Recipies (difficulty,name,description,preparation_time,cooking_time,fat,protein,carbs,cooking_or_pastry,basic_ingredient_name,National_Cuisine_name,Recipies_Image) VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)"
                with open('Data/recipies.csv', 'r', encoding='utf-8') as file:
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

# Function to fill the Steps table
def fill_Steps():
    connection = connect()
    try:
        with connection:
            with connection.cursor() as cursor:
                sql = "INSERT INTO Steps (Step_Description) VALUES (%s)"
                with open('Data\steps_descriptions.csv', 'r', encoding='utf-8') as file:
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

# Function to fill the Recipies_has_Steps table
def fill_Recipies_has_Steps():
    connection = connect()
    row = []
    try:
        with connection:
            with connection.cursor() as cursor:
                sql = "INSERT INTO Recipies_has_Steps (Recipies_name, step_number, Steps_Step_Description) VALUES (%s, %s, %s)"
                with open('Data\steps.csv', 'r', encoding='utf-8') as file:
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
                with open('Data/recipies_has_etiquette.csv', 'r', encoding='utf-8') as file:
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

# Function to fill the Recipies_has_Equipment table
def fill_Recipies_has_Equipment():
    connection = connect()
    row = []
    try:
        with connection:
            with connection.cursor() as cursor:
                sql = "INSERT INTO Recipies_has_Equipment (Recipies_name, Equipment_name) VALUES (%s, %s)"
                with open('Data/recipies_has_equipment.csv', 'r', encoding='utf-8') as file:
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

# Function to fill the Recipies_Meal table
def fill_Recipies_Meal():
    connection = connect()
    row = []
    try:
        with connection:
            with connection.cursor() as cursor:
                sql = "INSERT INTO Meal_has_Recipies (Meal_Meal_Form, Recipies_name) VALUES (%s, %s)"
                with open('Data\meal_has_recipies.csv', 'r', encoding='utf-8') as file:
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

# Function to fill the Tips table
def fill_Tips():
    connection = connect()
    row = []
    try:
        with connection:
            with connection.cursor() as cursor:
                sql = "INSERT INTO Tips (description, Recipies_name) VALUES (%s, %s)"
                with open('Data/tips.csv', 'r', encoding='utf-8') as file:
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

# Function to fill the Cook_has_Specialisation table
def fill_Cook_has_Specialisation():
    connection = connect()
    row = []
    try:
        with connection:
            with connection.cursor() as cursor:
                sql = "INSERT INTO Has_specialisation (National_Cuisine_name, Cook_Name, Cook_surname) VALUES (%s, %s,%s)"
                with open('Data\has_specialisation.csv', 'r', encoding='utf-8') as file:
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

# Function to fill the Cook_has_Recipies table
def fill_Cook_has_Recipies():
    
    df_specialisations = pd.read_csv('Data\has_specialisation.csv', encoding='utf-8')
    df_recipies = pd.read_csv('Data/recipies.csv', encoding='utf-8')
    df_recipies = df_recipies[['name', 'National_Cuisine_Name']]
    merge_data = pd.merge(df_specialisations, df_recipies, on='National_Cuisine_Name', how='inner')

    result = merge_data[['Cook_name', 'Cook_surname', 'name']]
    result.columns = ['Cook_Name', 'Cook_Surname', 'Recipes_name']
    result.to_csv('Data\cook_has_recipies.csv', index=False)
    
    connection = connect()
    row = []
    try:
        with connection:
            with connection.cursor() as cursor:
                sql = "INSERT INTO Cook_has_Recipies (Cook_Name, Cook_Surname, Recipies_name) VALUES (%s, %s,%s)"
                with open('Data\cook_has_recipies.csv', 'r', encoding='utf-8') as file:
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

# Function to fill the Recipies_has_Ingredients table
def fill_Recipies_Has_Ingredients():
    connection = connect()
    row = []
    try:
        with connection:
            with connection.cursor() as cursor:
                sql = "INSERT INTO Recipies_has_Ingredients (Recipies_name, Ingredients_Name, quantity) VALUES (%s, %s,%s)"
                with open('Data/recipies_has_ingredients.csv', 'r', encoding='utf-8') as file:
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

# Function to fill the Recipies_has_Thematic_Unit table
def fill_Recipies_has_Thematic_Unit():
    connection = connect()
    row = []
    try:
        with connection:
            with connection.cursor() as cursor:
                sql = "INSERT INTO Recipies_has_Thematic_Unit (Recipies_name, Thematic_Unit_name) VALUES (%s, %s)"
                with open('Data/recipies_has_thematic_unit.csv', 'r', encoding='utf-8') as file:
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

# Function to fill the Episode table
def fill_Episode():
    connection = connect()
    try:
        with connection:
            with connection.cursor() as cursor:
                sql = "INSERT INTO Episode (episode_number) VALUES (%s)"
                with open('Data\episode.csv', 'r') as file:
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

# Call the functions to fill the tables
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