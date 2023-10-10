## Description
fsiti-server provides an API for linking user devices with their messenger accounts, maintaining subscription categories and sending messages.

The basis of the application are:

* [connexion](https://connexion.readthedocs.io/en/latest/), [flask](http://flask.pocoo.org/) - for writing a swagger/openapi-first application in which the primary " The source of truth" is the swagger specification. Currently the version of swagger is 2.0
* [sqlalchemy](https://www.sqlalchemy.org/) as an ORM system
* [marshmallow-sqlalchemy](https://marshmallow-sqlalchemy.readthedocs.io/en/latest/) - for marshaling and validating data based on sqlalchemy schemas

You can see the methods used for processing contexts in swagger, in the `operationId` lines, which indicate the name of the file and the method that processes incoming data. All models are in the `models.py` file

Sending all pushes and messages lies in one file - `push_sender.py`.
Only sending push notifications to mobile platforms was tested; messengers need to be tested.

## Installation and configuration
### Requirements

*Python 3.6+
* pipenv
*postgresql 9+

### Installing the application

1. Install python 3.6 on the server. In centos it can be installed together from the epel repository with the command `yum install python36-setuptools.noarch python36-pip gcc libffi-devel python-devel`
2. Install `venv` in the project directory with the command `python3 -m venv env`
3. Create a group and user fsiti, with the home folder /srv/fsiti, with the shell /sbin/nologin
4. Clone the repository to the `/srv/fsiti` folder, changing the owner to fsiti
5. Deploy the virtual environment and install dependencies using the `pipenv install` command in the `/srv/fsiti` folder

### Application configuration

Configuration is done using the `app.config` file, which contains:

* database connection string
* Tokens and related data for VK, FaceBook, Viber, Telegram
* Connection string and path to credentials.json for firebase

### Create a database

To create a database you need:

1. Set up a connection to the database in `app.config`
2. Go to the `/srv/fsiti` folder and run the `pipenv shell` command
3. Run the command `python build_database.py`

There is no mechanism for migrating schemas, so when a schema is changed, either manual data transfer or cleaning is required

### Launching the development application

From `pipenv shell` run the command `python server.py`, the server will be accessible via http://localhost:5000

### Launching the application in production

Uses systemd, example service in `fsiti-gunicorn.service` file.

Start and stop via `systemctl {start,stop,restart} fsiti-gunicorn`

Logs - `journalctl -u fsiti-gunicorn`

Gunicorn is used for work; as the load increases, you can increase the number of workers.