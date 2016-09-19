Fourset-iOS
========

Getting started with the Fourset iOS App Source Code
--------------------------------------------------------

Pre-requisites: recent version of Mac OS with XCode installed

At the the terminal prompt, clone this repo onto your local machine:

    git clone https://github.com/fourset/user-iOS.git

Make sure you have the Cocoapods you need:

    cd user-iOS
    pod repo update
    pod install

Open the project in Xcode:

    open Fourset.xcworkspace

You may then build, run, and modify the code as usual in XCode.

When your modifications are ready (meaning they build successfully and all automated tests pass) you can commit the changes to this repository from within Xcode.  From the menus choose Source Control --> Commit.  A diff viewer will appear to illustrate the changes you've made.   Enter a brief commit message that explains your changes, select "Push to remote" then "Commit <n> Files and Push."

*Remember to check that the build completes without errors before committing code changes!*
