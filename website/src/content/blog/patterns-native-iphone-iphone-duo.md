---
title: 'Patterns Is Going Native on iPhone. iPhone Duo Is Next'
description: 'We are rebuilding Patterns for iPhone in Swift. Here is what we are working on, why the update takes care, and how iPhone Duo fits into the plan.'
date: '2026-11-17'
updated: '2026-11-17'
readingMinutes: 5
excerpt: 'The iPhone version of Patterns is being rebuilt in Swift. We want to get it into people’s hands quickly, then give iPhone Duo a proper experience of its own.'
ogSubtitle: 'Native Swift iPhone app in progress. iPhone Duo follows.'
category: personal-stories
contentType: personal-essay
draft: false
tags: [patterns, ocd-apps, personal]
keywords: 'Patterns native iPhone app, Patterns Swift iOS, Patterns iPhone Duo, Patterns app update, OCD app for iPhone Duo'
related: [why-i-built-patterns, what-is-patterns-ocd-app, why-patterns-stays-private]
---

<p class="lead">
Patterns is being rebuilt as a native iPhone app in Swift. The work is underway now, and we are trying to get it to people as quickly as we can while checking the things an update must get right. After that, our next priority is a proper, complete Patterns experience on iPhone Duo, built for the phone when it is both closed and open.
</p>

If you use Patterns on iPhone today, you are using the current Flutter version. It remains the app you can [download now](/get). The Swift version is not released yet, and there is no date to announce today. This is an update on what we are building and the order we plan to ship it in.

## Why rebuild Patterns for iPhone in Swift?

Patterns began as one app built with Flutter for more than one platform. That helped me get a private journal, OCD event tracker, and between-session tools into people's hands. I am keeping that work available while rebuilding the iPhone side with SwiftUI, Apple's native interface framework.

The point is to make the iPhone app feel at home on the device it runs on. That includes the way navigation, text sizes, accessibility, and system features behave. A rewrite is not a claim that the existing app is broken, or that changing the language will magically change someone's experience of OCD. It is a product decision about how I want to build and maintain the iPhone app from here.

Android is not being rewritten as part of this iPhone work. Patterns on Android will continue to use Flutter. The native iPhone app is intended to arrive as an update to the existing iOS app, rather than ask people to start over with a second download.

## The parts that cannot be rushed

Recreating screens is only one part of a rewrite. A journal entry, tracker event, practice record, setting, or backup already on someone's phone needs to remain usable after an update. The Swift project is being built to read the existing app's data, and we are testing compatibility in both directions. We are also checking accessibility, including larger text, screen-reader use, and the everyday tasks people need to complete in the app.

Those checks are why “as quickly as possible” cannot mean “ship before it is ready.” A private OCD journal carries information people may find hard to write down at all. Preserving that record matters more than meeting a date I have not earned the right to promise.

The app's role stays the same: a private place to notice patterns, journal, and support work between appointments. It does not diagnose OCD or replace care. If you are new to it, [this introduction to Patterns](/blog/what-is-patterns-ocd-app) explains what the current app does.

## iPhone Duo comes next

[Apple's iPhone Duo](https://www.apple.com/newsroom/2026/09/apple-unveils-iphone-duo/) opens from a compact outer display to a much larger inner display. I do not want Patterns to treat that extra space as a stretched phone screen. Once the native iPhone version is out, the next stage is to support Duo properly across the app, whether it is folded or open.

That means working through the real flows, not just making the home screen look good: writing and reading journal entries, tracking an event, using practice tools, and viewing insights. The larger display may make room for layouts such as notes beside an exercise, but those are design directions, not finished features. We will test the experience before calling it complete.

There is no separate Duo release date to share yet. The sequence is native iPhone first, then full Duo support as soon as we can build and verify it properly. You can follow that work on the [Patterns roadmap](/roadmap).

## Thank you for giving the work room to be careful

I built Patterns because I needed a tool that respected both the work of recovery and the privacy of the person doing it. That is still the standard for this rewrite. I want to move fast enough that people can use the improvements soon, and carefully enough that the update deserves their trust.

For now, the current Patterns app is available on [iPhone and Android](/get). I will share more when the native iPhone version and the Duo experience are ready to show, rather than turning an unfinished build into a promise.

## Sources

- [Apple: Introducing iPhone Duo](https://www.apple.com/newsroom/2026/09/apple-unveils-iphone-duo/)
