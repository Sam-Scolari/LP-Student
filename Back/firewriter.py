from scripts import announcements, cafeteria
import firebase_admin
from firebase_admin import credentials, firestore
import datetime

class Firewriter:

    def __init__(self):
        self.cred = credentials.Certificate('./ServiceAccountKey.json')
        self.default_app = firebase_admin.initialize_app(cred)
        self.db = firestore.client()

    def UpdateCafeteria(self): # should run at 5am, 6am, 3pm, 4pm (probably will combine with annoucements later)
        cafeteriaData = cafeteria.main()

        document = db.collection(u'generalData').document(u''+datetime.datetime.today().weekday)
     
        document.update({
            u'lunch': cafeteriaData[0],
            u'breakfast': cafeteriaData[1],
        })
    
    def UpdateAnnouncements(self): # should run at 5am, 6am, 3pm, 4pm (probably will combine with cafeteria later)
        announcementData = announcements.main()

        document = db.collection(u'generalData').document(u''+datetime.datetime.today().weekday)
     
        document.update({
            u'date': announcementData[0],
            u'birthdays': announcementData[1],
            u'announcements': announcementData[2], # must be an array
            u'time': announcementData[4],
            u'dismissal': announcementData[3],
        })
    
    def UpdateBalance(self, user): # should run for each user at 7am, 10am, 1pm
        document = db.collection(u'users').document(u''+user)
     
        document.update({u'balance': 5})