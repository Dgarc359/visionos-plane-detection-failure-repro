Following along with this example: [Link](https://developer.apple.com/documentation/visionos/placing-content-on-detected-planes)


The implementation is simple, but it is as follows:
* Create an immersive view that creates an ARKitSession and instantiates the PlaneDetectionProvider
* Leverage the plane detection provider to add a text entity to a plane that matches some conditions

The code fails due to an error with plane detection not being supported on the device
during simulation.

This code was tested on an M1 macbook pro using vision os sdk v1.0 running xcode-beta 2. As of
October 15, 2023, the simulation will fail out when the immersive space is opened.
