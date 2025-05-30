import csv
import io

import requests

url = "https://docs.google.com/spreadsheets/d/1x-7jKQ4U5jiAeSUPbGdwQ5YqOclsQ-WfiCbA1EBYrtk/export?format=csv"

footer = "};\n"


def save(langKey, values):
    parsed = langKey.split('|')
    firstName = parsed[1]
    secondName = parsed[2]
    fileName = "{}_{}".format(firstName, secondName.lower())
    mapName = "{}{}".format(firstName, secondName.upper())

    with open("lib/lang/{}.dart".format(fileName), "w") as result:
        result.write(
            "const Map<String, String> {} = ".format(mapName) + "{ \n")
        for keyVal in values:
            result.write("\t'{}': {},\n".format(
                keyVal[0], repr(keyVal[1]).replace('\\n', 'n')))
        result.write(footer)


response = requests.get(url)
assert response.status_code == 200, 'Wrong status code'
reader = csv.DictReader(io.StringIO(response.content.decode("utf-8")))
languages = {}
for row in reader:
    for rowKey in row:
        if rowKey == "Key":
            continue

        if rowKey in languages:
            languages[rowKey].append([row["Key"], row[rowKey]])
        else:
            languages[rowKey] = [[row["Key"], row[rowKey]]]

for lang in languages:
    save(lang, languages[lang])
