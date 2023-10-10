from flask import make_response, abort
from config import db
from models import AppUser, AppUserSchema
import uuid
import push_sender
import logging


logger = logging.getLogger("app.app_users")

def read_all():
    app_users = AppUser.query.order_by(AppUser.app_token).all()
    device_schema = AppUserSchema(many=True)
    data = device_schema.dump(app_users)
    return data


def read_one(app_token):
    logger.warning(f"read_one app_user: {app_token}")
    app_user = AppUser.query.filter(AppUser.app_token == app_token).one_or_none()

    if app_user is not None:
        device_schema = AppUserSchema()
        data = device_schema.dump(app_user)
        return data, 200
    else:
        logger.warning(f"read_one app_user not found: {app_token}")
        abort(
            404,
            "AppUser not found for Id: {app_token}".format(app_token=app_token),
        )


def create(app_user):
    logger.warning(f"create app_user: {app_user}")
    app_token = app_user.get("app_token")
    app_uuid = str(uuid.uuid4())

    existing_app_user = (
        AppUser.query.filter(AppUser.app_token == app_token)
        .one_or_none()
    )

    if existing_app_user is None:
        schema = AppUserSchema()
        app_user['app_uuid'] = app_uuid
        new_app_user = schema.load(app_user, session=db.session)
        db.session.add(new_app_user)
        db.session.commit()
        data = {'app_uuid': app_uuid }
        return data, 201
    else:
        logger.warning(f"create app_user exists already: {app_user}")
        abort(
            409,
            "AppUser {app_token} exists already".format(
                app_token=app_token
            ),
        )


def update(app_token, app_user):
    logger.warning(f"update app_user: {app_token}, {app_user}")
    update_app_user = AppUser.query.filter(
        AppUser.app_token == app_token
    ).one_or_none()

    if update_app_user is not None:
        schema = AppUserSchema()
        update = schema.load(app_user, session=db.session)
        update.id = update_app_user.app_token
        db.session.merge(update)
        db.session.commit()
        return '', 200
    else:
        logger.warning(f"update app_user not found: {app_token}, {app_user}")
        abort(
            404,
            "AppUser not found for Id: {app_token}".format(app_token=app_token),
        )


def delete(app_token):
    app_user = AppUser.query.filter(AppUser.app_token == app_token).one_or_none()

    if app_user is not None:
        db.session.delete(app_user)
        db.session.commit()
        return make_response(
            "AppUser {app_token} deleted".format(app_token=app_token), 200
        )
    else:
        abort(
            404,
            "AppUser not found for Id: {app_token}".format(app_token=app_token),
        )

def send_message(app_token, app_payload):
    app_user = AppUser.query.filter(
        AppUser.app_token == app_token
    ).one_or_none()
    if app_user is not None:
        push_sender.send_push(app_token,'fsiti notification', app_payload['app_message'])
        return '', 200
    else:
        abort(
            404,
            "AppUser not found for Id: {app_token}".format(app_token=app_token),
        )
