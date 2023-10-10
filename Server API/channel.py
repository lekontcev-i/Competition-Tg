"""
Это модуль каналов, он обеспечивает работу всех REST методов для работы с каналами
"""

from flask import make_response, abort
from config import db
from models import Project, Channel, ChannelSchema
import logging

logger = logging.getLogger("app.channel")

def create(pid, body, user, token_info): 
  """
  Это функция создаёт новый канал относительно переданного идентификатора проекта pid.

  :param pid:             Уникальный идентификатор проекта
  :param body:            JSON содержащий данные нового канала
  :param user:            Пользователь от лица которого сделан запрос
  :param token_info:      Объект содержащий закодированную в токене доступа информацию (JWT Claims)
  :return:                201 при успешном создание, 404 если не найден, 401 если ошибка авторизации
  """
  pid = int(pid)
  
  # Запрос разрешен только для администраторов
  if user == 'admin':
  
    # получаем родительский проект
    project = Project.query.filter(Project.project_id == pid).one_or_none()
    
    # Проверяем был ли найден проект
    if project is None:
      abort(404, f"Проект {pid} не найден")
    else:
      # body['project_id'] = pid
      # Создаем инстанс схемы канала
      schema = ChannelSchema()
      new_channel = schema.load(body, session=db.session)
      new_channel.project_id = pid
      
      # Добавляем канал к проекту и записываем в базуданных
      # project.channels.append(new_channel)
      
      db.session.add(new_channel)
      db.session.commit()
      
      # Сериализуем и возвращаем в ответе созданный канал
      schema = ChannelSchema(exclude = ['project'])
      data = schema.dump(new_channel)
      
      return data, 201
    
  else:
    logger.warning("...channel.create...ACCESS DENIED...user: {user}, pid: {pid}".format(user=user, pid=pid))
    abort(
      401,
      "Sorry user ({token_info}) is not allowed here".format(token_info=token_info),
    )


def read_one(pid, cid, user, token_info):
  """
  Это функция отвечает на запрос для endpoint /api/project/{pid}/channel/{cid}
  и возвращает канал с указанным ID, ассоциированный с указанным проектом.
  
  :param pid:             Уникальный идентификатор проекта
  :param cid:             Уникальный идентификатор канала
  :param user:            пользователь от лица которого сделан запрос
  :param token_info:      объект содержащий закодированную в токене доступа информацию (JWT Claims)
  :return:                json строка содержащая данные канала
  """
  
  tokenPid = token_info.get('pid')
  
  # Запрос разрешен для администраторов и владельцев канала
  if user == 'admin' or int(tokenPid) == int(pid):

    # Получаем канал из базы
    channel = (
      Channel.query
      .join(Project, Project.project_id == Channel.project_id)
      .filter(Project.project_id == pid)
      .filter(Channel.channel_id == cid)
      .one_or_none()
    )

    # Проверяем найден ли канал и если найден возвращаем данные
    if channel is not None:
      channel_schema = ChannelSchema(exclude=['project'])
      data = channel_schema.dump(channel)
      return data

    # Если, не найден, возвращаем 404
    else:
        abort(404, f"Канал {cid} не найден в проекте {pid}")
  else:
    logger.warning("...channel.read_one...ACCESS DENIED...user: {user}, pid: {pid}".format(user=user, pid=pid))
    abort(
      401,
      "Sorry user ({token_info}) is not allowed here. Check your project id {pid}".format(token_info=token_info, pid=pid),
    )

def update(pid, cid, body, user, token_info):
  """
  Эта функция обновляет существующий канал, привязанный к проекту с указанным pid
  
  :param pid:             Уникальный идентификатор проекта
  :param cid:             Уникальный идентификатор канала
  :param body:            JSON строка содержащая новые данные
  :param user:            пользователь от лица которого сделан запрос
  :param token_info:      объект содержащий закодированную в токене доступа информацию (JWT Claims)
  :return:                200 при успешном обновление, 404 если не найден, 401 если ошибка авторизации
  """

  tokenPid = token_info.get('pid')

  # Запрос разрешен для администраторов и владельцев канала
  if user == 'admin' or int(tokenPid) == int(pid):
        
    update_channel = (
        Channel.query
        .filter(Channel.project_id == pid)
        .filter(Channel.channel_id == cid)
        .one_or_none()
    )

    # Проверяем найден ли канал
    if update_channel is not None:

        # Превращаем переданный канал в объект БД
        schema = ChannelSchema()
        update = schema.load(body, session=db.session)

        update.project_id = update_channel.project_id
        update.channel_id = update_channel.channel_id

        # Объединяем объект со старым и записываем в БД
        db.session.merge(update)
        db.session.commit()
        
        schema = ChannelSchema(exclude=('project','channel_devices'))
        # Возвразаем обновлённый канал
        data = schema.dump(update_channel)

        return data, 200

    # Если не нашли канал
    else:
        abort(404, f"Канал {cid} не найден в проекте {pid}")
  else:
    logger.warning("...channel.update...ACCESS DENIED...user: {user}, pid: {pid}".format(user=user, pid=pid))
    abort(
      401,
      "Sorry user ({token_info}) is not allowed here. Check your project id {pid}".format(token_info=token_info, pid=pid),
    )
    
    
def delete(pid, cid, user, token_info):
  """
  Эта функция удаляет канал.
  
  :param pid:             Уникальный идентификатор проекта
  :param cid:             Уникальный идентификатор канала
  :param body:            JSON строка содержащая новые данные
  :param user:            пользователь от лица которого сделан запрос
  :param token_info:      объект содержащий закодированную в токене доступа информацию (JWT Claims)
  :return:                200 при успешном удаление, 404 если не найден, 401 если ошибка авторизации
  """
  
  # Запрос разрешен только для администраторов
  if user == 'admin':
  
    # Получаем запрошенный канал
    channel = (
      Channel.query
      .filter(Channel.project_id == pid)
      .filter(Channel.channel_id == cid)
      .one_or_none()
    )
  
    # Еслм нашли
    if channel is not None:
      db.session.delete(channel)
      db.session.commit()
      return make_response(
        "Канал {cid} удален".format(cid=cid), 200
      )
  
    # Еслм не нашли
    else:
      abort(404, f"Канал {cid} не найден в проекте {pid}")
  else:
    logger.warning("...channel.delete...ACCESS DENIED...user: {user}, pid: {pid}".format(user=user, pid=pid))
    abort(
      401,
      "Sorry user ({token_info}) is not allowed here. Check your project id {pid}".format(token_info=token_info, pid=pid),
    )
    
