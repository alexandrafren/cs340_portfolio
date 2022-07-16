from flask import Flask, render_template


app = Flask(__name__)

@app.route('/index')
def index():
    return render_template("index.html")

@app.route('/bundles')
def get_bundles():
    return render_template("bundles.html")

@app.route('/characters')
def get_characters():
    return render_template("characters.html")

@app.route('/shops')
def get_shops():
    return render_template("shops.html")

@app.route('/regions')
def get_regions():
    return render_template("regions.html")

@app.route('/items')
def get_items():
    return render_template("items.html")


if __name__ == '__main__':
    app.run()
