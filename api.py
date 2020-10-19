import flask
import datetime
import requests
import math
from flask_session import Session
import json
from flask_mail import Mail
import sqlalchemy
from flask_sqlalchemy import SQLAlchemy


with open('config.json','r') as c:
	params = json.load(c)["params"]

local_server = True
app = flask.Flask(__name__)

#app secret key for session
app.secret_key = 'super-secret-key'

#mail function
app.config.update(
    MAIL_SERVER = 'smtp.gmail.com',
	MAIL_PORT = '465',
	MAIL_USE_SSL = True,
	MAIL_USERNAME = params['gmail_user'],
	MAIL_PASSWORD = params['gmail_pass']
)

mail = Mail(app) #mail function call to send the email


#database loading from localhost or production 
if (local_server):
	app.config["SQLALCHEMY_DATABASE_URI"] = params['local_uri']
else:
	app.config["SQLALCHEMY_DATABASE_URI"] = params['prod_uri']	

app.config["SQLALCHEMY_DATABASE_URI"] = 'mysql://root:@localhost/flask'
db = SQLAlchemy(app)

class Contact(db.Model):
	id = db.Column(db.Integer, primary_key=True)
	name = db.Column(db.String(120), unique=False)
	email = db.Column(db.String(120), unique=True)
	phone =  db.Column(db.String(12), unique=True)
	message =  db.Column(db.String(300), unique=False)


#displaying posts with database

class Posts(db.Model):
	serial = db.Column(db.Integer, primary_key=True)
	title = db.Column(db.String(120), nullable=False)
	slug = db.Column(db.String(21), nullable=False)
	content =  db.Column(db.String(120), unique=True)
	date =  db.Column(db.String(12), nullable=True)
	

#routes of different pages

@app.route('/login', methods= ['GET', 'POST'])
def login():
	if('user' in flask.session and flask.session['user']  == params['username']): #if user is already logged in
		posts = Posts.query.all()
		return flask.render_template('dashboard.html', params = params, posts = posts)



	if flask.request.method == 'POST':
		username = flask.request.form.get('username')
		password = flask.request.form.get('pass')
		if (username == params['username'] and password == params['pass']):
			flask.session['user'] =  username
			posts = Posts.query.all()
			return flask.render_template('dashboard.html', params = params, posts = posts)

	
	return flask.render_template('login.html', params = params)
    

#homepage (Posts with the validation)
@app.route('/')
def home():
	posts = Posts.query.filter_by().all()
	last = math.ceil(len(posts)/int(params['posts_per_page']))
	
	#[0:params['posts_per_page']]
	#posts = posts[]
	
	page = flask.request.args.get('page')
	if (not str(page).isnumeric()): 
		page = 1
	page = int(page)	 

	posts = posts[(page-1)*int(params['posts_per_page']) : (page-1)*int(params['posts_per_page']) + int(params['posts_per_page'])]	
    
	if (page == 1):
		prev = "#"
		next = "/?page=" + str(page + 1)

		
	elif(page == last):
		prev = "/?page=" + str(page - 1)
		next = "#"
 	
	else:
		prev = "/?page=" + str(page - 1)
		next = "/?page=" + str(page + 1)		

	
	return flask.render_template('index.html', params = params , posts = posts, prev = prev , next = next)

#about page
@app.route('/about')
def about():
	return flask.render_template('about.html', params = params)

#contact page
@app.route('/contact', methods=["GET","POST"])
def contact():
	if flask.request.method == 'POST':
		''' Add Request to Database'''
		name = flask.request.form.get('name')
		email = flask.request.form.get('email')
		phone = flask.request.form.get('phone')
		message = flask.request.form.get('message')

		entry = Contact(name=name, phone = phone, email = email ,message = message)
		db.session.add(entry)
		db.session.commit()   #here data is added on the database

		#mail function to send the email to the admin
		mail.send_message('New Message from ' + name, 
		                 sender= email, 
						 recipients=[params['gmail_user']],
						 body = message + '\n' + phone	 + '\n' + email		 
						 )

	return flask.render_template('contact.html', params = params)


@app.route('/post/<string:post_slug>', methods = ['GET'])
def post_route(post_slug):
	posts = Posts.query.filter_by(slug=post_slug).first()
	return flask.render_template('post.html', params = params , post = posts)


# edit posts via backend and add a new posts
@app.route('/edit/<string:serial>', methods = ['GET','POST'])
def edit(serial):
	if('user' in flask.session and flask.session['user']  == params['username']):
		if flask.request.method == 'POST':
			title = flask.request.form.get('title')
			
			slug = flask.request.form.get('slug')
			content = flask.request.form.get('content')
			date =  datetime.datetime.now()

			if serial == '0':
				post = Posts(title = title, slug = slug, content = content, date = date)
				db.session.add(post)
				db.session.commit()
			else:
				post = Posts.query.filter_by(serial=serial).first()
				post.title =  title
				post.slug  =  slug
				post.content = content 
				db.session.commit()	
				return flask.redirect('/edit/'+serial )
		post = Posts.query.filter_by(serial=serial).first()

		return flask.render_template('edit.html', params = params, serial = serial, post = post)


#logout

@app.route("/logout")
def logout():
	flask.session.pop('user')
	return flask.redirect('/login')		


#delete
@app.route('/delete/<string:serial>', methods = ['GET','POST'])
def delete(serial):
	if('user' in flask.session and flask.session['user']  == params['username']):
		post = Posts.query.filter_by(serial = serial).first()
		db.session.delete(post)
		db.session.commit()
	return flask.redirect('/login')	

		                   
app.run(debug= True)