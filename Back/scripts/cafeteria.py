import bs4 as bs
import urllib.request


def getBreakfast(dayData):
    breakfast = ''
    for x in dayData:
        if x.find('Breakfast menu:') != -1:
            breakfast = x.split(": ")[1]
    return breakfast

def getLunch(dayData):
    lunch = ''
    for x in dayData:
        if x.find('Lunch menu') != -1:
            try:
                lunch = x.split(": ")[1]
            except:
                lunch = x.split(":\xa0 ")[1]
    return lunch


def main():
    source_code = urllib.request.urlopen('https://www.lphs.net/Page/739').read()
    bs_code = bs.BeautifulSoup(source_code, 'lxml')

    menuItems = bs_code.find_all('div', class_='ui-article menuitems')

    data = {
        'Monday':{
            'Breakfast':'',
            'Lunch':''
        },
        'Tuesday':{
            'Breakfast':'',
            'Lunch':''
        },
        'Wednesday':{
            'Breakfast':'',
            'Lunch':''
        },
        'Thursday':{
            'Breakfast':'',
            'Lunch':''
        },
        'Friday':{
            'Breakfast':'',
            'Lunch':''
        },

        
    }

    # Define iteration vars
    weekdays = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday']
    ind = 0

    for day in menuItems:
        day = day.text
        # list of data in a given day
        items = day.split("\n")

        # Removes blank items in list of data
        for string in items: 
            if string == '':
                items.remove(string)
            elif string == '\xa0':
                items.remove(string)
            elif string == '&nbsp;':
                items.remove(string)

        print(items)

        
        # Gets the breakfast
        breakfast = getBreakfast(items)

        # Gets the lunch
        lunch = getLunch(items)

        #fill dictionary w/ food
        data[weekdays[ind]]['Breakfast'] = breakfast.capitalize()
        data[weekdays[ind]]['Lunch'] = lunch.capitalize()
        ind += 1
    print(data)
    return data

main()