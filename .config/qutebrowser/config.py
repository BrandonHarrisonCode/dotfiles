# Uncomment this to still load settings configured via autoconfig.yml
# config.load_autoconfig()

# Enable privoxy adblocking
#config.set('content.proxy', 'http://localhost:8118')

# Turn on Qt HighDPI scaling. This is equivalent to setting
# QT_AUTO_SCREEN_SCALE_FACTOR=1 in the environment. It's off by default
# as it can cause issues with some bitmap fonts. As an alternative to
# this, it's possible to set font sizes and the `zoom.default` setting.
# Type: Bool
c.qt.highdpi = True

# Turn on autoplay. Allows the broswer to automatically start playing <video> tags in new tabs.
config.set('content.autoplay', False)

# Integration with lastpass
config.bind('pq', 'spawn --userscript qute-lastpass')
config.bind('pe', 'spawn --userscript qute-lastpass --username-only')
config.bind('pw', 'spawn --userscript qute-lastpass --password-only')

# Enable duckduckgo like bang syntax
c.url.searchengines = {
    'DEFAULT':  'https://google.com/search?hl=en&q={}',
    '!a':       'https://www.amazon.com/s?k={}',
    '!d':       'https://duckduckgo.com/?ia=web&q={}',
    '!dd':      'https://thefreedictionary.com/{}',
    '!e':       'https://www.ebay.com/sch/i.html?_nkw={}',
    '!fb':      'https://www.facebook.com/s.php?q={}',
    '!gh':      'https://github.com/search?o=desc&q={}&s=stars',
    '!gist':    'https://gist.github.com/search?q={}',
    '!gi':      'https://www.google.com/search?tbm=isch&q={}&tbs=imgo:1',
    '!gn':      'https://news.google.com/search?q={}',
    '!ig':      'https://www.instagram.com/explore/tags/{}',
    '!m':       'https://www.google.com/maps/search/{}',
    '!p':       'https://pry.sh/{}',
    '!r':       'https://www.reddit.com/search?q={}',
    '!sd':      'https://slickdeals.net/newsearch.php?q={}&searcharea=deals&searchin=first',
    '!t':       'https://www.thesaurus.com/browse/{}',
    '!tw':      'https://twitter.com/search?q={}',
    '!w':       'https://en.wikipedia.org/wiki/{}',
    '!yelp':    'https://www.yelp.com/search?find_desc={}',
    '!yt':      'https://www.youtube.com/results?search_query={}'
}


# Always restore open sites when qutebrowser is reopened.
# Type: Bool
c.auto_save.session = True

# Enable JavaScript.
# Type: Bool
config.set('content.javascript.enabled', True, 'file://*')

# Enable JavaScript.
# Type: Bool
config.set('content.javascript.enabled', True, 'chrome://*/*')

# Enable JavaScript.
# Type: Bool
config.set('content.javascript.enabled', True, 'qute://*/*')

# Allow websites to show notifications
config.set('content.notifications', True)

# Allows gmail to become the default email handler
config.set('content.register_protocol_handler', True, 'https://mail.google.com?extsrc=mailto&url=%25s')

# Allows google calendar to become the default calendar handler
config.set('content.register_protocol_handler', True, 'https://calendar.google.com?cid=%25s')

# Languages to use for spell checking. You can check for available
# languages and install dictionaries using scripts/dictcli.py. Run the
# script with -h/--help for instructions.
# Type: List of String
# Valid values:
#   - af-ZA: Afrikaans (South Africa)
#   - bg-BG: Bulgarian (Bulgaria)
#   - ca-ES: Catalan (Spain)
#   - cs-CZ: Czech (Czech Republic)
#   - da-DK: Danish (Denmark)
#   - de-DE: German (Germany)
#   - el-GR: Greek (Greece)
#   - en-AU: English (Australia)
#   - en-CA: English (Canada)
#   - en-GB: English (United Kingdom)
#   - en-US: English (United States)
#   - es-ES: Spanish (Spain)
#   - et-EE: Estonian (Estonia)
#   - fa-IR: Farsi (Iran)
#   - fo-FO: Faroese (Faroe Islands)
#   - fr-FR: French (France)
#   - he-IL: Hebrew (Israel)
#   - hi-IN: Hindi (India)
#   - hr-HR: Croatian (Croatia)
#   - hu-HU: Hungarian (Hungary)
#   - id-ID: Indonesian (Indonesia)
#   - it-IT: Italian (Italy)
#   - ko: Korean
#   - lt-LT: Lithuanian (Lithuania)
#   - lv-LV: Latvian (Latvia)
#   - nb-NO: Norwegian (Norway)
#   - nl-NL: Dutch (Netherlands)
#   - pl-PL: Polish (Poland)
#   - pt-BR: Portuguese (Brazil)
#   - pt-PT: Portuguese (Portugal)
#   - ro-RO: Romanian (Romania)
#   - ru-RU: Russian (Russia)
#   - sh: Serbo-Croatian
#   - sk-SK: Slovak (Slovakia)
#   - sl-SI: Slovenian (Slovenia)
#   - sq: Albanian
#   - sr: Serbian
#   - sv-SE: Swedish (Sweden)
#   - ta-IN: Tamil (India)
#   - tg-TG: Tajik (Tajikistan)
#   - tr-TR: Turkish (Turkey)
#   - uk-UA: Ukrainian (Ukraine)
#   - vi-VN: Vietnamese (Viet Nam)
c.spellcheck.languages = ['en-US']

# Bindings for insert mod
config.bind('<Alt+Backspace>', 'fake-key <ctrl+shift+left> ;; fake-key <delete>', mode='insert')
config.bind('<Alt+b>', 'fake-key <ctrl+left>', mode='insert')
config.bind('<Alt+d>', 'fake-key <ctrl+shift+right> ;; fake-key <delete>', mode='insert')
config.bind('<Alt+f>', 'fake-key <ctrl+right>', mode='insert')
config.bind('<Ctrl+Shift+_>', 'fake-key <ctrl+z>', mode='insert')
config.bind('<Ctrl+d>', 'fake-key <delete>', mode='insert')
config.bind('<Ctrl+k>', 'fake-key <shift-end> ;; fake-key <delete>', mode='insert')
config.bind('<Ctrl+a>', 'fake-key <home>', mode='insert')
config.bind('<Ctrl+b>', 'fake-key <left>', mode='insert')
config.bind('<Ctrl+e>', 'fake-key <end>', mode='insert')
config.bind('<Ctrl+f>', 'fake-key <right>', mode='insert')
config.bind('<Ctrl+n>', 'fake-key <down>', mode='insert')
config.bind('<Ctrl+p>', 'fake-key <up>', mode='insert')
