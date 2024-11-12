# molab-2024-09-keya
Mobile Lab - Fall 2024

## Week 01

**Daily Dose of Joy:** My project for this week basically gives you One happy word a day to keep any sadness away! 

As this week was all about getting to know swift , I decided to experiment with the basics and fundamentals of swift! I spent a couple of hours  this week unlearning and learning new syntax to get my for loops right! This playground uses loops, arrays, random and a timer to generate and display new words and emojis every second. I been following the [14 day Swift challenge and](https://www.hackingwithswift.com/quick-start/beginners/checkpoint-2) the [Swiftful Thinking](https://www.youtube.com/playlist?list=PLwvDm4VfkdpiLvzZFJI6rVIBtdolrJBVB) youtube playlist to learn.

## Week 02
**Teddy vs Panda: The Ascii showdown?** I couldn't tell which of the two txt files was cuter so decided to do a showdown of both!

I experimented with functions on swift further and tried shrinking the files

## Week 03
**Shape symphony**

This week, I explored the use of arrays to manage colors and experimented with the ForEach function to generate a dynamic grid of shapes. Using closures and a slider, I added interactivity, creating an engaging canvas with colors shapes and margins shift with a slide. I was curious about and tried to learn how `id: \.self` works along with Linear gradients

## Week 04
**Mindful Minutes**

For the audio and timer assignment, I tried to make something that is a much needed relaxing app, one where you can take a break from the world! Users can choose the duration of their experience as well as the backgrounds they like and will have a guided meditation that can be paused and played!
I found this easy to navigate with the resources and loved exploring different file types and assets and trying to get into fixing the UI a little!

## Week 05
**Mindfulness Minutes revamped**

This week, I improved last week's app by adding a Navigation View to the app with more options, allowing users to navigate between different sections. I also focused on exploring animations, trying out several effects like breathing circles, ripple effects, and gradient animations. While doing this, I encountered a preview error, which prevented me from fully viewing the app in the SwiftUI preview mode. As a result, I didn't concentrate much on perfecting the UI design for the app this week, instead spending more time playing around with the animations.

## Week 06
**Your Mindfulness Minutes**

This week's learning truly had me rolling up my sleeves and diving deep into Swift UI development. I faced numerous errors along the way,
for example:
`/Users/keyashah/Documents/ascii/week06/week06/LoginView.swift:34:47 Value of optional type 'URL?' must be unwrapped to refer to member 'path' of wrapped base type 'URL'` but was able to fix most of them and a little help from chatgpt in places where I was absolutely stuck
Navigating through Apple's documentation became my go-to, and it helped me overcome the challenges and learn many new swift keywords that make life easier than traditional statements. By the end of this week, I've built a version that allows users to log in and save their favorite meditations! I wanted to try to implement a sign up page as for now my users are hardcoded and I will try implementing this soon. Users can heart the meditation and itll be saved even when the app is rebuilt!
I personally enjoyed working with JSON files!

## Week 07
**Are you calm enough to meditate?**

Well, this process of learning to make an app is definitely teaching me patience and calmness and what's new with Mindfulness Minutes this week is that:
1. Last week's bug are fixed, I implemented the JSON storage using the example code from class and it works now!
2. I tried to implement the Face Mesh as a feature to tell the user if they are calm enough to meditate. Still raw in implementation and needs alot of edge cases to be tackled but I'm satisfied with the direction and will continue to improve it!

## Week 08  
**Is your creativity ready to have some fun?**  
This week, **Fun with Filters** introduces new features:
1. A Retro mode filter with smooth vignette.
2. A Sci-Fi mode with neon glow and glitch effects that pulsate, creating a futuristic vibe.  
3. A pop art mode!!
Excited to keep pushing creativity with more unique filters and effects!

While I tried filters, i also explored the storyboard for the launch page, which didnt work so thats on my to-do list for the next hw!

## Week 09
**FireBase App**


## Week 10
### Final Project Proposal
When we're stressed, overwhelmed, or in need of support, we often turn to therapists and caregivers. But when they're the ones feeling drained or burdened, who do they turn to?

Just as we’ve come to normalize seeking therapy and care for ourselves, it’s time we recognize the same need for caregivers. (AppName) is here to bridge that gap, catering to those who dedicate their lives to supporting others. With warmth, empathy, and an understanding of their unique challenges, (AppName) becomes the safe space for caregivers to return to—a place to recharge, find solace, and be cared for, after each long, selfless day.

Features:

- **Mood-to-Meditation Visualizer**
    - Since I spent many of my weekly homeworks to create and improve on a meditation app, Its time to make one that’ll actually serve a purpose. A feature where caregivers input their mood, which generates a unique visual and auditory experience designed to relax and soothe. Based on mood entries, different animations and soundscapes provide an immediate escape.
    - **Implementation**:
        - **SpriteKit:** For visually appealing animations that correspond with moods.
        - **AVFoundation**: To play relaxing audio that complements each mood visual.
        - **CoreML**: For mood recognition if using text entries.
- **Caregiver Success Moments & Gratitude Journal**
    - A reflective journal where caregivers can log positive moments or “wins” of the day. It encourages reflection and gratitude, enhancing self-worth and mental positivity after a long and tiring day.
    - **Implementation**:
        - **Firebase Storage**: To store text and media entries privately.
- **Time Off Scheduler & Sub Support**
    - Allows caregivers to (mandatorily) schedule “time-off” reminders and even provides options for locating respite care resources or backup support options - a much needed space for caregivers themselves.
    - **Implementation**:
        - **DatePicker and Calendar APIs**: For scheduling reminders.
        - **Firebase Firestore**: To store schedule preferences and manage reminders.
    
    Along with these features, I want to focus on the UI of the app to make it homely and reflect the warmth. I get overly ambitious while thinking about ideas and so have I here but promising myself to allow flexibility and room for any of these features to take a better shape along the way.
