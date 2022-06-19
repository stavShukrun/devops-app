from flask import Flask, flash, make_response, redirect, render_template, request, session
import pymongo
from form import SignInForm, SignUpForm,PetForm
import uuid
import os

app = Flask(__name__, static_folder='static',static_url_path='')
SECRET_KEY = b'0&\x93Cm}\x86\xff\xfa\xe1\xb4\xd9\xb2\xec\x867'
app.config['SECRET_KEY'] = SECRET_KEY

def get_db(db_name):
    client = pymongo.MongoClient(host=os.environ['MONGO_URI'],
                         port=27017, 
                         username=os.environ['MONGO_USERNAME'],
                         password=os.environ['MONGO_PASS'],
                         authSource='admin')
    db = client[db_name]
    return db

@app.before_request
def check_login():
    if request.endpoint in ('login_page','static', 'sign_up_page'):
        return
    print(request.endpoint)
    if not 'user' in session:
        return redirect('/sign-in')


@app.route('/', methods=["GET","POST"])
def index():
    return render_template('index.html')

@app.route('/sign-out', methods=["GET"])
def sign_out():
    session.pop('user', None)
    resp = make_response(redirect('/'))
    return resp


@app.route('/sign-in', methods=["GET","POST"])
def login_page():
    form = SignInForm()
    db = get_db("registration")
    user_db = db["users"]

    if form.is_submitted():
        user = {'name':form.name.data, 'password':form.password.data}
        try:
            if  user_db.find_one({'name':form.name.data})['name'] == user['name'] and user_db.find_one({'name':form.name.data})['password'] == user['password']:
                resp = make_response(redirect('/'))
                session['user'] = user['name']
                return resp
        except TypeError:
            flash('Invalid user or password')
    return render_template('login.html')

@app.route('/sign-up', methods=["GET","POST"])
def sign_up_page():
    db = get_db("registration")
    user_db = db["users"]
    form = SignUpForm()
    if form.is_submitted():
        if form.password.data != form.confirm_password.data:
            flash('Wrong confirm password')
            return render_template('singup.html', form=form)
        data = request.form
        user = {'name':form.name.data, 'password':form.password.data}
        x = user_db.insert_one(user)
        return redirect('/')
    return render_template('singup.html', form=form)

@app.route('/search', methods=["GET","POST"])
def search_pet():
    user = session['user']
    db = get_db("pets")
    pet_db = db["pet"]
    _pets = pet_db.find()
    pet_list = []
    for pet in _pets:
        pet_list.append({'chip':pet['chip'], 'pet name':pet['pet name'], 'owner':pet['owner'], 'phone_num':pet['phone_num'], 'vaccines':pet['vaccines']})

    if request.method == 'POST':
        chip_id = request.form.get('input')
        try:
            if pet_db.find_one({'chip':chip_id})['chip'] == chip_id :
                search_pet = []
                search_pet.append(pet_db.find_one({'chip':chip_id}))
                print(search_pet)
                return render_template('search.html',pet_list=search_pet)
        except TypeError:
             flash('Wrong chip')
    return render_template('search.html',pet_list=pet_list)

@app.route('/add', methods=["GET","POST"])
def add_pet():
    user = session['user']
    db = get_db("pets")
    pet_db = db["pet"]
    form = PetForm()
    if form.is_submitted():
        if form.chip.data == '':
            form.chip.data= uuid.uuid4().hex
            pet = {'chip':form.chip.data, 'pet name':form.pet_name.data, 'owner':form.owner.data, 'phone_num':form.phone_num.data, 'vaccines':request.form.get('Vaccines')}
            x = pet_db.insert_one(pet)
            flash(f"chip id is:{form.chip.data}")
            return render_template('add.html',form=form)
        elif pet_db.find_one({'chip':form.chip.data})['chip']== form.chip.data:
            pet = {'chip':form.chip.data, 'pet name':form.pet_name.data, 'owner':form.owner.data, 'phone_num':form.phone_num.data, 'vaccines':request.form.get('Vaccines')}
            x = pet_db.find_one_and_replace({'chip':form.chip.data},pet)
    return render_template('add.html',form=form)

@app.route('/delete', methods=["GET","POST"])
def delete_pet():
    user = session['user']
    db = get_db("pets")
    pet_db = db["pet"]
    if request.method == 'POST':
        chip_id = request.form.get('Input')
        print(chip_id)
        try:
            import pdb;pdb.set_trace()
            if pet_db.find_one({'chip':chip_id})['chip'] == chip_id :
                x = pet_db.find_one_and_delete({'chip':chip_id})
                flash(f"pet has deleted:{chip_id}")
        except TypeError:
             flash('Wrong chip')
    return render_template('delete.html')

if __name__ == "__main__":
    app.run(host="0.0.0.0" ,port=5000)