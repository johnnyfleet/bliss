# CI/CD Ideas

I want to make my CI/CD pipeline more sophisticated. At the moment I've got quite a crude setup. This repo itself doesn't add more significant logic - essentially marrying the latest blisshq version into a docker file and keep it up to date with patches etc. 

Essentially what I need to manage is: 
1. Monitor and build the latest version of the blisshq version (maybe last 5-10 for those that want it). Update each time there is a new one.
2. Update each time there is a new version of the base image/os. This is akin to patching and maintenance. This needs to marry a specific version of the base image to a specific version of the blisshq version. 
3. Update the builds each time I make a change to the dockerfile which configures everything. 

These 3 are separate but also have overlapping dependencies for when to update. 

Looking for insipiration, I came across https://github.com/hertzg/rtl_433_docker. That too performs a similar function - marrying multiple versions of rtl_433 with several versions of base image. 

These notes are writtent to help me flesh out my thinking for how to make this all work - with that project as a guide. 

