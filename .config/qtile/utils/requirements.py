from utils.exec import exec

def has_package(pkg):
    return exec('which {}'.format(pkg)).returncode == 0
