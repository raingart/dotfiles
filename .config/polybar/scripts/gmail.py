#!/usr/bin/env python3

# _Settings____________________________________________________________________
CONFIG_PATH = ('~/.local/gmail.cfg')
#  MAX_OPEN_EMAIL = 5
# _____________________________________________________________________________


import logging
import sys
import os
import configparser
import argparse
import feedparser
import webbrowser
import requests
from urllib import parse


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
        logging.basicConfig(level=logging.DEBUG)


def parse_config(PATH="./gmail.cfg", CONFIG_SECTION='profile'):
    global CONFIG_PATH
    try: CONFIG_PATH
    except NameError: CONFIG_PATH = PATH
    # import configparser
    # HOME = os.environ['HOME']
    if CONFIG_PATH and CONFIG_PATH.startswith('~'):
        CONFIG_PATH = os.path.expanduser("~") + CONFIG_PATH[1:]
    
    try:
        config_file = configparser.ConfigParser()
        config_file.read(CONFIG_PATH)

        global user
        user = config_file.get(CONFIG_SECTION, 'user')
        global passwd
        passwd = config_file.get(CONFIG_SECTION, 'passwd')

        logging.info("reading config file: %s" % CONFIG_PATH)

        return get_mail_url(user, passwd)

    except Exception as e:
        raise print(str(e), "could not read config file")


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
    os.system('notify-send "%s" "%s" -u %m' % (HEAD, MSG, level))


def open_rss_link(URL):
   #  import feedparser
    try:
       if not int(MAX_OPEN_EMAIL) > 1:
         MAX_OPEN_EMAIL = 10
    except NameError: MAX_OPEN_EMAIL = 10
    
    rss = feedparser.parse(URL)
    
    logging.info("Feed Title %s" % rss.feed.title)
    
    if (len(rss.entries) > int(MAX_OPEN_EMAIL)):
       webbrowser.open('https://mail.google.com/')
       logging.error("to many open new mail!")

    else:
       for entry in rss.entries:
          logging.info("Title: %s" % entry.title)
          logging.info("link: %s" % entry.link)
             
          f=parse.parse_qsl(parse.urlsplit(entry.link).query)
          message_id=dict(f)['message_id']
          logging.info("message_id: %s" % message_id)
          
          webbrowser.open('https://mail.google.com/mail/u/0/h/?&v=c&th=%s' % message_id)


    # return entry.link


def get_gmail(URL):
    #  import requests
    r = requests.get(URL)
       
    if r.status_code == 401:
       print("login [%s] or password [%s] is incorrect\n%s" %
       (user, passwd, 'Also try enable "Allow less secure apps" on https://myaccount.google.com/lesssecureapps'))
       return False
       
    elif r.status_code != 200:
       print("Requests error [%s] - %s" % (r.status_code, URL))
       return False
       
    contents = r.text
    ifrom=contents.index('<fullcount>') + 11
    ito=contents.index('</fullcount>')

    fullcount=contents[ifrom:ito]

    if int(fullcount) > 0:
        ed="mail"
        if int(fullcount) > 1:
            ed += "s"

        #  send_noti("Gmail", "%s %s" % (fullcount, ed))
        #  print(" %s" % fullcount)
        #  print(fullcount)
        return contents

    elif int(fullcount) != 0:
        print("gmail format xml is changed")
        send_noti("Gmail error:", "xml format is broken", "critical")
    else:
        logging.info("new mail not found")

    return False

def main():
    try:
        get_args()
        logging.info("Working...")
        mail_url=parse_config()
        if mail_url:
            new_gmail=get_gmail(mail_url)
            if new_gmail:
                open_rss_link(new_gmail)
            else:
                print('')
            
        logging.info("completed.")

    except IOError as e:
        print("I/O error: ".format(e))

    #  hide error msg
    #  finally:
        #  sys.exit()


if __name__ == '__main__':
    main()
