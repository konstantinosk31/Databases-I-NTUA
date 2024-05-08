import pymysql
import csv
import pandas as pd

def connect():
    # Connect to the database
    connection = pymysql.connect(host='localhost',
                                user='root',
                                password='otinanai',
                                database='mydb',
                                cursorclass=pymysql.cursors.DictCursor)
    return connection

def fill_Professional_Expertise():
    connection = connect()
    try:
        with connection:
            with connection.cursor() as cursor:
                sql = "INSERT INTO Professional_Expertise (type) VALUES (%s)"
                cursor.execute(sql, "A_cook")
                cursor.execute(sql, "B_cook")
                cursor.execute(sql, "C_cook")
                cursor.execute(sql, "sous_chef")
                cursor.execute(sql, "chef")
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
                sql = "INSERT INTO Cook (name, surname, phone_number, Date_of_birth, years_of_experience, Professional_Expertise_type) VALUES (%s, %s, %s, %s, %s, %s)"
                with open('cook.csv', 'r') as file:
                    csv_data = csv.reader(file)
                    next(csv_data)  # Skip the header row
                    for row in csv_data:
                        cursor.execute(sql, (row[0], row[1], row[2], row[3], row[4], row[5]))
                
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
                sql = "INSERT INTO Food_Category (name, description) VALUES (%s, %s)"
                with open('food_category.csv', 'r') as file:
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


def fill_Equipment():
    connection = connect()
    try:
        with connection:
            with connection.cursor() as cursor:
                sql = "INSERT INTO Equipment (name, manual) VALUES (%s, %s)"
                with open('equipment.csv', 'r') as file:
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
                sql = "INSERT INTO Thematic_Unit (name, description) VALUES (%s, %s)"
                with open('thematic_unit.csv', 'r') as file:
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

def fill_basic_ingredients():
    connection = connect()
    try:
        with connection:
            with connection.cursor() as cursor:
                sql = "INSERT INTO Ingredients (name, caloriesper100grams, Food_Category_name) VALUES (%s, %s, %s)"
                with open('ingredients.csv', 'r') as file:
                    csv_data = csv.reader(file)
                    next(csv_data)  # Skip the header row
                    for row in csv_data:
                        cursor.execute(sql, (row[0], row[1], row[2]))
                
            connection.commit()
    except Exception as e:
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
                sql = "INSERT INTO Recipies (difficulty,name,description,preparation_time,cooking_time,fat,protein,carbs,cooking_or_pastry,basic_ingredient_name,National_Cuisine_name) VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)"
                with open('recipies.csv', 'r', encoding='utf-8') as file:
                    csv_data = csv.reader(file)
                    next(csv_data)  # Skip the header row
                    for row in csv_data:
                        cursor.execute(sql, (row[0], row[1], row[2], row[3], row[4], row[5], row[6], row[7], row[8], row[9], row[10]))
                
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
fill_basic_ingredients()
fill_Recipies()