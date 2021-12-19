SET search_path = "main";

CREATE TABLE IF NOT EXISTS "genres"
(
    "genre_id"  INTEGER     NOT NULL PRIMARY KEY,
    "genreName" VARCHAR(15) NOT NULL
);

CREATE TABLE IF NOT EXISTS "moviesGenres"
(
    "movie_id" INTEGER NOT NULL,
    "genre_id" INTEGER NOT NULL
);

CREATE TABLE IF NOT EXISTS "movies"
(
    "id"           INTEGER PRIMARY KEY,
    "movie_name"   VARCHAR(120)     NOT NULL,
    "release_date" DATE             NULL,
    "budget"       DOUBLE PRECISION NULL,
    "revenue"      DOUBLE PRECISION NULL,
    "runtime"      INTEGER          NULL,
    "avg_votes"    DOUBLE PRECISION NULL,
    "homepage_url" VARCHAR(255)     NULL
);

CREATE TABLE IF NOT EXISTS "moviesCountries"
(
    "movie_id"     INTEGER     NOT NULL,
    "country_code" VARCHAR(10) NOT NULL
);

CREATE TABLE IF NOT EXISTS "countries"
(
    "country_code"   VARCHAR(10) PRIMARY KEY,
    "country_name"   VARCHAR(100) NOT NULL,
    "continent_name" VARCHAR(100) NULL,
    "country_code_3" VARCHAR(10)  NOT NULL,
    "country_number" INTEGER      NULL
);

CREATE TABLE IF NOT EXISTS "moviesProdCompanies"
(
    "movie_id"        INTEGER NOT NULL,
    "prod_company_id" INTEGER NOT NULL
);

CREATE TABLE IF NOT EXISTS "prodCompanies"
(
    "id"           INTEGER PRIMARY KEY,
    "company_name" VARCHAR(120) NOT NULL
);

CREATE TABLE IF NOT EXISTS "actors"
(
    "id"        INTEGER PRIMARY KEY,
    "name"      VARCHAR(120) NOT NULL,
    "gender_id" INTEGER      NULL
);

CREATE TABLE IF NOT EXISTS "casts"
(
    "movie_id"       INTEGER NOT NULL,
    "actor_id"       INTEGER NOT NULL,
    "character_name" TEXT    NULL,
    "plan_order"     INTEGER NULL
);

CREATE TABLE IF NOT EXISTS "moviesCrew"
(
    "movie_id"       INTEGER NOT NULL,
    "crew_person_id" INTEGER NOT NULL
);

CREATE TABLE IF NOT EXISTS "crewPeople"
(
    "id"         INTEGER PRIMARY KEY,
    "name"       VARCHAR(255) NOT NULL,
    "job"        VARCHAR(255) NULL,
    "department" VARCHAR(255) NULL,
    "gender_id"  INTEGER      NULL
);

CREATE TABLE IF NOT EXISTS "users"
(
    "username"  VARCHAR(255) NOT NULL,
    "name"      VARCHAR(255) NULL,
    "sex"       VARCHAR(255) NULL,
    "address"   VARCHAR(255) NULL,
    "mail"      VARCHAR(255) NOT NULL,
    "birthdate" DATE         NULL,
    "user_id"   SERIAL PRIMARY KEY
);

CREATE TABLE IF NOT EXISTS "genders"
(
    "id"    INTEGER PRIMARY KEY,
    "title" VARCHAR(255) NOT NULL
);

CREATE TABLE IF NOT EXISTS "payment_tariffs"
(
    "id"                     INTEGER PRIMARY KEY,
    "activation_name"        VARCHAR(10)      NOT NULL,
    "activation_period_days" INTEGER          NOT NULL,
    "price"                  DOUBLE PRECISION NOT NULL
);

CREATE TABLE IF NOT EXISTS "purchases"
(

    "movie_id"  INTEGER   NOT NULL,
    "user_id"   INTEGER   NOT NULL,
    "tariff_id" INTEGER   NOT NULL,
    "datetime"  TIMESTAMP NOT NULL,
    "id"        SERIAL PRIMARY KEY
);

-- ALTER TABLE
--     "moviesGenres"
--     ADD CONSTRAINT "moviesgenres_movie_id_foreign" FOREIGN KEY ("movie_id") REFERENCES "movies" ("id");
-- ALTER TABLE
--     "moviesProdCompanies"
--     ADD CONSTRAINT "moviesprodcompanies_movie_id_foreign" FOREIGN KEY ("movie_id") REFERENCES "movies" ("id");
-- ALTER TABLE
--     "casts"
--     ADD CONSTRAINT "casts_movie_id_foreign" FOREIGN KEY ("movie_id") REFERENCES "movies" ("id");
-- ALTER TABLE
--     "moviesCrew"
--     ADD CONSTRAINT "moviescrew_movie_id_foreign" FOREIGN KEY ("movie_id") REFERENCES "movies" ("id");
-- ALTER TABLE
--     "purchases"
--     ADD CONSTRAINT "purchases_movie_id_foreign" FOREIGN KEY ("movie_id") REFERENCES "movies" ("id");
-- ALTER TABLE
--     "moviesGenres"
--     ADD CONSTRAINT "moviesgenres_genre_id_foreign" FOREIGN KEY ("genre_id") REFERENCES "genres" ("genre_id");
-- ALTER TABLE
--     "moviesCountries"
--     ADD CONSTRAINT "moviescountries_movie_id_foreign" FOREIGN KEY ("movie_id") REFERENCES "movies" ("id");
-- ALTER TABLE
--     "moviesCountries"
--     ADD CONSTRAINT "moviescountries_country_code_foreign" FOREIGN KEY ("country_code") REFERENCES "countries" ("country_code");
-- ALTER TABLE
--     "moviesProdCompanies"
--     ADD CONSTRAINT "moviesprodcompanies_prod_company_id_foreign" FOREIGN KEY ("prod_company_id") REFERENCES "prodCompanies" ("id");
-- ALTER TABLE
--     "casts"
--     ADD CONSTRAINT "casts_actor_id_foreign" FOREIGN KEY ("actor_id") REFERENCES "actors" ("id");
-- ALTER TABLE
--     "actors"
--     ADD CONSTRAINT "actors_gender_id_foreign" FOREIGN KEY ("gender_id") REFERENCES "genders" ("id");
-- ALTER TABLE
--     "moviesCrew"
--     ADD CONSTRAINT "moviescrew_crew_person_id_foreign" FOREIGN KEY ("crew_person_id") REFERENCES "crewPeople" ("id");
-- ALTER TABLE
--     "crewPeople"
--     ADD CONSTRAINT "crewpeople_gender_id_foreign" FOREIGN KEY ("gender_id") REFERENCES "genders" ("id");
-- ALTER TABLE
--     "purchases"
--     ADD CONSTRAINT "purchases_tariff_id_foreign" FOREIGN KEY ("tariff_id") REFERENCES "payment_tariffs" ("id");
-- ALTER TABLE
--     "purchases"
--     ADD CONSTRAINT "purchases_user_id_foreign" FOREIGN KEY ("user_id") REFERENCES "users" ("user_id");
