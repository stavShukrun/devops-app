from flask_wtf import FlaskForm
from wtforms import (StringField, TextAreaField, IntegerField, BooleanField)
from wtforms.validators import InputRequired, Length

class SignUpForm(FlaskForm):
    name = StringField('Name', validators=[InputRequired(),Length(min=2, max=20)])
    password =  StringField('password', validators=[InputRequired(),Length(min=2, max=8)])
    confirm_password = StringField('confirm-password', name='confirm-password', validators=[InputRequired(),Length(min=2, max=8)])

class SignInForm(FlaskForm):
    name = StringField('Name', validators=[InputRequired(),Length(min=2, max=20)])
    password =  StringField('password', validators=[InputRequired(),Length(min=2, max=8)])

class PetForm(FlaskForm):
    chip = TextAreaField('chip',validators=[InputRequired(),Length(max=20)])
    pet_name = TextAreaField('pet name',validators=[InputRequired(),Length(max=20)])
    owner =  TextAreaField('owner name',validators=[InputRequired(),Length(max=20)])
    phone_num =  IntegerField('phone number', validators=[InputRequired()])
    vaccines = BooleanField('Vaccines', validators=[InputRequired()])