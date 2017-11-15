#!/usr/bin/env python

from lxml import html
import requests
import json

page = requests.get('http://scu.ugr.es')
tree = html.fromstring(page.content)

#This will create a list of buyers:
buyers = tree.xpath('//*[@id="contenido"]/div[3]/table/tbody/tr[2]/td[1]/strong')
#This will create a list of prices
prices = tree.xpath('//*[@id="contenido"]/div[@class="content_doku"]/table')

print 'Buyers: ', buyers
print 'Prices: ', prices


for element in prices:
    print element.text
    for element2 in element:
        # print element2
        for element3 in element2:
            # print element3
            for element4 in element3:
                print element4.text


# with open('data.txt', 'w') as outfile:
#     json.dump(prices, outfile)
