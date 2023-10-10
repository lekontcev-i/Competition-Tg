import bcrypt
import jwt
import logging
import re
import secrets
import string
from config import app
from datetime import datetime, timedelta

logger = logging.getLogger("app.auth")

secret = app.config["JWT_SECRET"]
algorithm = app.config["JWT_ALGORITHM"]
allowedAlgorithm = app.config["JWT_ALGORITMMS_ALOWED"]


def generate_random_digitals(stringLength=4):
  random_string_characters = string.digits
  return ''.join(secrets.choice(random_string_characters) for i in range(stringLength))


def generate_random_string(stringLength=8):
  random_string_characters = string.ascii_letters + string.digits + '-'
  return ''.join(secrets.choice(random_string_characters) for i in range(stringLength))


def decode_token(apikey, required_scopes):
  decoded = None
  #logger.warning("...decoding token...apikey: {apikey}, required_scopes: {required_scopes}".format(apikey=apikey, required_scopes=required_scopes))
  try:
    decoded = jwt.decode(apikey, secret, algorithm = allowedAlgorithm)
    logger.warning("!!!token...decoded: {decoded}".format(decoded=decoded))    
  except jwt.ExpiredSignatureError:
    logger.warning("!!! Signature had been expired !!!")
  except jwt.InvalidIssuedAtError:
    logger.warning("!!! iat claim is not a number !!!")
  except jwt.InvalidAlgorithmError:
    logger.warning("!!! Wrong Algorithm !!!")
  except jwt.exceptions.InvalidIssuerError:
    logger.warning("!!! Token’s iss claim does not match the expected issuer !!!")
  except jwt.exceptions.DecodeError:
    logger.warning("!!! Token cannot be decoded because it failed validation !!!")
  except jwt.exceptions.InvalidTokenError:
    logger.warning("!!! Invalid Token !!!")
    
  return decoded


def check_secret(user, token_info) -> str:
  logger.warning("...get_secret()...user: {user}, token_info: {token_info}".format(user=user, token_info=token_info))
  return '''
    Ваш user_id {user}.
    Ваш token заявляет: {token_info}.
  '''.format(user=user, token_info=token_info)
  
  
def hash_mac(mac):
  salt = app.config["MAC_HASH_SALT"]
  if  validate_mac_address(mac):
    mac = re.sub('[-:]', '', mac.lower())
  
    hashedMac = bcrypt.hashpw(mac.encode('utf-8'), salt.encode('utf-8'))
    hashedMac = re.sub('[^0-9a-zA-Z]', '-', hashedMac.decode().replace(salt, ''))
    
    return hashedMac
  else:
    return None
    
  
def validate_mac_address(mac):
  """
  Return True if it is a valid MAC address,
  otherwise return False.
  :param mac: Mac address string to validate
  """
  
  if re.match("[0-9a-f]{2}([-:]?)[0-9a-f]{2}(\\1[0-9a-f]{2}){4}$", mac.lower()):
    return True
  else:
    logger.warning(f"auth.validate_mac_address ...MAC VALIDATION FAIL... mac: {mac}")
    return False


def decodeHashes(hashes):
  if hashes is not None:
    if len(hashes) is 62:
      logger.warning(f"decodeHashes hashes: {hashes}")
      result = {
        'u_m': hashes[0:31],
        'r_m': hashes[31:62]
      }
      logger.warning(f"decodeHashes result: {result}")
      return result
    else:
      logger.warning(f"decodeHashes hash wrong length {hashes}")
      return None
  else:
    logger.warning("decodeHashes hash empty")
    return None
    
    
def decodeMacJWT(token):
  macSecret = app.config["MAC_JWT_SECRET"]
  decoded = None
  
  try:
    decoded = jwt.decode(token, macSecret)
    logger.warning("!!!token...decoded: {decoded}".format(decoded=decoded))    
  except jwt.ExpiredSignatureError:
    logger.warning("!!! Signature had been expired !!!")
  except jwt.InvalidIssuedAtError:
    logger.warning("!!! iat claim is not a number !!!")
  except jwt.InvalidAlgorithmError:
    logger.warning("!!! Wrong Algorithm !!!")
  except jwt.exceptions.InvalidIssuerError:
    logger.warning("!!! Token’s iss claim does not match the expected issuer !!!")
  except jwt.exceptions.DecodeError:
    logger.warning("!!! Token cannot be decoded because it failed validation !!!")
  except jwt.exceptions.InvalidTokenError:
    logger.warning("!!! Invalid Token !!!")
    
  if decoded is not None:
    return decoded
