import sqlite3

def login(username, password):
    conn = sqlite3.connect('my_database.db')
    cursor = conn.cursor()

    query = "SELECT * FROM users WHERE username = ? AND password = ?"
    cursor.execute(query, (username, password))

    result = cursor.fetchone()

    if result:
        return True  # Login successful
    else:
        return False  # Login failed