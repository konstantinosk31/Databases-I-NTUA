import pymysql
import csv

# Connect to the database
connection = pymysql.connect(host='localhost',
                             user='root',
                             password='otinanai',
                             database='mydb',
                             cursorclass=pymysql.cursors.DictCursor)

def fill_Professional_Expertise():
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
    # Connect to the database
    connection = pymysql.connect(host='localhost',
                                user='root',
                                password='otinanai',
                                database='mydb',
                                cursorclass=pymysql.cursors.DictCursor)

    try:
        with connection:
            with connection.cursor() as cursor:
                sql = "INSERT INTO Cook (name, surname, phone_number, Date_of_birth, years_of_experience, Professional_Expertise_type) VALUES (%s, %s, %s, %s, %s, %s)"
                with open('singers.csv', 'r') as file:
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

#fill_Professional_Expertise()
fill_Cook()
