from flask import Flask, request, render_template, url_for, redirect
import mysql.connector

app = Flask(__name__)

@app.route("/")
def home():
    mydb = mysql.connector.connect(
        host="localhost",
        user="root",
        port="3308",
        passwd="",
        database="inventory",
        use_unicode=True,
        charset='ascii'
    )
    mycursor = mydb.cursor()
    sql = "SELECT * FROM products ORDER BY p_id ASC"
    mycursor.execute(sql)
    myresult = mycursor.fetchall()
    column_names = [i[0] for i in mycursor.description]
    mycursor.close()
    mydb.close()
    return render_template('menu.html', column_names=column_names, products=myresult)

@app.route("/addproduct")
def home1():
    return render_template("addproduct.html")

@app.route('/addproduct', methods=['POST'])
def product1():
    name = request.form['name']
    category = request.form['category']
    quantity = request.form['quantity']
    price = request.form['price']
    description = request.form['description']

    mydb = mysql.connector.connect(
        host="localhost",
        user="root",
        port="3308",
        passwd="",
        database="inventory",
        use_unicode=True,
        charset='ascii'
    )
    mycursor = mydb.cursor()

    # Assuming the table has an AUTO_INCREMENT primary key column named 'p_id'
    sql = "INSERT INTO products (name, category, quantity, price, description) VALUES (%s, %s, %s, %s, %s)"
    values = (name, category, quantity, price, description)
    mycursor.execute(sql, values)
    mydb.commit()
    mycursor.close()
    mydb.close()

    return redirect(url_for('home'))


@app.route('/updateproduct/<int:p_id>', methods=['GET', 'POST'])
def product2(p_id):
    mydb = mysql.connector.connect(
        host="localhost",
        user="root",
        port="3308",
        passwd="",
        database="inventory",  # Make sure this is the correct database name
        use_unicode=True,
        charset='ascii'
    )
    mycursor = mydb.cursor()

    if request.method == 'POST':
        # Retrieve form data
        name = request.form['name']
        category = request.form['category']
        quantity = request.form['quantity']
        price = request.form['price']
        description = request.form['description']

        # Update the product in the database
        sql = "UPDATE products SET name=%s, category=%s, quantity=%s, price=%s, description=%s WHERE p_id=%s"
        val = (name, category, quantity, price, description, p_id)
        mycursor.execute(sql, val)
        mydb.commit()
        mycursor.close()
        mydb.close()

        return redirect(url_for('home'))  # Redirect to the home page after updating

    else:
        # Fetch product details for the given ID
        sql = "SELECT * FROM products WHERE p_id = %s"
        mycursor.execute(sql, (p_id,))
        product = mycursor.fetchone()
        mycursor.close()
        mydb.close()

        # Check if the product exists
        if product is None:
            return "Product not found", 404

        # Render the template with product details
        return render_template('updateproduct.html', product=product)


@app.route('/deleteproduct/<int:p_id>', methods=['GET', 'POST'])
def product3(p_id):
    mydb = mysql.connector.connect(
        host="localhost",
        user="root",
        port="3308",
        passwd="",
        database="inventory"
    )
    mycursor = mydb.cursor()

    if request.method == 'POST':
        sql = "DELETE FROM products WHERE p_id = %s"
        val = (p_id,)
        mycursor.execute(sql, val)
        mydb.commit()
        mycursor.close()
        mydb.close()

        return redirect(url_for('home'))

    else:
        sql = "SELECT * FROM products WHERE p_id = %s"
        mycursor.execute(sql, (p_id,))
        product = mycursor.fetchone()
        mycursor.close()
        mydb.close()

        return render_template('deleteproduct.html', product=product)

@app.route('/suppliers')
def product4():
    mydb = mysql.connector.connect(
        host="localhost",
        user="root",
        port="3308",
        passwd="",
        database="inventory"
    )
    mycursor = mydb.cursor()
    mycursor.execute("SELECT * FROM suppliers")
    suppliers = mycursor.fetchall()
    mycursor.close()
    mydb.close()
    return render_template('suppliers.html', suppliers=suppliers)

@app.route('/addsupplier', methods=['GET', 'POST'])
def product5():
    if request.method == 'POST':
        name = request.form['name']
        phone = request.form['phone']
        email = request.form['email']

        mydb = mysql.connector.connect(
            host="localhost",
            user="root",
            port="3308",
            passwd="",
            database="inventory"
        )
        mycursor = mydb.cursor()
        sql = "INSERT INTO suppliers (name, phone, email) VALUES (%s, %s, %s)"
        val = (name, phone, email)
        mycursor.execute(sql, val)
        mydb.commit()
        mycursor.close()
        mydb.close()
        return redirect(url_for('product4'))  # Make sure 'product4' is the correct route to redirect to
    return render_template('addsupplier.html')

@app.route('/search', methods=['GET', 'POST'])
def product6():
    if request.method == 'POST':
        search_term = request.form['search']
        mydb = mysql.connector.connect(
            host="localhost",
            user="root",
            port="3308",
            passwd="",
            database="inventory"
        )
        mycursor = mydb.cursor()
        sql = "SELECT * FROM products WHERE name LIKE %s OR category LIKE %s"
        val = ("%" + search_term + "%", "%" + search_term + "%")
        mycursor.execute(sql, val)
        products = mycursor.fetchall()
        mycursor.close()
        mydb.close()
        return render_template('search.html', products=products)
    return render_template('search.html')

@app.route('/lowstock')
def product7():
    mydb = mysql.connector.connect(
        host="localhost",
        user="root",
        port="3308",
        passwd="",
        database="inventory"
    )
    mycursor = mydb.cursor()
    sql = "SELECT * FROM products WHERE quantity < 10"  # Adjust threshold as needed
    mycursor.execute(sql)
    low_stock_products = mycursor.fetchall()
    mycursor.close()
    mydb.close()
    return render_template('lowstock.html', products=low_stock_products)


@app.route("/")
def salvador():
    return "Hello, Friends"


if __name__ == "__main__":
    app.run(debug=True)