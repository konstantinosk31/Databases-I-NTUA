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



fill_Professional_Expertise()
fill_Cook()
fill_National_Cuisine()
fill_Meal_Form()
fill_Food_Category()
fill_Equipment()
fill_Etiquette()
fill_Thematic_Unit()