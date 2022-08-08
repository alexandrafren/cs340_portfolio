from flask import Flask, render_template, json, redirect, request
from flask_mysqldb import MySQL
import os


app = Flask(__name__)

# database connection
app.config["MYSQL_HOST"] = "classmysql.engr.oregonstate.edu"
app.config["MYSQL_USER"] = "cs340_frena"
app.config["MYSQL_PASSWORD"] = "2585"
app.config["MYSQL_DB"] = "cs340_frena"
app.config["MYSQL_CURSORCLASS"] = "DictCursor"


mysql = MySQL(app)

@app.route('/index')
def index():
    return render_template("index.html")

@app.route('/bundles', methods=["POST", "GET"])
def get_bundles():
    if request.method == "POST":
        if request.form.get("bundleName"):
            bundleName = request.form["bundleName"]
            bundleDesc = request.form["bundleDesc"]
            
            query1 = f"INSERT INTO Bundles (name, description) \
            VALUES ('{bundleName}', '{bundleDesc}');"

            cur = mysql.connection.cursor()
            cur.execute(query1)
            mysql.connection.commit()

        return redirect(request.url)

    if request.method == "GET":

        query2 = f"SELECT Bundles.bundle_id AS ID, \
        Bundles.name AS Name, \
        Bundles.description AS Description \
        FROM Bundles \
        ORDER BY ID ASC;"

        cur = mysql.connection.cursor()
        cur.execute(query2)
        bundles = cur.fetchall()
        return render_template("bundles.j2", bundles=bundles)

    return

@app.route('/bundleitems', methods=["POST", "GET"])
def get_bundleitems():
    if request.method == "POST":
        if request.form.get("bundle"):
            bundleID = request.form["bundle"]
            itemID = request.form["item"]
            
            query1 = f"INSERT INTO BundleItems (bundle_id, item_id) \
            VALUES ({bundleID}, {itemID});"

            cur = mysql.connection.cursor()
            cur.execute(query1)
            mysql.connection.commit()

        return redirect(request.url)
    if request.method == "GET":
        query2 = "SELECT BundleItems.bundle_items_id AS ID, \
        BundleItems.bundle_id AS BundleID, \
        Bundles.name AS BundleName, \
        BundleItems.item_id AS ItemID, \
        Items.name AS itemName \
        FROM BundleItems \
        INNER JOIN Bundles ON BundleItems.bundle_id = Bundles.bundle_id \
        INNER JOIN Items ON BundleItems.item_id = Items.item_id \
        ORDER BY BundleName ASC;"

        query3 = "SELECT DISTINCT bundle_id, \
        name \
        FROM Bundles;"

        query4 = "SELECT DISTINCT item_id, \
        name \
        FROM Items;"

        cur = mysql.connection.cursor()
        cur.execute(query2)
        bundleItems = cur.fetchall()
        cur.execute(query3)
        bundleSet = cur.fetchall()
        cur.execute(query4)
        itemSet = cur.fetchall()

        return render_template("bundleitems.j2", bundleItems=bundleItems, bundleSet=bundleSet, itemSet=itemSet)

@app.route('/characters', methods=["POST", "GET"])
def get_characters():
    if request.method == "POST":
        if request.form.get("name"):
            name = request.form["name"]
            desc = request.form["description"]
            occ = request.form["occupation"]
            bday = request.form["birthday"]
            region_id = request.form["region"]
            romanceable = request.form["romanceable"]
            
            query1 = f"INSERT INTO NonPlayableCharacters (name, description, occupation, birthday, region, is_romanceable) \
            VALUES ({name}, {desc}, {occ}, {bday}, {region_id}, {romanceable});"

            cur = mysql.connection.cursor()
            cur.execute(query1)
            mysql.connection.commit()

        return redirect(request.url)
    if request.method == "GET":
        query2 = "SELECT NonPlayableCharacters.character_id AS ID, \
        NonPlayableCharacters.name AS CharacterName, \
        NonPlayableCharacters.description AS CharacterDescription, \
        NonPlayableCharacters.occupation AS CharacterOccupation, \
        NonPlayableCharacters.birthday AS CharacterBirthday, \
        Regions.name AS CharacterRegion, \
        NonPlayableCharacters.is_romanceable AS CharacterIsRomanceable\
        FROM NonPlayableCharacters\
        INNER JOIN Regions ON NonPlayableCharacters.region_id = Regions.region_id \
        ORDER BY CharacterName ASC;"

        query3 = "SELECT DISTINCT region_id, \
        name \
        FROM Regions;"

        cur = mysql.connection.cursor()
        cur.execute(query2)
        char_data = cur.fetchall()
        cur.execute(query3)
        regionSet = cur.fetchall()
        return render_template("characters.j2", charSet=char_data, regionSet=regionSet)


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

@app.route('/characteritems/update/<int:id>', methods = ['POST','GET'])
def update_characteritems(id):
    """ This function implements the Update function of CRUD for Character Items. """
    if request.method == "POST":
        if request.form.get("character"):
            charID = request.form["character"]
            itemID = request.form["item"]
            
            query1 = f"UPDATE CharacterItems \
            SET character_id = {charID}, item_id = {itemID} \
            WHERE character_items_id = {id};"

            cur = mysql.connection.cursor()
            cur.execute(query1)
            mysql.connection.commit()
            
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
    if request.method == "GET":
        query2 = f"SELECT character_items_id AS ID, \
        CharacterItems.character_id AS CharacterID, \
        NonPlayableCharacters.name AS CharacterName, \
        CharacterItems.item_id AS ItemID, \
        Items.name AS itemName \
        FROM CharacterItems \
        INNER JOIN NonPlayableCharacters ON CharacterItems.character_id = NonPlayableCharacters.character_id \
        INNER JOIN Items ON CharacterItems.item_id = Items.item_id \
        WHERE CharacterItems.character_items_id = {id};"

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
        return render_template('updatecharacteritems.html', charitem = charitem_data, charSet=charSet, itemSet=itemSet)


@app.route('/characteritems/delete/<int:id>', methods= ['POST'])
def delete_characteritems(id):
    """ This function implements the Delete function of CRUD for Character Items. """
    if request.method == "POST":
        query1 = f"DELETE FROM CharacterItems WHERE CharacterItems.character_items_id = {id};"
        cur = mysql.connection.cursor()
        cur.execute(query1)
        mysql.connection.commit()

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

@app.route('/shops', methods=["POST", "GET"])
def get_shops():
    if request.method == "POST":
        if request.form.get("shopName"):
            shopName = request.form["shopName"]
            shopDesc = request.form["shopDesc"]
            charID = request.form["shopkeeper"]
            regionID = request.form["region"]
            opHours = request.form["opHours"]
            
            query1 = f"INSERT INTO Shops (name, operating_hours, shop_character_id, region_id, description) \
            VALUES ('{shopName}', '{opHours}', {charID}, {regionID}, '{shopDesc}');"

            cur = mysql.connection.cursor()
            cur.execute(query1)
            mysql.connection.commit()

        return redirect(request.url)
    if request.method == "GET":

        query2 = f"SELECT Shops.shop_id AS ID, \
        Shops.name AS Name, \
        Shops.description AS Description, \
        NonPlayableCharacters.name AS Shopkeeper, \
        Regions.name AS Region, \
        Shops.operating_hours AS OperatingHours \
        FROM Shops \
        INNER JOIN NonPlayableCharacters ON Shops.shop_character_id = NonPlayableCharacters.character_id \
        INNER JOIN Regions ON Shops.region_id = Regions.region_id \
        ORDER BY ID ASC;"

        query3 = "SELECT DISTINCT character_id, \
        name \
        FROM NonPlayableCharacters;"

        query4 = "SELECT DISTINCT region_id, \
        name \
        FROM Regions;"

        cur = mysql.connection.cursor()
        cur.execute(query2)
        shopsData = cur.fetchall()
        cur.execute(query3)
        charSet = cur.fetchall()
        cur.execute(query4)
        regSet = cur.fetchall()
        return render_template("shops.j2", shopsData=shopsData, charSet=charSet, regSet=regSet)

    return

@app.route('/shopitems', methods=["POST", "GET"])
def get_shopitems():
    if request.method == "POST":
        if request.form.get("shop"):
            shopID = request.form["shop"]
            itemID = request.form["item"]

            query1 = f"INSERT INTO ShopItems (shop_id, item_id) \
            VALUES ({shopID}, {itemID});"

            cur = mysql.connection.cursor()
            cur.execute(query1)
            mysql.connection.commit()

        return redirect(request.url)
    if request.methhod == "GET":
        query2 = "SELECT ShopItems.shop_items_id AS ID, \
            ShopItems.shop_id AS ShopID, \
            Shops.name AS ShopName, \
            ShopItems.item_id AS ItemID, \
            Items.name AS ItemName \
            FROM ShopItems \
            INNER JOIN Shops ON ShopItems.shop_id = Shops.shop_id \
            INNER JOIN Items on ShopItems.item_id = Items.item_id \
            ORDER BY ShopName ASC;"
        
        query3 = "SELECT DISTINCT shop_id, name FROM Shops;"
        query4 = "SELECT DISTINCT item_id, name FROM Items;"

        cur = mysql.connection.cursor()
        cur.execute(query2)
        shopitem_data = cur.fetchall()
        cur.execute(query3)
        shopSet = cur.fetchall()
        cur.execute(query4)
        itemSet = cur.fetchall()

    return render_template("shopitems.html", shopItems=shopitem_data, shopSet=shopSet, itemSet=itemSet)

@app.route('/regions', methods=["POST", "GET"])
def get_regions():

    if request.method == "POST":
        if request.form.get("regName"):
            regName = request.form["regName"]
            regDesc = request.form["regDesc"]
            
            query1 = f"INSERT INTO Regions (name, description) \
            VALUES ('{regName}', '{regDesc}');"

            cur = mysql.connection.cursor()
            cur.execute(query1)
            mysql.connection.commit()

        return redirect(request.url)

    if request.method == "GET":

        query2 = f"SELECT Regions.region_id AS ID, \
        Regions.name AS Name, \
        Regions.description AS Description \
        FROM Regions \
        ORDER BY ID ASC;"

        cur = mysql.connection.cursor()
        cur.execute(query2)
        regions = cur.fetchall()
        return render_template("regions.j2", regions=regions)

    return

@app.route('/items', methods=["POST", "GET"])
def get_items():
    # ADD SEARCH HANDLING
    if request.method == "POST":
        if request.form.get("name"):
            name = request.form["name"]
            desc= request.form["description"]
            seasons = request.form["seasons"]

            query1 = f"INSERT INTO Items (name, description, seasons) \
            VALUES ({name}, {desc}, {seasons});"

            cur = mysql.connection.cursor()
            cur.execute(query1)
            mysql.connection.commit()

        return redirect(request.url)
    if request.method == "GET":
        query2 = "SELECT Items.item_id AS ID, \
            Items.name AS ItemName, \
            Items.seasons AS ItemSeasons, \
            Items.description AS ItemDescription \
            FROM Items \
            ORDER BY ID ASC;"

        cur = mysql.connection.cursor()
        cur.execute(query2)
        itemSet = cur.fetchall()
    return render_template("items.html", itemSet=itemSet)

@app.route('/items/update/<int:id>', methods=["POST", "GET"])
def update_items(id):
    if request.method == "POST":
        if request.form["name"]:
            name = request.form["name"]
            desc = request.form["desc"]
            seasons = request.form["seasons"]

            query1 = f"UPDATE Items \
            SET name={name}, description={desc}, seasons={seasons} \
            WHERE item_id = {id}"
            query2 = "SELECT * FROM Items \
                ORDER BY Items.name ASC;"

            cur = mysql.connection.cursor()
            cur.execute(query1)
            mysql.connection.commit()
            cur.execute(query2)
            itemSet = cur.fetchall()
            return render_template("items.html", itemSet=itemSet)
    if request.method == "GET":
        query3 = f"SELECT * FROM Items \
        WHERE Items.item_id = {id};"
        
        cur = mysql.connection.cursor()
        cur.execute(query3)
        itemSet = cur.fetchall()
        #display the form
        return render_template("updateitems.html", itemSet=itemSet)

@app.route('/items/delete/<int:id>', methods=["POST"])
def delete_items(id):
    if request.method == "POST":
        query1 = f"DELETE FROM Items WHERE Items.item_id = {id}"

        query2 = "SELECT * FROM Items \
            ORDER BY Items.name ASC;"

        cur = mysql.connection.cursor()
        cur.execute(query1)
        mysql.connection.commit()
        cur.execute(query2)
        itemSet = cur.fetchall()
        return render_template("items.html", itemSet=itemSet)



if __name__ == '__main__':
    app.run(port=53271,debug=True)
