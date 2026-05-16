from flask import Flask, render_template, request, redirect, url_for, session
import mysql.connector

app = Flask(__name__)
app.secret_key = "inventory_secret_key"

# MySQL connection
db = mysql.connector.connect(
    host="localhost",
    user="Root08",          # change if your MySQL username is different
    password="root@123",  # <-- replace with your MySQL password
    database="InventoryDB"          # name of your database
)
cursor = db.cursor(dictionary=True)

# ------------------------------
# ROUTES
# ------------------------------

@app.route('/')
def home():
    return render_template('index.html')

@app.route('/login', methods=['GET', 'POST'])
def login():
    if request.method == 'POST':
        username = request.form['username']
        password = request.form['password']

        cursor.execute("SELECT * FROM users WHERE username=%s AND password=%s", (username, password))
        user = cursor.fetchone()

        if user:
            session['username'] = user['username']
            return redirect(url_for('dashboard'))
        else:
            return render_template('login.html', error="Invalid username or password")

    return render_template('login.html')

@app.route('/logout')
def logout():
    session.clear()
    return redirect(url_for('home'))

@app.route('/dashboard')
def dashboard():
    if 'username' not in session:
        return redirect(url_for('login'))
    return render_template('dashboard.html')

@app.route('/add_item', methods=['GET', 'POST'])
def add_item():
    if request.method == 'POST':
        name = request.form['name']
        category = request.form['category']
        price = request.form['price']
        stock = request.form['stock']

        cursor.execute("INSERT INTO product (ProductName, Category_id, Price, Stock) VALUES (%s, %s, %s, %s)",
                       (name, category, price, stock))
        db.commit()

        return redirect(url_for('view_items'))

    cursor.execute("SELECT * FROM categories")
    categories = cursor.fetchall()
    return render_template('add_item.html', categories=categories)

@app.route('/view_items')
def view_items():
    cursor.execute("SELECT p.Product_id, p.ProductName, c.CategoryName, p.Price, p.Stock FROM product p JOIN categories c ON p.Category_id = c.Category_id")
    items = cursor.fetchall()
    return render_template('view_items.html', items=items)

@app.route('/transactions')
def transactions():
    cursor.execute("SELECT * FROM sales")
    data = cursor.fetchall()
    return render_template('transactions.html', transactions=data)

if __name__ == '__main__':
    app.run(debug=True)
