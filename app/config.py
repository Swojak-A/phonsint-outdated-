import os


class BaseConfig:
    DEBUG = False
    TESTING = False


class DevelopmentConfig(BaseConfig):
    DEBUG = True
    SECRET_KEY = os.getenv("SECRET_KEY", "v3ry-s3cr37")


config_selector = {"dev": DevelopmentConfig, "default": DevelopmentConfig}
