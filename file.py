import os
# script to format the csvs into the insertion.sql file 
def format_sql(file):
    table_name = f"{file.replace("data/","").replace(".csv","")}"
    with open(file, "r") as f:
        final=f"\n\n--{table_name} table\nINSERT INTO {table_name} ({f.readline().replace("﻿","").strip("\n")}) VALUES"

        for line in f.readlines():
            line = line.replace("\n","")
            line = line.replace("\"", "'")

            if table_name != "locations":
                data_handle = line.split(",")
                items = []
                for item in data_handle:
                    if "'" not in item:
                        try:
                            item = int(item)
                        except:
                            try: 
                                item=float(item)
                            except:
                                item = f"'{item}'"
                    items.append(item)
                line = (str(items).replace("\"","").strip("[]"))

            final += f"\n({line}),"
        final = final[:-1] + ';'
    return final

path = "/home/ezra/Projects/Databases/assignment1/dat1-26-02-shf-assignment-1-ezra-stentor/data"
files = []
for e in os.scandir(path):
    if e.is_file(): files.append(f"data/{e.name}")

insertion_data = ""
for file in files:
    insertion_data += format_sql(file)
print(insertion_data)

with open("src/insertion.sql", "w") as f:
    f.write(".open fittrackpro.db\n.mode column\n")
    f.write(insertion_data)