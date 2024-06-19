import sqlite3

def login(username, password):
    conn = sqlite3.connect('user.db')
    cursor = conn.cursor()

    query = f"SELECT * FROM users WHERE username = '{username}' AND password = '{password}'"
    cursor.execute(query)

    result = cursor.fetchone()

    if result:
        return True  # Login successful
    else:
        return False  # Login failed
