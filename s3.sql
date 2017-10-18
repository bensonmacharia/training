CREATE TABLE "agerating" (
  "id" SERIAL CONSTRAINT "pk_agerating" PRIMARY KEY,
  "name" TEXT NOT NULL,
  "min_age" INTEGER
);

CREATE TABLE "customer" (
  "id" SERIAL CONSTRAINT "pk_customer" PRIMARY KEY,
  "first_name" TEXT NOT NULL,
  "last_lane" TEXT NOT NULL,
  "phone" TEXT NOT NULL,
  "address" TEXT NOT NULL,
  "email" TEXT NOT NULL,
  "family" BOOLEAN,
  "blacklisted" BOOLEAN
);

CREATE TABLE "genre" (
  "id" SERIAL CONSTRAINT "pk_genre" PRIMARY KEY,
  "name" TEXT NOT NULL,
  "description" TEXT NOT NULL
);

CREATE TABLE "movie" (
  "id" SERIAL CONSTRAINT "pk_movie" PRIMARY KEY,
  "genre" INTEGER NOT NULL,
  "age_rating" INTEGER NOT NULL,
  "name" TEXT NOT NULL,
  "length" INTEGER,
  "description" TEXT NOT NULL,
  "poster" TEXT NOT NULL,
  "year_of_release" DATE,
  "producer" TEXT NOT NULL
);

CREATE INDEX "idx_movie__age_rating" ON "movie" ("age_rating");

CREATE INDEX "idx_movie__genre" ON "movie" ("genre");

ALTER TABLE "movie" ADD CONSTRAINT "fk_movie__age_rating" FOREIGN KEY ("age_rating") REFERENCES "agerating" ("id");

ALTER TABLE "movie" ADD CONSTRAINT "fk_movie__genre" FOREIGN KEY ("genre") REFERENCES "genre" ("id");

CREATE TABLE "shelf" (
  "id" SERIAL CONSTRAINT "pk_shelf" PRIMARY KEY,
  "racks" INTEGER,
  "max_capacity" INTEGER
);

CREATE TABLE "dvd" (
  "id" SERIAL CONSTRAINT "pk_dvd" PRIMARY KEY,
  "movie" INTEGER NOT NULL,
  "shelf" INTEGER NOT NULL
);

CREATE INDEX "idx_dvd__movie" ON "dvd" ("movie");

CREATE INDEX "idx_dvd__shelf" ON "dvd" ("shelf");

ALTER TABLE "dvd" ADD CONSTRAINT "fk_dvd__movie" FOREIGN KEY ("movie") REFERENCES "movie" ("id");

ALTER TABLE "dvd" ADD CONSTRAINT "fk_dvd__shelf" FOREIGN KEY ("shelf") REFERENCES "shelf" ("id");

CREATE TABLE "cust_dvd" (
  "dvds" INTEGER NOT NULL,
  "customers" INTEGER NOT NULL,
  "date_in" DATE,
  "date_out" DATE,
  CONSTRAINT "pk_cust_dvd" PRIMARY KEY ("dvds", "customers")
);

CREATE INDEX "idx_cust_dvd__customers" ON "cust_dvd" ("customers");

ALTER TABLE "cust_dvd" ADD CONSTRAINT "fk_cust_dvd__customers" FOREIGN KEY ("customers") REFERENCES "customer" ("id");

ALTER TABLE "cust_dvd" ADD CONSTRAINT "fk_cust_dvd__dvds" FOREIGN KEY ("dvds") REFERENCES "dvd" ("id")
