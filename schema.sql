CREATE TABLE "matches" (
    "id" INTEGER ,
    "home_team" TEXT NOT NULL,
    "away_team" TEXT NOT NULL,
    "match_date" NUMERIC NOT NULL,
    "stadium_id" INTEGER NOT NULL ,
    "type" TEXT NOT NULL ,
    "ended" TEXT DEFAULT 0,
    PRIMARY KEY("id"),
    FOREIGN KEY("stadium_id") REFERENCES "stadiums"("id")
);

CREATE TABLE "stadiums"(
    "id" INTEGER NOT NULL ,
    "name" TEXT NOT NULL ,
    "capacity" INTEGER NOT NULL ,
    "city" TEXT ,
    PRIMARY KEY("id")
);

CREATE TABLE "zones" (
    "id" INTEGER NOT NULL,
    "name" TEXT NOT NULL ,
    "capacity" INTEGER NOT NULL,
    "stadium_id" INTEGER NOT NULL,
    "price" INTEGER NOT NULL,
    PRIMARY KEY("id"),
    FOREIGN KEY("stadium_id") REFERENCES "stadiums"("id")
);

CREATE TABLE "tickets" (
    "id" INTEGER ,
    "zone_id" INTEGER NOT NULL ,
    "match_id" INTEGER NOT NULL ,
    "stadium_id" INTEGER NOT NULL,
    "price" REAL NOT NULL ,
    "used" INTEGER DEFAULT 0,
    "use_time" NUMERIC DEFAULT NULL,
    PRIMARY KEY("id"),
    FOREIGN KEY("match_id") REFERENCES "matches"("id"),
    FOREIGN KEY("stadium_id") REFERENCES "stadiums"("id"),
    FOREIGN KEY("zone_id") REFERENCES "zones"("id")
);

CREATE INDEX "search_matches_by_away_team" ON "matches"("away_team");
CREATE INDEX "search_matches_by_home_team" ON "matches"("home_team");
CREATE INDEX "search_matches_by_match_date" ON "matches"("match_date");
CREATE VIEW "available_matches" AS
-- view that select available matches
SELECT "matches"."id", "home_team","away_team","match_date","stadiums"."name" FROM "matches"
                 JOIN "stadiums" ON "stadiums"."id" = "matches"."stadium_id"
                 WHERE "ended" = 0 ORDER BY "match_date" ;
