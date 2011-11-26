NMA for Weechat
===============

Send private messages and highlights to your Android device via
the Notify My Android service (https://www.notifymyandroid.com)

Install
-------

This script requires the "ruby-notify-my-android" gem

    $ gem ruby-notify-my-android

Then load the nma-weechat.rb plugin into Weechat. Place it in the
~/.weechat/ruby directory:

    /ruby load nma-weechat.rb

It also requires a Notify My Android account.

Setup
-----

Set your Notify My Android API key.

    /set plugins.var.ruby.nma-weechat.apikey 123456789abcdefgh

Options
-------

plugins.var.ruby.nma-weechat.apikey

The API Key of your Notify My Android service.
Defaults to an empty string and must be set for nma-weechat to work.

plugins.var.ruby.nma-weechat.interval

The interval between notifications. Doesn't notify if the last notification 
was within x seconds. Defaults to 60 seconds.

Author
------

James Turnbull <james@lovedthanlost.net>
https://github.com/jamtur01/nma-weechat
http://www.kartar.net

License
-------

Apache 2.0

