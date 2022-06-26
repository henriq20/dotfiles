from utils.exec import exec

from personal import HEADPHONES_MAC_ADDRESS

def is_headphones_connected():
    return exec(f"bluetoothctl info { HEADPHONES_MAC_ADDRESS } | awk '/Connected/ {{print $2}}'").stdout == 'yes\n'

def is_redshift_on():
    return exec("redshift -p | awk '/Period/ {print $2}'").stdout == 'Night\n'

def has_more_than_a_hundred_of_updates():
    return int(exec('checkupdates | wc -l').stdout) > 100
