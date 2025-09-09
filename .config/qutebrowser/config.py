config.load_autoconfig(False)

c.url.searchengines = {
        'DEFAULT': 'https://duckduckgo.com/?q={}',
        'g':       'https://google.com/search?q={}',
        'y':      'https://www.youtube.com/results?search_query={}',
        'w':       'https://en.wikipedia.org/wiki/{}',
}

c.completion.open_categories = ['quickmarks', 'bookmarks', 'history']

config.load_autoconfig() # load settings done via the gui

c.auto_save.session = True # save tabs on quit/restart

config.bind('h', 'open -t qute://history/')
config.bind('tH', 'config-cycle tabs.show multiple never')
config.bind('s', 'hint links')
config.bind('S', 'hint links tab')
config.bind('K', 'tab-next')
config.bind('J', 'tab-prev')
config.bind('x', 'tab-close')
config.bind('X', 'undo')
config.bind('D', 'undo')
config.bind('e', 'cmd-set-text -s :open {url}')
config.bind('E', 'cmd-set-text -s :open -t {url}')
config.bind('d', 'scroll-page 0 0.5', mode='normal')
config.bind('u', 'scroll-page 0 -0.5', mode='normal')
config.bind('<Ctrl-Shift-P>', 'open -p')
config.bind('<Ctrl-Shift-N>', 'open -p')
config.bind('<Ctrl-Shift-j>', 'tab-move -', mode='normal')
config.bind('<Ctrl-Shift-k>', 'tab-move +', mode='normal')
config.bind('c', 'open -t -- {primary}', mode='normal')
config.bind('j', 'scroll-px 0 125')
config.bind('k', 'scroll-px 0 -125')

c.scrolling.smooth = False
c.content.autoplay = False
c.content.headers.user_agent = 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36'
c.completion.shrink = True
c.completion.height = '35%'
c.content.blocking.method = 'both'
c.content.blocking.adblock.lists = [
    "https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/filters.txt",
    "https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/badware.txt",
    "https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/privacy.txt",
    "https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/unbreak.txt",
    "https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/resource-abuse.txt",

    "https://easylist.to/easylist/easylist.txt",
    "https://easylist.to/easylist/easyprivacy.txt",
]

# dark mode setup
c.colors.webpage.darkmode.enabled = True
c.colors.webpage.darkmode.algorithm = 'lightness-cielab'
c.colors.webpage.darkmode.policy.images = 'never'
c.colors.webpage.darkmode.policy.page = 'smart'
c.colors.webpage.preferred_color_scheme = 'dark'
config.set('colors.webpage.darkmode.enabled', False, 'file://*')
config.set('colors.webpage.darkmode.enabled', False, '*://*.youtube.com/*')
config.set('colors.webpage.darkmode.enabled', False, '*://www.google.com/*')
config.set('colors.webpage.darkmode.enabled', False, '*://*.discord.com/*')
config.set('colors.webpage.darkmode.enabled', False, '*://*.whatsapp.com/*')

c.zoom.default = '125%'
c.colors.tabs.odd.bg = '#333333'
c.colors.tabs.even.bg = '#333333'
c.tabs.padding = {'top': 5, 'bottom': 5, 'left': 9, 'right': 9}
c.tabs.indicator.width = 0 # no tab indicators
c.tabs.width = '7%'
c.tabs.show = "multiple"
c.tabs.new_position.unrelated = 'next'
c.tabs.favicons.scale = 1.0
c.tabs.select_on_remove = 'prev' 

# fonts
c.fonts.default_size = '14pt'
c.fonts.default_family = 'JetBrainsMono'

# privacy - adjust these settings based on your preference
# config.set("completion.cmd_history_max_items", 0)
# config.set("content.private_browsing", True)
config.set("content.webgl", False, "*")
#config.set("content.canvas_reading", False)
config.set("content.geolocation", False)
config.set("content.webrtc_ip_handling_policy", "default-public-interface-only")
config.set("content.cookies.accept", "all")
config.set("content.cookies.store", True)
# config.set("content.javascript.enabled", False)
