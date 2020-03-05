from i3pystatus import Status
from i3pystatus.weather import wunderground
from socket import gethostname

status = Status()

# Displays clock like this:
# Tue Jul 30 11:59:46 PM KW31
#                          ^-- calendar week
status.register("clock",
                format="%a %b %-d %Y | %X",
                color="#D4AF37",)

if gethostname() == "polar":
    status.register("network",
                    format_up="WiFi: {essid}",
                    interface="wlo1",
                    color_up="#D4AF37",
                    on_leftclick="networkmanager_dmenu",
                    )

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
#         location_code='95356', # Modesto
#         units='imperial',
#         forecast=True,
#     ),
# )

status.register("pulseaudio",
                format="Volume: {volume}",
                color_muted="#705D18",
                color_unmuted="#D4AF37",)

if gethostname() == "polar":
    status.register("battery",
                    format="{status} - {percentage:.2f}% {remaining:%E%hh:%Mm}",
                    alert=True,
                    alert_percentage=5,
                    status={
                        "DIS":  "Discharging",
                        "CHR":  "Charging",
                        "FULL": "Bat full",
                    },
                    color="#D4AF37",)

status.run()
