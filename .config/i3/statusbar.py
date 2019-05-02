from i3pystatus import Status
from i3pystatus.weather import wunderground

status = Status()

# Displays clock like this:
# Tue Jul 30 11:59:46 PM KW31
#                          ^-- calendar week
status.register("clock",
    format="%a %b %-d %Y | %X",
    color="#D4AF37",)

status.register("spotify",
    format="{artist} - {title}",
    color="#fffcf0",
    on_middleclick="previous_song",
    on_rightclick="next_song",)

# status.register(
#     'weather',
#     format='{condition} {current_temp}{temp_unit}[ {icon}][ Hi: {high_temp}][ Lo: {low_temp}][ {update_error}]',
#     colorize=False,
#     interval=600,
#     color="#D4AF37",
#     hints={'markup': 'pango'},
#     on_leftclick=['check_weather'],
#     backend=wunderground.Wunderground(
#         api_key='18ae8a29d7f61ec6',
#         location_code='78705',
#         units='imperial',
#         forecast=True,
#     ),
# )

status.run()
