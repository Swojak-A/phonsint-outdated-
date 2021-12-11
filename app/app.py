from flask import Flask

from config import config_selector


def create_app(config_name: str):
    app = Flask(__name__)
    app.config.from_object(config_selector[config_name])

    from modules.index.views import index_blueprint

    app.register_blueprint(index_blueprint)

    return app
