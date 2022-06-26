from libqtile.config import Group
from icons import RECTANGLE_ICON

groups = [Group(i, label=RECTANGLE_ICON) for i in "123456789"]

groups[0].persist = True
