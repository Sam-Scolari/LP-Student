from selenium import webdriver
from selenium.webdriver.firefox.options import Options

import bs4 as bs

gpa = 0
cumulative_gpa = 0

options = Options()
options.add_argument("--headless")
driver = webdriver.Firefox(options=options)

driver.get("https://ps.lphs.net/public/")

username = driver.find_element_by_id("fieldAccount")
password = driver.find_element_by_id("fieldPassword")

username.send_keys("200276")
password.send_keys("972001")

signin = driver.find_element_by_id("btn-enter-sign-in")

signin.click()

page = driver.page_source
page2 = bs.BeautifulSoup(page, "lxml")

history = driver.find_element_by_id("btn-gradesHistory")
history.click()

page3 = driver.page_source
page4 = bs.BeautifulSoup(page3, "lxml")


def get_gpa():

    global gpa
    global cumulative_gpa

    table_items = page2.find_all('td')

    listitems = []
    for items in table_items:

        listitems.append(items)

    OneN = listitems[11].text
    TwoN = listitems[31].text
    ThreeN = listitems[51].text
    FourN = listitems[71].text
    FiveN = listitems[91].text
    SixN = listitems[111].text
    SevenN = listitems[131].text

    list_n = [OneN, TwoN, ThreeN, FourN, FiveN, SixN, SevenN]
    new_list_n = []


    for name in list_n:
        name.replace('/xa0', ' ')
        words = name.split()

        if words[1] == 'Details':
            new_list_n.append(words[0])

        elif words[2] == 'Details':
            new_list_n.append(words[0] + ' ' + words[1])

        elif words[3] == 'Details':
            new_list_n.append(words[0] + ' ' + words[1] + ' ' + words[2])

    OneG = listitems[17].text
    TwoG = listitems[37].text
    ThreeG = listitems[57].text
    FourG = listitems[77].text
    FiveG = listitems[97].text
    SixG = listitems[117].text
    SevenG = listitems[137].text

    list_g = [OneG, TwoG, ThreeG, FourG, FiveG, SixG, SevenG]
    newlist_g = []

    for item in list_g:
        strip_A = item.strip('A')
        strip_B = strip_A.strip('B')
        strip_C = strip_B.strip('C')
        strip_D = strip_C.strip('D')
        strip_F = strip_D.strip('F')
        strip_plus = strip_F.strip('+')
        strip_minus = strip_plus.strip('-')

        newlist_g.append(strip_minus)

    class_grade = {new_list_n[0]: newlist_g[0],
                   new_list_n[1]: newlist_g[1],
                   new_list_n[2]: newlist_g[2],
                   new_list_n[3]: newlist_g[3],
                   new_list_n[4]: newlist_g[4],
                   new_list_n[5]: newlist_g[5],
                   new_list_n[6]: newlist_g[6]}


    gpas = []

    for thing in class_grade.keys():
        if thing.endswith('*'):
            w_int = int(class_grade[thing])

            if 100 >= w_int >= 97:
                gpas.append(5.4)
            if 96 >= w_int >= 93:
                gpas.append(5.0)
            if 92 >= w_int >= 90:
                gpas.append(4.6)
            if 89 >= w_int >= 87:
                gpas.append(4.4)
            if 86 >= w_int >= 83:
                gpas.append(4.0)
            if 82 >= w_int >= 80:
                gpas.append(3.6)
            if 79 >= w_int >= 77:
                gpas.append(3.4)
            if 76 >= w_int >= 73:
                gpas.append(3.0)
            if 72 >= w_int >= 70:
                gpas.append(2.6)
            if 69 >= w_int >= 67:
                gpas.append(2.4)
            if 66 >= w_int >= 63:
                gpas.append(2.0)
            if 62 >= w_int >= 60:
                gpas.append(0.6)
            if 59 >= w_int >= 0:
                gpas.append(0.0)

        else:

            int_uw = int(class_grade[thing])
            if 100 >= int_uw >= 97:
                gpas.append(4.4)
            if 96 >= int_uw >= 93:
                gpas.append(4.0)
            if 92 >= int_uw >= 90:
                gpas.append(3.6)
            if 89 >= int_uw >= 87:
                gpas.append(3.4)
            if 86 >= int_uw >= 83:
                gpas.append(3.0)
            if 82 >= int_uw >= 80:
                gpas.append(2.6)
            if 79 >= int_uw >= 77:
                gpas.append(2.4)
            if 76 >= int_uw >= 73:
                gpas.append(2.0)
            if 72 >= int_uw >= 70:
                gpas.append(1.6)
            if 69 >= int_uw >= 67:
                gpas.append(1.4)
            if 66 >= int_uw >= 63:
                gpas.append(1.0)
            if 62 >= int_uw >= 60:
                gpas.append(0.6)
            if 59 >= int_uw >= 0:
                gpas.append(0.0)

    for points in gpas:
        gpa += points

    gpa /= 7

    print(gpa)


def get_cgpa():
    table_items = page4.find_all('td')

    listitems = []
    for items in table_items:
        listitems.append(items)

    print(listitems)

    OneG = listitems[2].text
    TwoG = listitems[6].text
    OneG = listitems[2].text
    OneG = listitems[2].text
    OneG = listitems[2].text
    OneG = listitems[2].text

    print(TwoG)
get_cgpa()