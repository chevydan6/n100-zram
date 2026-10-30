#!/usr/bin/env python3
"""Bounded, deterministic SQLite workload with no user data or network."""
import random,sqlite3,time
r=random.Random(429); db=sqlite3.connect(':memory:')
db.execute('create table documents (id integer primary key, category integer, title text, body text)')
words='compression memory kernel laptop browser compiler energy latency storage benchmark system application'.split()
for start in range(0,12000,500):
 rows=[]
 for i in range(start,start+500):
  body=' '.join(r.choices(words,k=90)) + ' ' + format(r.getrandbits(64),'016x')
  rows.append((i,i%37,'Document '+str(i),body))
 db.executemany('insert into documents values (?,?,?,?)',rows)
db.execute('create index category_idx on documents(category)');db.commit()
end=time.monotonic()+25
while time.monotonic()<end:
 for k in range(37):
  list(db.execute('select id,title,length(body) from documents where category=? order by title limit 30',(k,)))
