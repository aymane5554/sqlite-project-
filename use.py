import sqlite3
import datetime;

conn = sqlite3.connect("project.db")
cur = conn.cursor()

def use(ticket_id):
    ct = datetime.datetime.now()
    cur.execute("""SELECT * FROM "tickets" WHERE "id" = ?
                """,(ticket_id,))
    rows = cur.fetchall()
    if len(rows) == 0 :
        return "ticket do not exist"
    u = rows[0][5]
    if u == 1 :
        return "ticket is already used, you cant enter"
    elif u == 0 :
        cur.execute("""UPDATE "tickets" SET "used" = 1 , "use_time" = ? WHERE "id" = ? """,(ct,ticket_id))
        conn.commit()
        return "..."
    else :
        return "something went wrong"

try :
    ticket_id = int(input("enter ticket id : "))
except ValueError :
    print("please enter a number : ")
else :
    print(use(ticket_id))
