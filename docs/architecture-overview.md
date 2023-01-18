# Architecture Overview

Weather iOS's architecture tries to use best practices.

The goal of this document is to discuss principals that have influenced the architecture approach and provide details on how the project is structured.

## **Design Principles**

In the architecture design process, priority is placed on several key concepts for guidance:

1.  **Do NOT Reinvent the Wheel**

        Exploit as much as possible all of the things the platform already offers through its SDK,
        for obvious reasons.

        The -non extensive- list of tools we've built upon include: [CoreData, MapKit, Combine(FRP)]

2.  **Separation of concerns**

        Attempts have been made for a clean separation of concerns by splitting the app into several groups(folders):

        - Repositories:
          Handles CoreData interactions.

        - Extensions:
          Functions that extend in-built classes.

        - ViewModels:
          Contains th app's business logic.

        - Protocols:
          Contains our interfaces(protocols).

        - Services:
          Contains network, location and connectivity layers.

        - Views:
          Contains the app's UI built using SwiftUI.

        - Models:
          Contains our Data models and CoreData entities.

        - Utility:
          Contains helper functions and enums.

3.  **Testability**

        Attempts have been made to design classes with testability in mind. Using TDD preferred, BDD.
