import bs4 as bs
import urllib.request
import unicodedata


def main():
    source_code = urllib.request.urlopen('https://www.lphs.net/domain/207').read()
    bs_code = bs.BeautifulSoup(source_code, 'lxml')

    # First Announcements in list
    section1 = bs_code.find_all('div', class_='ui-article-description')[0]
    section2 = section1.find_all('p')
    
    # Extract Today's Date from HTML source code
    date = (section2[0].text)[:-6]
    day = date.split(',')[0]
    
    dismissal = ""
    birthday = ''
    announcements = []

    wordCount = 0
    for announcement in section1.text.split("\n"):
        # Gets the birtdays
        if announcement.find("Happy birthday") > -1:
            birthday = announcement.strip("Happy birthday to")
            
        # Gets the dismissal time
        if announcement == "1:46 dismissal" or announcement == "11:20 dismissal":
            dismissal = announcement.strip("dismissal")

        # Gets announcements
        if announcement.find("________") != -1:
            continue

        announcement = unicodedata.normalize("NFKD", announcement)

        if announcement == '':
            continue

        if announcement == ' ':
            continue
        
        if announcement.find("  ") != -1:
            announcement = announcement.strip("  ")
        
        announcements.append(announcement)

        # Calculate total word count
        
        for word in announcement.split():
            wordCount += 1
        
    #chop off data & birthday from start of announcement 
    if day == "Wednesday":
        announcements = announcements[3:]
    else:
        announcements = announcements[2:]

    #announcements = "".join(announcements)
    
    #default dismissal time to 2:40 if not early out
    if dismissal == "":
        dismissal = "2:40"

    # caclculate announcement time
    rate = 150 / 60

    totalSec = wordCount / rate
    avgMin = (int) (totalSec / 60 )
    avgSec = (int) ((totalSec - (totalSec // 1)) * (3/5) * 100)
    
    avgTime = " ~ {}m {}s ".format(avgMin, avgSec)


    return date, birthday, announcements, dismissal, avgTime, day

    
    
main()