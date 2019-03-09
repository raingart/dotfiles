#!/usr/bin/env python3

"""
Readme
"""

# _Settings____________________________________________________________________
# DEBUG_MODE = True
DEBUG_MODE = False
CONFIG_PATH = ('~/.local/gmail_config.cfg')
# _____________________________________________________________________________


import sys
import os
import time
import configparser
import argparse
import feedparser
import webbrowser
from urllib import parse
from urllib.request import FancyURLopener


MODULE_LIST_DEPENDENCE = [
    "pip",
    "sys",
    "os",
    "time",
    "configparser",
    "argparse",
    "feedparser",
    "webbrowser",
    "urllib"
]


def module_exists_local(MODULE_NAME):
    # import sys
    if not MODULE_NAME in sys.modules.keys():
        print("local ImportError: %s" % MODULE_NAME)
        # import pip
        # pip.main(['install', MODULE_NAME])
    else:
        debug_echo("%s -> %s" % ("import", MODULE_NAME))


# check in system
def module_exists_sys(MODULE_NAME):
    try:
        __import__(MODULE_NAME)
    except ImportError:
        print("pip install: %s" % MODULE_NAME)
        # import pip
        # pip.main(['install', '--user', MODULE_NAME])
        # import MODULE_NAME
        # return False


def module_import(MODULE_LIST=False):
    if not MODULE_LIST:
        print("module_list_dependence not exist")
        return False

    for item in MODULE_LIST:
        module_exists_sys(item)
        module_exists_local(item)


def get_args():
    # import argparse
    parser = argparse.ArgumentParser(
        description='In interactive mode you able to manage your keys.'
    )
    parser.add_argument(
        # ,nargs='?', default=CONFIG_PATH,
        '-c', '--config', help='Specify a config file.'
    )
    parser.add_argument(
        '-d', '--debug', action='store_true', help='Enables full logging, including debug information.'
    )
    args = parser.parse_args()

    if args.config:
        global CONFIG_PATH
        CONFIG_PATH = args.config

    if args.debug:
        global DEBUG_MODE
        DEBUG_MODE = args.debug


def debug_echo(MSG="test msg"):
    if DEBUG_MODE:
        print(">> %s" % (MSG))
        # log.debug('>>', exc_info=True)
    # else:
    #   return False


def parse_config(CONFIG_PATH="./gmail_config.cfg", CONFIG_SECTION='profile'):
    # import configparser
    # HOME = os.environ['HOME']
    if CONFIG_PATH.startswith('~'):
        CONFIG_PATH = os.path.expanduser("~") + CONFIG_PATH[1:]

    debug_echo("reading config file:" + CONFIG_PATH)
    try:
        config_file = configparser.ConfigParser()
        config_file.read(CONFIG_PATH)

        user = config_file.get(CONFIG_SECTION, 'user')
        passwd = config_file.get(CONFIG_SECTION, 'passwd')

    except Exception as e:
        raise print(str(e), " could not read config file")
        # import sys
        # sys.exit()

    url = get_mail_url(user, passwd)
    return url


def get_mail_url(USER, PWD):
    return 'https://%s:%s@mail.google.com/mail/feed/atom' % (USER, PWD)


def send_noti(HEAD="mail notify", MSG="test", LEVEL="low"):
    level = {
        LEVEL == 'low': "low",
        LEVEL == 'normal': "normal",
        LEVEL == 'critical': "critical"
    }[True]
    # import os
    # --icon=mail-forward
    # return os.system('notify-send "%s" "%s" -u %s' % (HEAD, MSG, level))


def open_rss_link(URL):
   #  import feedparser
   #  import webbrowser
   #  from urllib import parse
    rss = feedparser.parse(URL)
    max_open_email = 5
    debug_echo("Feed Title %s" % rss.feed.title)
    
    if (len(rss.entries) > int(max_open_email)):
       webbrowser.open_new_tab('https://mail.google.com/')
       print("to many open new mail!")

    else:
       for entry in rss.entries:
          debug_echo("Title: %s" % entry.title)
          debug_echo("link: %s" % entry.link)
          
          if entry.author == "Patreon (no-reply@patreon.com)":
             debug_echo("skip: %s" % entry.author)
             continue
             
          f=parse.parse_qsl(parse.urlsplit(entry.link).query)
          message_id=dict(f)['message_id']
          debug_echo("message_id: %s" % message_id)
          
          # webbrowser.open_new_tab(entry.link)
          webbrowser.open_new_tab('https://mail.google.com/mail/u/0/h/?&v=c&th=' + message_id)


    # return entry.link


def get_gmail(URL):
   #  from urllib.request import FancyURLopener
    opener=FancyURLopener()
    page=opener.open(URL)
    contents=page.read().decode('utf-8')
    # print(contents)
    ifrom=contents.index('<fullcount>') + 11
    ito=contents.index('</fullcount>')

    fullcount=contents[ifrom:ito]

    if int(fullcount) > 0:
        ed="mail"
        if int(fullcount) > 1:
            ed += "s"

        send_noti("Gmail", "%s %s" % (fullcount, ed))
        debug_echo(" %s" % fullcount)
        return contents

    elif int(fullcount) != 0:
        print("gmail format xml is changed")
        send_noti("Gmail Critical error:", "xml format is broken", "critical")
    else:
        debug_echo("not found new mail")

    return False


# def check_inet_connect(IP="8.8.8.8"):
#   # import os
#   # import time
#   ## import threading
#   hostname = "network"
#   reconnect_sec = 10
#   response = os.system('ping -c 3 %s -c1 >/dev/null 2>&1' % IP)

#   if int(response) == 0:
#      debug_echo(hostname + " is up!")
#      return True
#   else:
#      debug_echo(hostname + " is down!")
#      debug_echo("Trying to reconnect in %s seconds" % reconnect_sec)
#      time.sleep(reconnect_sec)
#      check_inet_connect(IP)

def main():
    try:
        get_args()
        module_import(MODULE_LIST_DEPENDENCE)
        debug_echo("Working...")

        #  if check_inet_connect():
        mail_url=parse_config(CONFIG_PATH)
        new_gmail=get_gmail(mail_url)
        # print(new_gmail)
        if new_gmail:
            open_rss_link(new_gmail)

    except IOError as e:
        #  print("I/O error: {0}".format(e))
        print("I/O error: {0}")
    except KeyboardInterrupt:
        return print("Keyboard: interruption")
        #  print(" shutting down...")
    # except:
    # 	print("Fatal error:", sys.exc_info()[0])
    # 	sys.exit(33)
    # 	raise
    # else:
        # print('else!')
    finally:
        print("")
        debug_echo("done!")
        sys.exit()


if __name__ == '__main__':
    main()
