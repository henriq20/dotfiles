from libqtile import hook
from libqtile import qtile

def setup():
    @hook.subscribe.setgroup
    def shift_windows_to_empty_group():
        for g in qtile.groups:
            if not g.windows and g.get_next_group().windows and not g.get_next_group().name == '1':
                for w in g.get_next_group().windows:
                    w.togroup(g.name)
