from flask import Flask, render_template, json, redirect, request
from flask_mysqldb import MySQL
import os


app = Flask(__name__)

# database connection
app.config["MYSQL_HOST"] = "localhost"
app.config["MYSQL_USER"] = "test"
app.config["MYSQL_PASSWORD"] = "test"
app.config["MYSQL_DB"] = "local"
app.config["MYSQL_CURSORCLASS"] = "DictCursor"


mysql = MySQL(app)

@app.route('/index')
def index():
    return render_template("index.html")

@app.route('/bundles')
def get_bundles():
    return render_template("bundles.html")

@app.route('/bundleitems')
def get_bundleitems():
    return render_template("bundleitems.html")

@app.route('/characters')
def get_characters():
    return render_template("characters.html")

# Character Item CRUD Functions
@app.route('/characteritems', methods=["POST", "GET"])
def get_characteritems():
    """ This function implements the Retrieve funciton of CRUD for Character Items"""
    if request.method == "POST":
        if request.form.get("character"):
            charID = request.form["character"]
            itemID = request.form["item"]
            
            query1 = f"INSERT INTO CharacterItems (character_id, item_id) \
            VALUES ({charID}, {itemID});"

            cur = mysql.connection.cursor()
            cur.execute(query1)
            mysql.connection.commit()

        return redirect(request.url)
    if request.method == "GET":
        query2 = "SELECT character_items_id AS ID, \
        CharacterItems.character_id AS CharacterID, \
        NonPlayableCharacters.name AS CharacterName, \
        CharacterItems.item_id AS ItemID, \
        Items.name AS itemName \
        FROM CharacterItems \
        INNER JOIN NonPlayableCharacters ON CharacterItems.character_id = NonPlayableCharacters.character_id \
        INNER JOIN Items ON CharacterItems.item_id = Items.item_id \
        ORDER BY CharacterName ASC;"

        query3 = "SELECT DISTINCT character_id, \
        name \
        FROM NonPlayableCharacters;"

        query4 = "SELECT DISTINCT item_id, \
        name \
        FROM Items;"

        cur = mysql.connection.cursor()
        cur.execute(query2)
        charitem_data = cur.fetchall()
        cur.execute(query3)
        charSet = cur.fetchall()
        cur.execute(query4)
        itemSet = cur.fetchall()

        return render_template("characteritems.j2", charitems=charitem_data, charSet=charSet, itemSet=itemSet)

@app.route('/characteritems/update/<int:id>', methods = ['GET', 'POST'])
def update_characteritems(id):
    """ This function implements the Update function of CRUD for Character Items. """
    if request.method == "POST":
        if request.form.get("character"):
            charID = request.form["character"]
            itemID = request.form["item"]
            
            query1 = f"UPDATE CharacterItems \
            SET character_id = {charID}, item = {itemID} \
            WHERE id = {id};"

            cur = mysql.connection.cursor()
            cur.execute(query1)
            mysql.connection.commit()

        return redirect(request.url)
    if request.method == "GET":
        query2 = "SELECT character_items_id AS ID, \
        CharacterItems.character_id AS CharacterID, \
        NonPlayableCharacters.name AS CharacterName, \
        CharacterItems.item_id AS ItemID, \
        Items.name AS itemName \
        FROM CharacterItems \
        INNER JOIN NonPlayableCharacters ON CharacterItems.character_id = NonPlayableCharacters.character_id \
        INNER JOIN Items ON CharacterItems.item_id = Items.item_id \
        WHERE CharacterItems.id = {id};"

        query3 = "SELECT DISTINCT character_id, \
        name \
        FROM NonPlayableCharacters;"

        query4 = "SELECT DISTINCT item_id, \
        name \
        FROM Items;"

        cur = mysql.connection.cursor()
        cur.execute(query2)
        charitem_data = cur.fetchall()
        cur.execute(query3)
        charSet = cur.fetchall()
        cur.execute(query4)
        itemSet = cur.fetchall()
        return render_template('updatecharacteritems.html', item = charitem_data, charSet=charSet, itemSet=itemSet)
    # POST - update item and render characteritems.html

@app.route('/characteritems/delete/<int:id>', methods= ['POST'])
def delete_characteritems(id):
    """ This function implements the Delete function of CRUD for Character Items. """
    if request.method == "POST":
        query1 = f"DELETE FROM CharacterItems WHERE CharacterItems.id = {id};"
        cur = mysql.connection.cursor()
        cur.execute(query1)
        mysql.connection.commit()
    return redirect("/characteritems.html")

@app.route('/shops')
def get_shops():
    return render_template("shops.html")

@app.route('/shopitems')
def get_shopitems():
    return render_template("shopitems.html")

@app.route('/regions')
def get_regions():
    return render_template("regions.html")

@app.route('/items')
def get_items():
    return render_template("items.html")


if __name__ == '__main__':
    app.run()
