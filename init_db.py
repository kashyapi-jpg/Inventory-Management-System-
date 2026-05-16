import sqlite3

connection = sqlite3.connect('inventory.db')

with open('inventory-system/schema.sql') as f:
    connection.executescript(f.read())

connection.commit()
connection.close()

print("Database created successfully.")