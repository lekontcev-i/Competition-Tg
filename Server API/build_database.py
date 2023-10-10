from config import db
#from models import TgUser
#from models import VkUser
#from models import FbUser
#from models import WhatsappUser
#from models import AppUser
#from models import Device
#from models import WebpushUser

# API 2.0
from models import Project
from models import Channel
from models import ChannelDevice
from models import UserField
from models import PhoneValidation
# Create the database
db.create_all()
