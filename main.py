'''
    HOw to handle Xamp server-
    https://stackoverflow.com/questions/18022809/xampp-mysql-shutdown-unexpectedly

'''

from flask import Flask, render_template, request, redirect
from flask_sqlalchemy import SQLAlchemy
from werkzeug.utils import secure_filename
from flask import  session
from datetime import datetime
import json
import  os
import math

##-- config---
with open('config.json','r') as c:
    params = json.load(c)["params"]

##---------fgfg

app = Flask(__name__)
app.config['SQLALCHEMY_DATABASE_URI'] = params["local_uri"]
db = SQLAlchemy(app)

class Customers(db.Model):
    '''
    sno, name phone_num, msg, date, email
    '''
    sno = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(80), nullable=False)
    phone_num = db.Column(db.String(12), nullable=False)
    msg = db.Column(db.String(120), nullable=False)
    date = db.Column(db.String(12), nullable=True)
    email = db.Column(db.String(20), nullable=False)


class Journal(db.Model):
    sno = db.Column(db.Integer, primary_key=True)
    title = db.Column(db.String(80), nullable=False)
    slug = db.Column(db.String(21), nullable=False)
    content = db.Column(db.String(120), nullable=False)
    date = db.Column(db.String(12), nullable=True)
    img_file = db.Column(db.String(12), nullable=True)

app.secret_key = params['secret_key']
app.config['UPLOAD_FOLDER'] = params['upload_location']


#--------try start ------

@app.route("/")
def fun():
    posts = Journal.query.filter_by().all()
    last = math.ceil(len(posts)/int(params['no_of_posts']))
    page = request.args.get('page')
    print(page,type(page))
    if(not str(page).isnumeric()):
        page=1
    page = int(page)
    print(page,type(page))
    a = (page-1)*int(params['no_of_posts'])
    b = a + int(params['no_of_posts'])
    print(a,b,last)
    posts = posts[a:b]

    if(page==1):
        prev = "#"
        next = "/?page=" + str(page+1)
        print("if",prev,next)
    elif(page==last):
        prev = "/?page=" + str(page - 1)
        next = "#"
        print("elif",prev,next)
    else:
        prev = "/?page=" + str(page - 1)
        next = "/?page=" + str(page + 1)
        print("else",prev,next)

    return render_template('fun.html',params=params, posts=posts, prev=prev, next=next)


'''
@app.route("/")
def home():
    posts = Journal.query.filter_by().all()[0:int(params['no_of_posts'])] # params['no_of_posts']
    print(posts[0])
    return render_template('index.html',params=params, posts=posts)
'''

@app.route("/about")
def about():
    return render_template('about.html',params=params)

'''  #testing Area  '''
@app.route("/explore")
def explore():
    return render_template('explore.html',params=params)

''' testing Area End'''


@app.route("/contact", methods = ['GET', 'POST'])
def contact():
    if(request.method=='POST'):
        name = request.form.get('name')
        email = request.form.get('email')
        phone = int(request.form.get('phone'))
        message = request.form.get('message')
        entry = Customers(name=name, phone_num = phone, msg = message, date= datetime.now(),email = email )
        db.session.add(entry)
        db.session.commit()

        print(name , email , phone , message , entry)
    return render_template('contact.html')
   # return render_template('about.html',params=params)

@app.route("/post/<string:post_slug>", methods = ['GET'])
def post(post_slug):

    post = Journal.query.filter_by(slug = post_slug).first()
    print(post)
    return render_template("post.html",params = params,post = post)

@app.route("/dashboard", methods=['GET', 'POST'])
def dashboard():
    if "user" in session and session['user']==params['admin_user']:
        post = Journal.query.all()
        return render_template("dashboard.html", params=params, posts=post)

    if request.method=="POST":
        #REDIRECT TO ADMIN PANEL
        username = request.form.get("uname")
        userpass = request.form.get("upass")
        if username==params['admin_user'] and userpass==params['admin_password']:
            #set session variable
            session['user']=username
            posts = Journal.query.all()
            return render_template("dashboard.html", params=params, posts=posts)
    else:
        return render_template("login.html", params=params)

@app.route("/logout")
def logout():
    session.pop('user')
    return redirect('/dashboard')

@app.route("/edit/<string:sno>", methods=['GET', 'POST'])
def edit(sno):
    if('user' in session and session['user']==params['admin_user']):

        if request.method == 'POST':
            box_title = request.form.get('title')
            box_slug = request.form.get('slug')
            box_img = request.form.get('imgpath')
            box_content = request.form.get('content')

            print(box_title,box_img,box_slug,box_content)
            # to add new post, sno=0 else edit post
            if sno=='0':
                update = Journal(title=box_title, slug=box_slug, img_file=box_img, content=box_content, date = datetime.now() )
                db.session.add(update)
                db.session.commit()
            else:
                post = Journal.query.filter_by(sno=sno).first()
                post.title = box_title
                post.slug = box_slug
                post.img_path = box_img
                post.content = box_content
                post.date = datetime.now()
                db.session.commit()
            return redirect("/dashboard")

        post = Journal.query.filter_by(sno=sno).first()
        if(sno=='0'):
            print("000 sno",post)
            return render_template('edit.html', params=params, post=post, x=0) # add new entry
        else:
            print("ye kya h",sno,post)
            return render_template('edit.html',params=params,post=post ,x=sno)
    else:
        return "login again"
    #return render_template("edit.html",params=params)

@app.route("/delete/<string:sno>", methods=['GET', 'POST'])
def delete(sno):
    if('user' in session and session['user']==params['admin_user']):
        post = Journal.query.filter_by(sno=sno).first()
        db.session.delete(post)
        db.session.commit();
    return redirect("/dashboard")

@app.route("/uploader", methods=['GET','POST'])
def upload():
    if ('user' in session and session['user'] == params['admin_user']):
        if request.method == 'POST':
            f = request.files['myfile']
            print(f)
            f.save(os.path.join(app.config['UPLOAD_FOLDER'], secure_filename(f.filename)))
            return "File Uploaded Successfully"

app.run(debug=True)



'''
from flask import Flask, render_template, request
from flask_sqlalchemy import SQLAlchemy
#from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker

from datetime import datetime


app = Flask(__name__)

## --------------- DB CONNECTION -----------

app.config['SQLALCHEMY_DATABASE_URI'] = 'mysql+mysqlconnector://root:root@localhost/blog'
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = True
db = SQLAlchemy(app)

class posts(db.Model):
   sno = db.Column(db.Integer, primary_key=True)
   name = db.Column(db.String(80), nullable=False)
   phone_num = db.Column(db.String(12), nullable=False)
   msg = db.Column(db.String(120), nullable=False)
   date = db.Column(db.String(12), nullable=True)
   email = db.Column(db.String(20), nullable=False)



## ------------ROUTING ------------------------

@app.route('/')
def home():
    return render_template("index.html")

@app.route('/about')
def about():
    return render_template("about.html")

@app.route('/contact', methods = ['GET', 'POST'])
def contact():
    if (request.method == 'POST'):
        
        name = request.form.get('name')
        email = request.form.get('email')
        phone = request.form.get('phone')
        message = request.form.get('message')
        entry = posts(name=name, phone_num=phone, msg=message, date=datetime.now(), email=email)
        print("entry : ", entry)
        print(name , email , phone , message , entry)
        db.session.add(entry)
        db.session.commit()
        return ("hello")
    return render_template('contact.html')

@app.route('/db')
def db():
    x = posts.query.all()
    print(x)
    for i in range(len(x)):
        print(x[i].name)
    return "ff"

## ----------- ROUTING END -----------------------

if __name__ == '__main__':
    app.run(debug=True)
'''