from libqtile import bar
from libqtile import widget
from libqtile.widget import base

from utils.requirements import has_package

class Icon(base.ThreadPoolText):
    
    defaults = [
        ("font", "sans", "Text font"),
        ("fontsize", None, "Font pixel size. Calculated if None."),
        ("fontshadow", None, "font shadow color, default is None(no shadow)"),
        ("padding", None, "Padding left and right. Calculated if None."),
        ("foreground", "#ffffff", "Foreground colour."),
        ("predicate", None, "Callback to show"),
        ("colors", [], "The colors"),
        ("requirement", None, "The required package"),
        ("update_interval", 2, "Callback to show")
    ]  # type: list[tuple[str, Any, str]]

    def __init__(self, text=" ", **config):
        if not config.get('foreground'):
            config.setdefault('foreground', config.get('colors')[1])

        base.ThreadPoolText.__init__(self, text=text, **config)
        self.add_defaults(Icon.defaults)

    def poll(self):
        if self.requirement and not has_package(self.requirement):
            return None

        self.foreground = self.colors[0] if self.predicate() else self.colors[1]
        self.draw()
        return self.text if self.update_interval > 0 else None
