from subprocess import run

def exec(command):
    return run(['bash', '-c', command], capture_output=True, text=True)
