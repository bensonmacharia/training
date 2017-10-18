from datetime import date
from pony.orm import *


db = Database()


class Movie(db.Entity):
    id = PrimaryKey(int, auto=True)
    genre = Required('Genre')
    age_rating = Required('AgeRating')
    dvds = Set('Dvd')
    name = Optional(str)
    length = Optional(int)
    description = Optional(LongStr)
    poster = Optional(str)
    year_of_release = Optional(date)
    producer = Optional(str)


class Customer(db.Entity):
    id = PrimaryKey(int, auto=True)
    first_name = Optional(str)
    last_lane = Optional(str)
    phone = Optional(str)
    address = Optional(LongStr)
    email = Optional(str)
    family = Optional(bool)
    blacklisted = Optional(bool)
    cust_dvds = Set('Cust_dvd')


class Shelf(db.Entity):
    id = PrimaryKey(int, auto=True)
    dvds = Set('Dvd')
    racks = Optional(int)
    max_capacity = Optional(int)


class Genre(db.Entity):
    id = PrimaryKey(int, auto=True)
    movies = Set(Movie)
    name = Optional(str)
    description = Optional(LongStr)


class AgeRating(db.Entity):
    id = PrimaryKey(int, auto=True)
    movies = Set(Movie)
    name = Optional(str)
    min_age = Optional(int)


class Dvd(db.Entity):
    id = PrimaryKey(int, auto=True)
    movie = Required(Movie)
    shelf = Required(Shelf)
    cust_dvds = Set('Cust_dvd')


class Cust_dvd(db.Entity):
    dvds = Required(Dvd)
    customers = Required(Customer)
    date_in = Optional(date)
    date_out = Optional(date)
    PrimaryKey(dvds, customers)



db.bind('postgres', user='bmacharia', password='Kadogo*10',host='localhost', database='bmacharia')

db.generate_mapping(create_tables = True)
