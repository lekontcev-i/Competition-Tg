"""
Это модуль устройств, он обеспечивает работу всех REST методов для работы с усройствами
"""
from flask import abort
from models import ChannelDevice, ChannelDeviceSchema, Channel, Project, UserField
import logging

logger = logging.getLogger("app.channel_device")

def read_all(pid, cid, user, token_info, limit=100, offset=0):
  """
  Это функция возвращает список всех устройств.

  :param pid:             Идентификатор проекта
  :param cid:             Идентификатор канала
  :param body:            JSON содержащий данные нового канала
  :param user:            Пользователь от лица которого сделан запрос
  :param token_info:      Объект содержащий закодированную в токене доступа информацию (JWT Claims)
  :return:                200 при успешном создание,
                          404 если не найден канал или проект,
                          401 если ошибка авторизации
  """
  tokenPid = int(token_info.get('pid'))
  pid = int(pid)
  cid = int(cid)
  
  if user == 'admin' or tokenPid == pid:
  
    # Получаем запрошенный канал
    channel = (
      Channel.query
      .filter(Channel.project_id == pid)
      .filter(Channel.channel_id == cid)
      .one_or_none()
    )
    
    # Если нашли
    if channel:
      channel_devices = (
        ChannelDevice.query
        .outerjoin(UserField)
        .filter(ChannelDevice.channel_id == cid)
        .limit(limit)
        .offset(offset)
        .all()
      )
      
      channelDeviceSchema = ChannelDeviceSchema(many=True, exclude=(["channel"]))
      data = channelDeviceSchema.dump(channel_devices)
      return data
    
    # Еслм не нашли
    else:
      logger.warning(f"channel_device.read_all Канал {cid} не найден в проекте {pid}")
      abort(404, f"Канал {cid} не найден в проекте {pid}")
  else:
    logger.warning(f"channel_device.read_all...ACCESS DENIED...user: {user}, pid: {pid}")
    abort(401, f"Sorry user ({token_info}) is not allowed here. Check your project id {pid}",)
  
  
def delete_device(body, user, token_info):
  """
  Эта функция удаляет устройство в канале, проекте или во всей базе. По мак адресу либо хешу.
  
  :param pid:             Уникальный идентификатор проекта
  :param cid:             Уникальный идентификатор канала
  :param body:            JSON строка содержащая Mac или Hash
  :param user:            пользователь от лица которого сделан запрос
  :param token_info:      объект содержащий закодированную в токене доступа информацию (JWT Claims)
  :return:                200 при успешном удаление, 404 если не найден, 401 если ошибка авторизации
  """
  
  # Запрос разрешен только для администраторов
  if user == 'admin':
    # Получаем запрошенный канал
    logger.warning(f"channel_device.delete_device fired")
  else:
    logger.warning(f"channel_device.delete_device...ACCESS DENIED...user: {user}, pid: {pid}")
    abort(401, f"Sorry user ({token_info}) is not allowed here. Check your project id {pid}",)
