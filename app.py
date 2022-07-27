from flask import Flask, render_template


app = Flask(__name__)

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
@app.route('/characteritems')
def get_characteritems():
    """ This function implements the Retrieve funciton of CRUD for Character Items"""
    return render_template("characteritems.html")

@app.route('/characteritems/create', methods = ['POST'])
def create_characteritems():
    """ This function implements the Create function of CRUD for Character Items """
    return "Create Character Item"

@app.route('/characteritems/update/<int:id>', methods = ['GET', 'POST'])
def update_characteritems(id):
    """ This function implements the Update function of CRUD for Character Items. """
    # GET
    return render_template('updatecharacteritems.html', item = id)
    # POST - update item and render characteritems.html

@app.route('/characteritems/delete/<int:id>', methods= ['GET', 'POST'])
def delete_characteritems(id):
    """ This function implements the Delete function of CRUD for Character Items. """
    # GET
    return render_template('deletecharacteritems.html', item = id)
    # POST - delete item and render characteritems.html

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
