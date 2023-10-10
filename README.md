**Quick in - quick check in.**

The concept of using geofencing tools for Telegram mini-applications and chatbots.

Geofencing (geo - "geo" + fence) is an established concept for native mobile applications 
and a whole field of development for mobile service developers based on the user's location. 
Various technologies are used to implement geofencing services, such as GPS in the background, 
Bluetooth beacons, and Wi-Fi MAC address traps. All these technologies have low efficiency, 
require numerous user permissions, and are limited by mobile OS developers.

Working with such technologies also requires using native methods of mobile OS in the background mode,
 which is a challenging task for mobile applications and seemingly impossible for mini-applications 
 and chatbots that work within a native application.

Limitations, permissions, and security thresholds are undoubtedly necessary to maintain a balance 
between user convenience and data security. However, mini-applications and chatbots are much more 
applicable to the geofencing paradigm compared to native applications. They do not require downloading 
or complicated registration, using the Telegram user ID. Mini-services within the familiar messenger 
framework are easy to understand and convenient for quick launch in service and sales locations. 
However, chatbots and mini-applications do not have icons on the user's home screen and can get lost 
among other conversations, which is crucial for geofencing services and loyalty programs.

But what if chatbots and mini-applications can independently notify subscribers about the availability 
of nearby services, even when the Telegram application is inactive? Without requesting permissions 
to use background functions or indicating the collection of personal data? Imagine that we go to 
a restaurant, and the interactive restaurant menu addresses us by name, offering the dish of 
the day based on our preferences. When we arrive at a gas station, the Telegram mini-service 
suggests refueling without leaving the car, and a Smart City application at a bus stop informs 
us about the arrival time of our transport. In essence, a new field of application opens up 
for mini-applications and chatbots

**How does it work?**

On one hand, we have developed a technology for remotely and quickly saving the configuration 
of Wi-Fi networks on user devices, in just two clicks. This technology uses fully-native methods 
for iOS and Android, specifically for the next-generation Passpoint Wi-Fi networks. 
These methods do not require special permissions from mobile OS manufacturers or app stores regarding 
the collection of personal data.

On the other hand, we have also created methods for upgrading any routers running on the OpenWrt operating 
system to support the next-generation Passpoint networks. These routers can operate in two modes: router mode
 (providing internet access) and beacon mode (only capturing connection attempts without providing internet 
 access).

We have integrated the nodes of the system with an integration API that supports chatbots, mini-applications,
 and native iOS and Android applications.

As a result, users only need to add Wi-Fi networks to their devices with just two clicks, using any 
communication channel, such as an app or a mini-service. The beacons will then recognize the user 
in service and sales locations, creating presence events and notifying the service operator.

To give you a visual demonstration, we invite you to watch the following demo videos:

- Retail use case with native applications: https://youtu.be/aB7R1EaE87I?si=9hIV2TVkupYnlU_j 
- Chatbot use case for multifunctional citizen service centers: https://youtu.be/gkMpP5PPRmY

To experience the full functionality of the prototype on iOS:

1. Scan the QR code and launch the application. Link to image with the QR code https://ibb.co/cyRfRdj . 
If you cannot open the link with the QR code image ![](https://ibb.co/cyRfRdj).
create a qr code with the link https://quickin.app/new_design/?lang=en
![](https://ibb.co/cyRfRdj)
2. Save the Wi-Fi network.
3. Go to Telegram and start the chatbot.
4. After 1 minute, a scheduled event will occur, simulating a visit to the smart zone of a filling station.

For a detailed instruction video and a demonstration of the service's operation with beacons, 
without emulation, please follow https://youtu.be/_M2z7VK54VM.

P.S. Our team has a unique vision for the development of "proximity" services and valuable experience 
in implementation. The technology we are creating has multiple patents in Russia and the United States. 
We are ready for comprehensive collaboration and are planning to release a joint OpenWrt repository for 
the free distribution of beacons for the Telegram project. Cloud services and proximity service development 
tools are expected to follow a freemium model. Further integration of our developed methods into the 
Telegram application will enrich the ecosystem of Telegram's mini-applications and chatbots with new 
capabilities and a whole new direction of development.