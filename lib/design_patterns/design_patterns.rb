# “One object stands in for another” patterns:
# The first the Adapter pattern hides the fact that some object has the wrong
# interface by wrapping it with an object that has the right interface.
# The second was the Proxy pattern. A proxy also wraps another object, but not
# with the intent of changing the interface. Instead, the proxy has the same
# interface as the object that it is wrapping. The proxy isn’t there to
# translate; it is there to control. Proxies are good for tasks such as
# enforcing security, hiding the fact that an object really lives across the
# network, and delaying the creation of the real object until the last possible
# moment.
# The third is the decorator, which enables you to layer features on to a basic
# object.
