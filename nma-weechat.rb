# James Turnbull <james@lovedthanlost.net>
# https://github.com/jamtur01/nma-weechat
# http://www.kartar.net
# (See below for LICENSE.)
#
# NMA for Weechat
# ---------------
#
# Send private messages and highlights to your Android device via
# the Notify My Android service (https://www.notifymyandroid.com)
#
# Install
# -------
#
#   This script requires the "ruby-notify-my-android" gem
#
#        $ gem ruby-notify-my-android
#
#   Then load the nma-weechat.rb plugin into Weechat. Place it in the
#   ~/.weechat/ruby directory:
#
#        /ruby load nma-weechat.rb
#
#   It also requires a Notify My Android account.
#
# Setup
# -----
#
#   Set your Notify My Android API key.
#
#        /set plugins.var.ruby.nma-weechat.apikey 123456789abcdefgh
#
# Options
# -------
#
#   plugins.var.ruby.nma-weechat.apikey
#
#       The API Key of your Notify My Android service.
#       Default: Empty string
#

require 'rubygems'
require 'ruby-notify-my-android'

SCRIPT_NAME = 'nma-weechat'
SCRIPT_AUTHOR = 'James Turnbull <james@lovedthanlost.net>'
SCRIPT_DESC = 'Send highlights and private messages in channels to your Android device via Notify My Android'
SCRIPT_VERSION = '0.1'
SCRIPT_LICENSE = 'APL'

DEFAULTS = {
  'apikey'          => "",
}

def weechat_init
  Weechat.register SCRIPT_NAME, SCRIPT_AUTHOR, SCRIPT_VERSION, SCRIPT_LICENSE, SCRIPT_DESC, "", ""
  DEFAULTS.each_pair { |option, def_value|
    cur_value = Weechat.config_get_plugin(option)
    if cur_value.nil? || cur_value.empty?
      Weechat.config_set_plugin(option, def_value)
    end
  }

  Weechat.print("", "nma-weechat: Please set your API key with: /set plugins.var.ruby.nma-weechat.apikey")

  Weechat.hook_signal("weechat_highlight", "notify", "")
  Weechat.hook_signal("weechat_pv", "notify", "")

  return Weechat::WEECHAT_RC_OK
end

def notify(data, signal, signal_data)

  if signal == "weechat_pv"
    event = "Private message"
  elsif signal == "weechat_highlight"
    event = "Highlight"
  end

  result = NMA.notify do |n|
    n.apikey = Weechat.config_get_plugin('apikey')
    n.priority = NMA::Priority::MODERATE
    n.application = "Weechat"
    n.event = event
    n.description = signal_data
  end

  return Weechat::WEECHAT_RC_OK
end

__END__
__LICENSE__

Copyright 2011 James Turnbull

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
