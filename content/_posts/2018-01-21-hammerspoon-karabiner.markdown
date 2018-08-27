---
layout: post
title: |
    A More Productive OSX:
    Hammerspoon
date:   2018-01-21
category: tech
title-img: hammerspoon.png
description: An overview of how I use Hammerspoon and Karabiner-Elements to boost my productivity
---

##### Hammerspoon and Karabiner-Elements are all you need for a frictionless OSX experience

A couple months ago, I got my mac fixed (hard drive gave up on me!) by the wonderful [Apples and Oranges](www.applesandoranges.net/) and it was good as new. For some reason, I was compelled to look up "how to use mac" as if there was a proper way to use it. Maybe I was just scared it would break again. I ended up learning a lot about how others use the system in more productive ways. 

There are actually a lot of really cool (also not free :( ) apps like [Things](https://culturedcode.com/things/), [Omnifocus](https://www.omnigroup.com/omnifocus/), [Fantastical](https://flexibits.com/fantastical). Out of all of the apps that I tried, here were only two that I still use regularly: __Hammerspoon__ and __Karabiner-Elements__.

[**Hammerspoon**](http://www.hammerspoon.org/) is a wrapper around OSX, allowing you to easily interact with the OS via scripting, such as trigger notifications, move and resize windows, open applications, etc.

[**Karabiner\-Elements**](https://github.com/tekezo/Karabiner-Elements) is a keyboard customization tool. I use this to remap keys to make it simple to trigger my Hammerspoon scripts from the keyboard.

__Note: gifs in this article were compressed for display on the site. Actual usage is much smoother and free of gif artifacts. Try it out for yourself!__

#### Features

* [position](#position) - Instantly resize windows into halves and thirds, or expand to fullscreen.
* [focus](#focus) - Shift focus (i.e. click) onto an app, or launch it if it's not open
* [monitor](#monitor) - Move windows between external monitors, or between [spaces](https://support.apple.com/kb/ph25574?locale=en_US)
* [gcal](#gcal) - Menu bar to see all of your upcoming Google Calendar events
* [timer](#timer) - Pomodoro timer to keep you focused

# position

Window positioning module [borrowed](https://gist.github.com/teknofire/a311390d0427c09e7be6044d09c8d372) from Miro Mannino.

`hyper + right` resizes window to right side of screen.

`hyper + left` resizes window to left side of screen.

`hyper + up` resizes window to upper side of screen.

`hyper + down` resizes window to bottom side of screen.

Repeated presses of above keys will cycle window to take up half, quarter, and 2/3 of screen.

`hyper + enter` resizes window to entire screen

Repeated presses of `hyper + enter` will cycle through resizing similarly.

![Position gif]({{ "/gifs/position.gif" | absolute_url}})

# focus

File containing hotkey bindings. Each segment binds a hotkey to a useful application - such as `hyper + c` to launch `Google Chrome`

![Focus gif]({{ "/gifs/focus.gif" | absolute_url}})

# monitor 

Keybindings used to interact with an external monitor, or between spaces within a monitor. Very useful for moving applications back and forth.

`hyper + shift + right` cycles the current application to monitor on the right

`hyper + shift + keft` cycles the current application to monitor on the left

`hyper + shift + h` moves the current application to a space on the left

`hyper + shift + l` moves the current application to a space on the right

![Spaces gif]({{ "/gifs/spaces.gif" | absolute_url}})

# gcal

Constructs a menubar. Uses the Google Calendar API to fetch events, colors, timing, etc. to a json file, which are then loaded into the menubar on each refresh.

![Calendar gif]({{ "/photos/hammerspoon-karabiner/calendar.png" | absolute_url}})

# timer

A simple pomodoro timer! Sets a default time for 25 minutes, with option to pause and cancel.

![Timer gif]({{ "/gifs/timer.gif" | absolute_url}})

# How to use

## Karabiner-Elements

Karabiner\-Elements is a relatively new tool made when OSX Sierra came out. As a result, installing it is a bit of a hassle as it’s still under continuous development. Follow the instructions in the `How to Build` section in the link [above](https://github.com/tekezo/Karabiner-Elements). It requires installing C++ Boost Libraries, XCode Build tools beforehand but should compile into a standalone application, which doesn’t need to be compiled every time you update.

edit: [it can now be downloaded directly as a binary!](https://pqrs.org/osx/karabiner/)

Use Karabiner to make a `hyper` key. I rebinding my `caps lock` key (which I never use) into `ctrl+alt+cmd`. Do this by editing your `karabiner.json` file located in `~/.config/karabiner`. [See my file here that you can copy/paste](https://github.com/kev-zheng/hammerspoon/blob/master/karabiner.json)

## Hammerspoon

Download the [latest release](https://github.com/Hammerspoon/hammerspoon). I recommend familiarizing with it through the getting started guide [here](http://www.hammerspoon.org/go).

Hammerspoon interacts with the operating system using the Lua language, which is an easy to learn scripting language. Whenever hammerspoon is loaded or refreshed, your `~/.hammerspoon/init.lua` file is processed. You can use the console as a REPL for lua code.

To start, I defined the hyperkey

`init.lua`
```
hyper = {"ctrl", "alt", "cmd"}
```

and followed the [docs](http://www.hammerspoon.org/docs/hs.application.html#launchOrFocus) to build the focusing hotkey

`focus.lua`
```

    hs.hotkey.bind(hyper, "C", function ()
      hs.application.launchOrFocus('Google Chrome')
    end)
    
    hs.hotkey.bind(hyper, 'E', function ()
      hs.application.launchOrFocus('Visual Studio Code')
    end)
    
```

The file `focus.lua` is separate from `init.lua`. To activate this code, all I need to do is include `focus.lua`

`init.lua`
```
require('focus')
```

Hammerspoon has a great community that have built a ton of other [spoons](https://github.com/Hammerspoon/Spoons) and [sample configurations](https://github.com/Hammerspoon/hammerspoon/wiki/Sample-Configurations). For instance, I borrowed the fantastic [resizing hotkey](https://github.com/miromannino/miro-windows-manager) functionality from another user.

##### Thanks for reading! Check out the [repository](https://github.com/kev-zheng/hammerspoon/) for my configuration.