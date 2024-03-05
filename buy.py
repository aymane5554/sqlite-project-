import sqlite3
from sys import argv
import datetime;


conn = sqlite3.connect("project.db")
cur = conn.cursor()


def buy(zone_id,match_id):

    cur.execute("""INSERT INTO "tickets" ("zone_id","match_id","stadium_id","price")
                VALUES (?,?,(SELECT "stadium_id" FROM "matches" WHERE "id" = ?),(SELECT "price" FROM "zones" WHERE "id" = ?))""",(zone_id,match_id,match_id,zone_id))
    conn.commit()
    return cur.lastrowid

cur.execute("""SELECT "matches"."id", "home_team","away_team","match_date","stadiums"."name" FROM "matches"
                 JOIN "stadiums" ON "stadiums"."id" = "matches"."stadium_id"
                 WHERE "ended" = 0 ORDER BY "match_date" """)
aml = []
for i in cur.fetchall():
    print(f"{i[0]} - {i[1]} vs {i[2]} at {i[3]} in {i[4]}")
    aml.append(i[0])

id = 0
try :
    id = int(input("choose the match (write the number): "))
except ValueError :
    print("write the number of the match")
else :
    if id in aml :
        cur.execute("""SELECT "id" , "name" , "capacity" FROM "zones" WHERE stadium_id IN (
                    SELECT "stadium_id" FROM "matches" WHERE "id" = ?
        )  """,(id,))
        zones = cur.fetchall()
        stadium_zones_ids = []
        print("available zones : ")
        for z in zones :
            cur.execute("""SELECT COUNT("id") AS "tickets sold" FROM "tickets"
                WHERE "match_id" = ? AND "zone_id" = ? """ ,(id,z[0]))
            zone_tickets = cur.fetchone()

            if z[2] > zone_tickets[0] :
                print(f"id : {z[0]} name : {z[1]} (remaining tickets : {z[2]-zone_tickets[0]})")
                stadium_zones_ids.append(z[0])
        try :
            zid = int(input("choose the zone (write the id): "))
        except ValueError :
            print("write the id")
        else :
            if zid in stadium_zones_ids :
                print("the id of your ticket :",buy(zid,id))

conn.close()
