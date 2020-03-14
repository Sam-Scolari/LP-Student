from scripts import announcements, cafeteria
import firebase_admin
from firebase_admin import credentials, firestore

# Initialize Firestore Database
cred = credentials.Certificate('./ServiceAccountKey.json')
default_app = firebase_admin.initialize_app(cred)
db = firestore.client()

def Update():
    #breakfast & lunch 
    data = cafeteria.main()
    print(data)

    #date, birthdays, list of whole announcement, dismissal time, and average read time
    data2 = announcements.main()

    mon = db.collection(u'generalData').document(u'monday')
    tue = db.collection(u'generalData').document(u'tuesday')
    wed = db.collection(u'generalData').document(u'wednesday')
    thu = db.collection(u'generalData').document(u'thursday')
    fri = db.collection(u'generalData').document(u'friday')

    mon.update({
        u'lunch': data['Monday']['Lunch'],
        u'breakfast': data['Monday']['Breakfast']
    })

    tue.update({
        u'lunch': data['Tuesday']['Lunch'],
        u'breakfast': data['Tuesday']['Breakfast']
    })

    wed.update({
        u'lunch': data['Wednesday']['Lunch'],
        u'breakfast': data['Wednesday']['Breakfast']
    })

    thu.update({
        u'lunch': data['Thursday']['Lunch'],
        u'breakfast': data['Thursday']['Breakfast']
    })

    fri.update({
        u'lunch': data['Friday']['Lunch'],
        u'breakfast': data['Friday']['Breakfast']
    })
    day = data2[5]
    if day == "Monday":
        mon.update({
            u'date': data2[0],
            u'birthdays': data2[1],
            u'announcements': data2[2],
            u'time': data2[4],
            u'dismissal': data2[3],
        })
    
    if day == "Tuesday":
        tue.update({
            u'date': data2[0],
            u'birthdays': data2[1],
            u'announcements': data2[2],
            u'time': data2[4],
            u'dismissal': data2[3],
        })
    
    if day == "Wednesday":
        wed.update({
            u'date': data2[0],
            u'birthdays': data2[1],
            u'announcements': data2[2],
            u'time': data2[4],
            u'dismissal': data2[3],
        })

    if day == "Thursday":
        thu.update({
            u'date': data2[0],
            u'birthdays': data2[1],
            u'announcements': data2[2],
            u'time': data2[4],
            u'dismissal': data2[3],
        })

    if day == "Friday":
        fri.update({
            u'date': data2[0],
            u'birthdays': data2[1],
            u'announcements': data2[2],
            u'time': data2[4],
            u'dismissal': data2[3],
        })

    

Update()